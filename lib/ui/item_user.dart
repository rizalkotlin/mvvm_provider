import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_provider/commum_utils/podos/users.dart';
import 'package:mvvm_provider/commum_utils/providers/user_provider.dart';
import 'package:mvvm_provider/screens/form_user_screen.dart';
import 'package:provider/provider.dart';

class ItemUser extends StatelessWidget {
  final User user;

  const ItemUser({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          '${user?.displayName?.substring(0, 1)?.toUpperCase()}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        radius: 18,
      ),
      title: Text('${user?.displayName}'),
      subtitle: Text(
        '${user?.address}',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 12,
        ),
      ),
      trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            userProvider?.delete(user?.idUser);
          }),
      onTap: () {
        userProvider?.idSink?.add(user?.idUser);
        Navigator.pushNamed(context, FormUserScreen.routeName);
      },
    );
  }
}
