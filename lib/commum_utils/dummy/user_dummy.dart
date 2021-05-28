import 'package:mvvm_provider/commum_utils/podos/users.dart';
import 'package:mvvm_provider/commum_utils/repositories/user_repository.dart';

class UserDummy extends UserRepository {
  List<User> listUser = [];
  var model = {
    "id_user": "01",
    "display_name": "Syafrizal Fiqih",
    "email": "rizal@gmail.com",
    "phone_number": "0812xxxxxxxx",
    "address": "Medan, Jln Mabar Hilir Rumah otong hewan",
  };

  ///Function for get-all data user mimic
  ///@return List<User>
  @override
  Future<List<User>> getData({bool start = true}) async {
    if (start) listUser.add(User.fromJson(model));
    return listUser;
  }

  ///Function for get single data user by id-user
  ///@return User user
  ///#param String idUser
  @override
  Future<User> getDataByID(String idUser) async {
    User user = listUser.where((user) => user.idUser == idUser).first;
    return user;
  }

  ///Function save data user
  ///@return String idUser
  ///#param User user
  @override
  Future<String> save(User user) {
    if (user?.idUser != null) {
      int index = listUser.indexOf(user);
      listUser.removeAt(index);
      listUser.insert(index, user);
    } else {
      user?.idUser = '${listUser.length}';
      listUser.add(user);
    }
    return null;
  }

  ///Function for delete data user by id
  ///@return String idUser
  ///#param String id
  @override
  Future<String> delete(String id) async {
    String docID;
    var user =
        listUser.singleWhere((user) => user.idUser == id, orElse: () => null);
    if (user != null) {
      listUser.remove(user);
      docID = user.idUser;
    }
    return docID;
  }
}
