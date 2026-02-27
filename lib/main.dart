import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/models/task.dart';
import 'package:todo/pages/home_page.dart';
import 'package:todo/providers/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>("TaskBox");

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
    return MaterialApp(
      title: "ToDO",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
