import 'package:flutter/material.dart';
import 'package:mvvm_provider/commum_utils/providers/user_provider.dart';
import 'package:mvvm_provider/screens/form_user_screen.dart';
import 'package:mvvm_provider/ui/item_user.dart';
import 'package:provider/provider.dart';

class ListUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final items =
        userProvider.items.map((user) => ItemUser(user: user)).toList();
    final elementDivider =
        ListTile.divideTiles(tiles: items, color: Colors.black54);
    return Scaffold(
      appBar: AppBar(
        title: Text('Data User'),
        elevation: 2.5,
      ),
      body: RefreshIndicator(
        key: userProvider.refresherKey,
        onRefresh: userProvider.handleRefresh,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) =>
              elementDivider.elementAt(index),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          userProvider.idSink.add("");
          Navigator.pushNamed(context, FormUserScreen.routeName);
        },
      ),
    );
  }
}
