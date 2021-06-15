import 'package:flutter/material.dart';
import 'package:weic/core/models/user.dart';
import 'package:weic/core/storage/db.dart';

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
                c.id = 2;
                c.name = 'Marcelo2';
                c.img = '/ome/j/';
                await _dbStorage.insert(c);
              },
            ),
            ElevatedButton(
              child: Text('print'),
              onPressed: () async {
                await _dbStorage.getUser(c.id).then((value) => print(value));
              },
            ),
            ElevatedButton(
              child: Text('get all'),
              onPressed: () async {
                await _dbStorage.getAllContacts().then(
                      (value) => print(
                        value.cast(),
                      ),
                    );
              },
            ),
            ElevatedButton(
              child: Text('delete'),
              onPressed: () async {
                await _dbStorage.delete(11);
              },
            ),
          ],
        ),
      ),
    );
  }
}
