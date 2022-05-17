import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mvvm_provider/commum_utils/podos/users.dart';
import 'package:mvvm_provider/commum_utils/repositories/user_repository.dart';

class UserProvider with ChangeNotifier {
  final UserRepository repo;
  final loadingStreamController = StreamController<bool>.broadcast();
  final idStreamController = StreamController<String>.broadcast();

  Stream<bool> get loadingStream => loadingStreamController.stream;
  Sink<bool> get loadingSink => loadingStreamController.sink;

  ///stream untuk melisten data yang telah di kirim ke sink
  Stream<String> get idStream => idStreamController.stream;

  Sink<String> get idSink => idStreamController.sink;
  //untuk mengalirkan data ke dalam stream controller
  ///secara realtime

  GlobalKey<RefreshIndicatorState> refresherKey =
      GlobalKey<RefreshIndicatorState>();
  UserState userState = UserState();
  List<User> items = [];
  bool isLoading = true;

  UserProvider(this.repo) {
    _listenLoading();
    _listenId();
    getData();
  }

  ///Method get all data or resfresh data user from repository
  void getData({bool start = true}) async {
    loadingSink.add(true);
    var _list = await repo.getData(start: start);
    if (_list.length > 0 && _list.isNotEmpty) {
      items.clear();
      items.addAll(_list);
      loadingSink.add(false);
      notifyListeners();
    } else {
      items.clear();
      loadingSink.add(false);
      notifyListeners();
    }
  }

  //Function refresh indikator
  Future handleRefresh() async {
    loadingSink.add(true);
    await Future.delayed(Duration(seconds: 2));
    getData(start: false);
  }

  ///listen idUser for get single data user from repository
  void _listenId() {
    idStream.listen((onId) async {
      loadingSink.add(true);
      if (onId != null) {
        var user = await repo.getDataByID(onId);
        userState..user = user;
      } else
        userState..user = User.empty();
      loadingSink.add(false);
      notifyListeners();
    });
  }

  void _listenLoading() {
    loadingStream.listen((onLoading) {
      isLoading = onLoading;
      notifyListeners();
    });
  }

  Future<String> save(User user) async {
    loadingSink.add(true);
    repo.save(user);
    getData(start: false);
    loadingSink.add(false);
    notifyListeners();
    return user.idUser!;
  }

  Future<String> delete(String id) async {
    String docId;
    loadingSink.add(true);
    docId = await repo.delete(id);
    getData(start: false);
    loadingSink.add(false);
    notifyListeners();
    return docId;
  }

  @override
  void dispose() {
    loadingStreamController.close();
    idStreamController.close();
    super.dispose();
  }
}

class UserState {
  User user = User.empty();
}
