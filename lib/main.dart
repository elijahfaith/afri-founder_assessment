import 'package:afri_founder/provider/themes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home_page.dart';
import 'model/item_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ItemModelAdapter());

  await Hive.openBox<ItemModel>('itemsBox');
  // await Hive.box<ItemModel>('itemsBox').clear();

  await Hive.openBox('settingsBox');


  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeProvider);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Africa Founder Assessment',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          home: const HomeScreen(),
        );
      },
    );
  }
}
