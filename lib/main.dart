import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nosql/models/social-post.dart';
import 'package:nosql/splash.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  //Initializing Hive Database 
  WidgetsFlutterBinding.ensureInitialized();
  //Get Application Document Directory
  final appDocumentDirectory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  //Registering Social Post Adapter
  Hive.registerAdapter(SocialPostAdapter());
  runApp(Myapp());

} 