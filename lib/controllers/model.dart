
import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject{

  @HiveField(0)
  String title="";

  @HiveField(1)
  bool isDone=false;

  @HiveField(2)
  DateTime? date;

  @HiveField(3)
  String? description;

  Todo({required this.title,this.isDone=false,this.date,this.description});
}