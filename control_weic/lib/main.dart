import 'package:flutter/widgets.dart';
import 'src/control_weic.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart' show Firebase;

void main() async {
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ControlWeic());
}
