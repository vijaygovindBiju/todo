import 'package:hive/hive.dart';
part 'tasks.g.dart';

@HiveType(typeId: 0)
class Tasks extends HiveObject {
  @HiveField(0)
  String text;
  @HiveField(1)
  bool isDone;
  Tasks({required this.text, required this.isDone});
}
