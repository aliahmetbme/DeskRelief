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
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
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
        // UserModel üzerinden JSON oluştur (default değerler için)
        final newUser = UserModel(
          id: userCredential.user!.uid,
          name: name,
          email: email,
        );

        final userMap = newUser.toJson();
        // Firestore nested object serializasyon hatasını önlemek için manuel dönüşüm
        userMap['progress'] = newUser.progress.toJson();

        userMap['createdAt'] = FieldValue.serverTimestamp();
        userMap['lastActiveAt'] = FieldValue.serverTimestamp();

        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userMap);
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
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        if (isSignUp) {
          // Yeni kullanıcı oluştur (Sign Up akışında)
          final newUser = UserModel(
            id: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email ?? '',
          );

          final userMap = newUser.toJson();
          // Firestore nested object serializasyon hatasını önlemek için manuel dönüşüm
          userMap['progress'] = newUser.progress.toJson();

          userMap['createdAt'] = FieldValue.serverTimestamp();
          userMap['lastActiveAt'] = FieldValue.serverTimestamp();

          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set(userMap);
        } else {
          // Giriş başarısız (Sign In akışında kayıtlı kullanıcı yok)
          await signOut();
          return loc.errorUserNotFound;
        }
      } else {
        // Mevcut kullanıcı - son görülme güncelle
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .update({'lastActiveAt': FieldValue.serverTimestamp()});
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
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        if (isSignUp) {
          // Yeni kullanıcı oluştur (Sign Up akışında)
          final newUser = UserModel(
            id: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email ?? '',
          );

          final userMap = newUser.toJson();
          // Firestore nested object serializasyon hatasını önlemek için manuel dönüşüm
          userMap['progress'] = newUser.progress.toJson();

          userMap['createdAt'] = FieldValue.serverTimestamp();
          userMap['lastActiveAt'] = FieldValue.serverTimestamp();

          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set(userMap);
        } else {
          // Giriş başarısız (Sign In akışında kayıtlı kullanıcı yok)
          await signOut();
          return loc.errorUserNotFound;
        }
      } else {
        // Mevcut kullanıcı - son görülme güncelle
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .update({'lastActiveAt': FieldValue.serverTimestamp()});
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

  Future<UserModel?> getUserModel(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<void> updateUser(UserModel user) async {
    final userMap = user.toJson();
    // Freezed modellerinin toJson metodu nested objeleri map olarak döndürür
    // ama FieldValue gibi özel tipleri kaybeder.
    // Ancak burada FieldValue kullanmıyoruz, sadece verileri güncelliyoruz.
    await _firestore
        .collection('users')
        .doc(user.id)
        .set(userMap, SetOptions(merge: true));
  }

  Future<void> updateRegistrationProgress(
    String uid,
    Map<String, dynamic> progressUpdate,
  ) async {
    await _firestore.collection('users').doc(uid).update({
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
