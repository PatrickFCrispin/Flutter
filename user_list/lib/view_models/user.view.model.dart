import 'package:user_list/models/user.dart';

class UserViewModel {
  List<User> users = [];
  String? name;
  String? phone;
  String? email;
  bool isBusy = false;

  Future<void> newUser(UserViewModel viewModel) async {
    isBusy = true;
    await Future.delayed(Duration(milliseconds: 1500));
    users.add(User(
      id: users.isEmpty ? 0 : users.last.id! + 1,
      name: viewModel.name,
      phone: viewModel.phone,
      email: viewModel.email,
    ));
    isBusy = false;
  }
  
  void removeUser(int index) => users.removeAt(index);
  
  void refreshUserList() => users;
}