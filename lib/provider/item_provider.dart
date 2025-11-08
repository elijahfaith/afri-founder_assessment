import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../model/item_model.dart';

final itemsProvider =
StateNotifierProvider<ItemNotifier, List<ItemModel>>((ref) {
  return ItemNotifier();
});

class ItemNotifier extends StateNotifier<List<ItemModel>> {
  ItemNotifier() : super([]) {
    loadItems();
  }

  final uuid = const Uuid();

  Future<void> loadItems() async {
    final box = Hive.box<ItemModel>('itemsBox');
    state = box.values.toList();
  }

  Future<void> addItem(String title, String description) async {
    final newItem = ItemModel(id: uuid.v4(), title: title, description: description);

    final box = Hive.box<ItemModel>('itemsBox');
    await box.put(newItem.id, newItem);

    state = box.values.toList();
  }

  Future<void> updateItem(String id, String title, String description) async {
    final updated = ItemModel(id: id, title: title, description: description );

    final box = Hive.box<ItemModel>('itemsBox');
    await box.put(id, updated);

    state = box.values.toList();
  }

  Future<void> deleteItem(String id) async {
    final box = Hive.box<ItemModel>('itemsBox');
    await box.delete(id);

    state = box.values.toList();
  }
}
