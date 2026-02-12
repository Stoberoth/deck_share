
import 'package:deck_share/home/domain/auth_repository.dart';

class AuthService {
  final AuthRepository repository;

  AuthService(this.repository);

  Future<void> login(String email, String password) async
  {
    await repository.login(email, password);
  }

  Future<void> register(String email, String password) async
  {
    await repository.register(email, password);
  }

  Future<void> logout() async
  {
    await repository.logout();
  }
}