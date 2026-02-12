import 'package:deck_share/home/domain/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  @override
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  @override
  Future<User?> login(String email, String password) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }


  @override
  Future<void> logout() async {
    await _auth.signOut();
  }
  
  @override
  Future<User?> register(String email, String password) async {
    UserCredential credential =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }
}
