import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/database_hive.dart';
import 'package:todo/data/tasks.dart';
import 'package:todo/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Tasks>("TaskBox");

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => DatabaseHive())],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "ToDO",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
