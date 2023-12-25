import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_cookbook/dependencies.dart';
import 'package:sqlite_cookbook/local_db/local_db.dart';
import 'package:sqlite_cookbook/presentation/dog_list_page.dart';
import 'package:sqlite_cookbook/providers/dog_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  await getIt<LocalDB>().initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DogProvider>(
            create: (_) => DogProvider(getIt<LocalDB>()))
      ],
      child: MaterialApp(home: DogListPage()),
    );
  }
}
