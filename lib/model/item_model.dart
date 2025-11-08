import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
class ItemModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;

  ItemModel({required this.id, required this.title, required this.description});
}
