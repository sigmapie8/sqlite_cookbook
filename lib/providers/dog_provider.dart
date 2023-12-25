import 'package:flutter/foundation.dart';
import 'package:sqlite_cookbook/dependencies.dart';
import 'package:sqlite_cookbook/local_db/local_db.dart';
import 'package:sqlite_cookbook/model/dog.dart';

class DogProvider extends ChangeNotifier {
  final LocalDB localDB;

  DogProvider(
    this.localDB,
  );

  Future<List<Dog>> getAllDogs() async {
    final dogs = await localDB.getAllDogs();
    return dogs;
  }

  Future<void> addDog({required Dog dog}) async {}
}
