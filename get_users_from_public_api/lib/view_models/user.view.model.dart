import 'package:get_users_from_public_api/contracts/iuser.provider.dart';
import 'package:get_users_from_public_api/models/user.dart';
import 'package:get_users_from_public_api/providers/user.provider.dart';

class UserViewModel {
  List<User> users = [];

  IUserProvider provider = UserProvider();

  Future<void> loadUsersFromPublicApi() async {
    var users = await provider.getUsersAsync();
    setUsers(users);
  }

  void setUsers(List<User> users) {
    this.users.clear();
    for (var user in users) {
      this.users.add(user);
    }
  }
}