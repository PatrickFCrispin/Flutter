import 'dart:convert';
import 'package:get_users_from_public_api/contracts/iuser.provider.dart';
import 'package:get_users_from_public_api/models/user.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://jsonplaceholder.typicode.com";

class UserProvider implements IUserProvider{
  @override
  Future<List<User>> getUsersAsync() async {
    String uri = "$baseUrl/Users";
    var response = await http.get(Uri.parse(uri));
    Iterable collection = jsonDecode(response.body);
    var users = collection.map((user) => User.fromJson(user)).toList();
    return users;
  }
}