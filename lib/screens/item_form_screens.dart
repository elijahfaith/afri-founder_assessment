import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/item_model.dart';
import '../provider/item_provider.dart';

class ItemFormScreen extends ConsumerWidget {
  final ItemModel? item;

  const ItemFormScreen({super.key, this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: item?.title ?? "");
    final descriptionController = TextEditingController(text: item?.description ?? "");

    return Scaffold(
      appBar: AppBar(
        title: Text(item == null ? "Add Item" : "Edit Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Enter title",
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Enter description",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (item == null) {
                  ref.read(itemsProvider.notifier).addItem(controller.text, descriptionController.text);
                } else {
                  ref.read(itemsProvider.notifier).updateItem(item!.id, controller.text, descriptionController.text);
                }
                Navigator.pop(context);
              },
              child: Text(item == null ? "Save" : "Update"),
            )
          ],
        ),
      ),
    );
  }
}
