import 'package:flutter/material.dart';
import 'package:weic/core/models/user.dart';
import 'package:weic/core/storage/db_storage.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  DbStorage _dbStorage = DbStorage();
  User c = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('add'),
              onPressed: () async {
                c.id = 1;
                c.name = 'Marcelo Cesar';
                c.img = 'path/img/marcelo';
                await _dbStorage.registerUser(c);
              },
            ),
            ElevatedButton(
              child: Text('print'),
              onPressed: () async {
                if (c.id != null) {
                  User user = await _dbStorage.getUser(c.id);
                  if (user != null) {
                    print(User.fromMap(user.toMap()));
                  } else {
                    print('user nao encontrado');
                  }
                } else {
                  print('id invalido');
                }
              },
            ),
            ElevatedButton(
              child: Text('get all'),
              onPressed: () async {
                await _dbStorage.getAllUsers().then(
                  (value) {
                    print(value);
                    // for (var i = 0; i < value.length; i++) {
                    //   (value[i] as dynamic).map((e) => print(e));
                    // }
                  },
                );
              },
            ),
            ElevatedButton(
              child: Text('delete'),
              onPressed: () async {
                await _dbStorage.delete(c.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
