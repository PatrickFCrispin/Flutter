import 'package:get_users_from_public_api/models/user.dart';

abstract class IUserProvider {
  Future<List<User>> getUsersAsync();
}