import 'package:deskrelief/features/auth/domain/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProfileRepository {
  Stream<UserModel?> getUserStream(String uid);
  Future<void> updateProfile(UserModel user);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference<UserModel> _usersRef;

  ProfileRepositoryImpl() {
    _usersRef = _firestore.collection('users').withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data();
        if (data == null) throw Exception('User data is null');
        return UserModel.fromJson({...data, 'id': snapshot.id});
      },
      toFirestore: (model, _) => model.toJson(),
    );
  }

  @override
  Stream<UserModel?> getUserStream(String uid) {
    return _usersRef.doc(uid).snapshots().map((snapshot) => snapshot.data());
  }

  @override
  Future<void> updateProfile(UserModel user) {
    return _usersRef.doc(user.id).set(user, SetOptions(merge: true));
  }
}
