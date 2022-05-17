import 'dart:convert';

import 'package:mvvm_provider/commum_utils/podos/users.dart';
import 'package:mvvm_provider/commum_utils/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class UserRepositoryApi extends UserRepository {
  @override
  Future<List<User>> getData({bool start = true}) async {
    var url = "";
    var headers = {};
    // await http.get(Uri.tryParse(url), headers: headers).then((response) {
    //   if (response.statusCode == 200) {
    //     var body = json.decode(response.body);
    //   }
    // });
    return [];
  }

  @override
  Future<User> getDataByID(String idUser) {
    // TODO: implement getDataByID
    throw UnimplementedError();
  }

  @override
  Future<String> save(User user) {
    // TODO: implement save
    throw UnimplementedError();
  }

  Future<String> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
