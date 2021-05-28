import 'package:flutter/material.dart';
import 'package:mvvm_provider/commum_utils/dummy/user_dummy.dart';
import 'package:mvvm_provider/commum_utils/providers/user_provider.dart';
import 'package:mvvm_provider/screens/form_user_screen.dart';
import 'package:mvvm_provider/screens/list_user_screen.dart';
import 'package:provider/provider.dart';

void main() {
  var userProvider = UserProvider(UserDummy());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(value: userProvider),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final router = <String, WidgetBuilder>{
    FormUserScreen.routeName: (context) => FormUserScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListUserScreen(),
      routes: router,
    );
  }
}
