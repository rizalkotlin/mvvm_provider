import 'package:flutter/material.dart';
import 'package:mvvm_provider/commum_utils/podos/users.dart';
import 'package:mvvm_provider/commum_utils/providers/user_provider.dart';
import 'package:provider/provider.dart';

class FormUserScreen extends StatefulWidget {
  static String routeName = 'form-user-screen';
  @override
  _FormUserScreenState createState() => _FormUserScreenState();
}

class _FormUserScreenState extends State<FormUserScreen>
    with WidgetsBindingObserver {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserProvider? userProvider;
  User user = User.empty();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      setState(() => user = userProvider!.userState.user);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Form User'),
        elevation: 2.5,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (userProvider?.isLoading != null && !userProvider!.isLoading)
                  TextFormField(
                    initialValue: '${user.displayName ?? ''}',
                    onSaved: (val) => setState(() {
                      user.displayName = val;
                      print('user');
                    }),
                    validator: (val) =>
                        val!.length >= 5 ? null : 'Minimal 5 Karekter',
                    decoration: InputDecoration(
                      hintText: 'Masukkan Nama Lengkap',
                      labelText: 'Nama Lengkap',
                    ),
                  ),
                SizedBox(height: 14),
                if (userProvider?.isLoading != null && !userProvider!.isLoading)
                  TextFormField(
                    initialValue: '${user.email ?? ''}',
                    onSaved: (val) => setState(() => user.email = val),
                    validator: (val) => val!.contains('@')
                        ? null
                        : 'Format harus menggunakan tanda\'@\'',
                    decoration: InputDecoration(
                      hintText: 'Masukkan Email Anda',
                      labelText: 'Email',
                    ),
                  ),
                SizedBox(height: 14),
                if (userProvider?.isLoading != null && !userProvider!.isLoading)
                  TextFormField(
                    initialValue: '${user.address ?? ''}',
                    onSaved: (val) => setState(() => user.address = val),
                    validator: (val) =>
                        val!.length >= 5 ? null : 'Minimal 5 Karekter',
                    minLines: 4,
                    maxLines: 10,
                    maxLength: 225,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Alamat Anda...',
                      labelText: 'Alamat',
                    ),
                  ),
                SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () => onSAve(),
                  child: Text('SAVE'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSAve() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      userProvider?.save(user);
      Navigator?.pop(context);
    }
  }
}
