import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart' as gsi;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/user_model.dart';
import '../../../../l10n/app_localizations.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Type-safe Firestore collection referansı.
  late final CollectionReference<UserModel> _usersRef;

  AuthService() {
    _usersRef = _firestore.collection('users').withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data();
        if (data == null) throw Exception('User data is null');
        return UserModel.fromJson({...data, 'id': snapshot.id});
      },
      toFirestore: (model, _) => model.toJson(),
    );
  }

  Future<String?> signIn({
    required String email,
    required String password,
    required AppLocalizations loc,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Firestore doküman kontrolü
      final userDoc = await _usersRef.doc(userCredential.user!.uid).get();
      if (!userDoc.exists) {
        await _auth.signOut();
        return loc.errorUserNotFound;
      }

      return null; // Başarılı
    } on FirebaseAuthException catch (e) {
      debugPrint("❌ FIREBASE SIGN IN ERROR [${e.code}]: ${e.message}");
      return _mapErrorCode(e.code, loc);
    } catch (e) {
      debugPrint("❌ UNKNOWN SIGN IN ERROR: $e");
      return loc.errorUnknown;
    }
  }

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
    required AppLocalizations loc,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        final newUser = UserModel(
          id: userCredential.user!.uid,
          name: name,
          email: email,
        );

        // withConverter sayesinde direkt model set edilebilir.
        // Ancak createdAt gibi server side değerler için .update veya .set(merge: true) ile Map gerekebilir.
        // Burada basitlik adına Map kullanmaya devam edebiliriz veya server timestamp'i modele ekleyebiliriz.
        // Mevcut kod Map kullanıyor, withConverter ile de .set(newUser) diyebiliriz.
        await _usersRef.doc(userCredential.user!.uid).set(newUser);
        
        // Metadata güncellemeleri
        await _usersRef.doc(userCredential.user!.uid).update({
          'createdAt': FieldValue.serverTimestamp(),
          'lastActiveAt': FieldValue.serverTimestamp(),
        });
      }

      return null; // Başarılı
    } on FirebaseAuthException catch (e) {
      debugPrint("❌ FIREBASE SIGN UP ERROR [${e.code}]: ${e.message}");
      return _mapErrorCode(e.code, loc);
    } catch (e) {
      debugPrint("❌ UNKNOWN SIGN UP ERROR: $e");
      return loc.errorUnknown;
    }
  }

  Future<String?> signInWithGoogle({
    required AppLocalizations loc,
    bool isSignUp = false,
  }) async {
    try {
      final googleSignIn = gsi.GoogleSignIn.instance;
      await googleSignIn.initialize();

      final googleUser = await googleSignIn.authenticate();

      final googleAuth = googleUser.authentication;

      // Access token'ı yeni API ile alıyoruz (v7.0+)
      final authorization = await googleUser.authorizationClient
          .authorizeScopes(['email', 'profile']);

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authorization.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      // Firestore doküman kontrolü
      final userDoc = await _usersRef.doc(userCredential.user!.uid).get();

      if (!userDoc.exists) {
        if (isSignUp) {
          // Yeni kullanıcı oluştur (Sign Up akışında)
          final newUser = UserModel(
            id: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email ?? '',
          );

          await _usersRef.doc(userCredential.user!.uid).set(newUser);
          await _usersRef.doc(userCredential.user!.uid).update({
            'createdAt': FieldValue.serverTimestamp(),
            'lastActiveAt': FieldValue.serverTimestamp(),
          });
        } else {
          // Giriş başarısız (Sign In akışında kayıtlı kullanıcı yok)
          await signOut();
          return loc.errorUserNotFound;
        }
      } else {
        // Mevcut kullanıcı - son görülme güncelle
        await _usersRef.doc(userCredential.user!.uid).update({
          'lastActiveAt': FieldValue.serverTimestamp(),
        });
      }

      return null;
    } on FirebaseAuthException catch (e) {
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('canceled') ||
          errorStr.contains('cancelled') ||
          errorStr.contains('1000') ||
          errorStr.contains('1001') ||
          errorStr.contains('sign_in_canceled')) {
        return null;
      }
      debugPrint("❌ FIREBASE GOOGLE ERROR CODE: ${e.code}");
      return _mapErrorCode(e.code, loc);
    } on PlatformException catch (e) {
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('canceled') ||
          errorStr.contains('cancelled') ||
          errorStr.contains('1000') ||
          errorStr.contains('1001') ||
          errorStr.contains('sign_in_canceled')) {
        return null;
      }
      return loc.errorUnknown;
    } catch (e, stackTrace) {
      if (e is gsi.GoogleSignInException && e.code == gsi.GoogleSignInExceptionCode.canceled) return null;

      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('canceled') ||
          errorStr.contains('cancelled') ||
          errorStr.contains('1000') ||
          errorStr.contains('1001') ||
          errorStr.contains('sign_in_canceled')) {
        return null;
      }
      debugPrint("❌ GOOGLE AUTH ERROR: $e");
      debugPrint("📌 STACKTRACE: $stackTrace");
      return loc.errorUnknown;
    }
  }

  Future<String?> signInWithApple({
    required AppLocalizations loc,
    bool isSignUp = false,
  }) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
      final AuthCredential authCredential = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        authCredential,
      );

      // Firestore doküman kontrolü
      final userDoc = await _usersRef.doc(userCredential.user!.uid).get();

      if (!userDoc.exists) {
        if (isSignUp) {
          // Yeni kullanıcı oluştur (Sign Up akışında)
          final newUser = UserModel(
            id: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email ?? '',
          );

          await _usersRef.doc(userCredential.user!.uid).set(newUser);
          await _usersRef.doc(userCredential.user!.uid).update({
            'createdAt': FieldValue.serverTimestamp(),
            'lastActiveAt': FieldValue.serverTimestamp(),
          });
        } else {
          // Giriş başarısız (Sign In akışında kayıtlı kullanıcı yok)
          await signOut();
          return loc.errorUserNotFound;
        }
      } else {
        // Mevcut kullanıcı - son görülme güncelle
        await _usersRef.doc(userCredential.user!.uid).update({
          'lastActiveAt': FieldValue.serverTimestamp(),
        });
      }

      return null;
    } on FirebaseAuthException catch (e) {
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('canceled') ||
          errorStr.contains('cancelled') ||
          errorStr.contains('1000') ||
          errorStr.contains('1001') ||
          errorStr.contains('sign_in_canceled')) {
        return null;
      }
      debugPrint("❌ FIREBASE APPLE ERROR CODE: ${e.code}");
      return _mapErrorCode(e.code, loc);
    } on SignInWithAppleAuthorizationException catch (e) {
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('canceled') ||
          errorStr.contains('cancelled') ||
          errorStr.contains('1000') ||
          errorStr.contains('1001') ||
          errorStr.contains('sign_in_canceled')) {
        return null;
      }
      return loc.errorUnknown;
    } on PlatformException catch (e) {
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('canceled') ||
          errorStr.contains('cancelled') ||
          errorStr.contains('1000') ||
          errorStr.contains('1001') ||
          errorStr.contains('sign_in_canceled')) {
        return null;
      }
      return loc.errorUnknown;
    } catch (e) {
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('canceled') ||
          errorStr.contains('cancelled') ||
          errorStr.contains('1000') ||
          errorStr.contains('1001') ||
          errorStr.contains('sign_in_canceled')) {
        return null;
      }
      debugPrint("❌ APPLE AUTH ERROR: $e");
      debugPrint("❌ APPLE AUTH ERROR CODE: ${e.toString()}");
      return loc.errorUnknown;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    final googleSignIn = gsi.GoogleSignIn.instance;
    await googleSignIn.signOut();
  }

  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  Future<void> reloadUser() async {
    await _auth.currentUser?.reload();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
  String? get currentUserId => _auth.currentUser?.uid;

  Stream<UserModel?> userStream(String uid) {
    return _usersRef.doc(uid).snapshots().map((snapshot) => snapshot.data());
  }

  Future<UserModel?> getUserModel(String uid) async {
    final doc = await _usersRef.doc(uid).get();
    return doc.data();
  }

  Future<void> updateUser(UserModel user) async {
    await _usersRef.doc(user.id).set(user, SetOptions(merge: true));
  }

  Future<void> updateRegistrationProgress(
    String uid,
    Map<String, dynamic> progressUpdate,
  ) async {
    await _usersRef.doc(uid).update({
      'progress': progressUpdate,
    });
  }

  String _mapErrorCode(String code, AppLocalizations loc) {
    switch (code) {
      case 'invalid-email':
        return loc.errorInvalidEmail;
      case 'user-disabled':
        return loc.errorUserDisabled;
      case 'user-not-found':
        return loc.errorUserNotFound;
      case 'wrong-password':
      case 'invalid-credential':
        return loc.errorWrongPassword;
      case 'email-already-in-use':
        return loc.errorEmailAlreadyInUse;
      case 'operation-not-allowed':
        return loc.errorOperationNotAllowed;
      case 'weak-password':
        return loc.errorWeakPassword;
      case 'network-request-failed':
        return loc.errorNetworkRequestFailed;
      default:
        debugPrint("⚠️ [UNHANDLED ERROR CODE]: $code");
        return loc.errorUnknown;
    }
  }
}
