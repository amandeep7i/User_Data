import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:staffs/DBfirebase/dbFunctions.dart';
import 'package:staffs/screens/homeScreen.dart';
import 'firebase_options.dart';
import './Constants/routes.dart';
import 'screens/staffDetails.dart';
import 'screens/staffList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DBfunctions.DBInitalize();
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}
