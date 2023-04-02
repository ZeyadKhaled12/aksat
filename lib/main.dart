import 'package:aksat/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/services/services_locator.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
 ServicesLocator().init();
 runApp(const Aksat());
}

