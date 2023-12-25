import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_cookbook/local_db/local_db.dart';
import 'package:sqlite_cookbook/model/dog.dart';

class LocalDBImpl extends LocalDB {
  static late Database database;

  @override
  void close() {
    // TODO: implement close
  }

  /// Creates the [doggie_database] if not created already
  @override
  Future<void> initialize() async {
    String dbPath;
    if (Platform.isAndroid) {
      dbPath = await getDatabasesPath();
    } else {
      dbPath = (await getLibraryDirectory()).path;
    }

    database = await openDatabase(
      join(dbPath, "doggie_database.db"),
      onCreate: (db, version) async {
        log("Database did not exist, creating database");
        await db.execute(
            "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)");
      },
      version: 2,
    );

    await insertMockData();
  }

  /// Inserts a [Dog] in the database, if the dog is already
  /// present it overwrites the existing data
  @override
  Future<void> insertDog(Dog dog) async {
    log("Inserting ${dog.name} to database");
    await database.insert(
      'dogs',
      dog.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Retrieves all the dogs from the database
  @override
  Future<List<Dog>> getAllDogs() async {
    List<Map<String, dynamic>> dogs = await database.query('dogs');

    return List.generate(dogs.length, (index) => Dog.fromJson(dogs[index]));
  }

  /// Updates [Dog] on the basis of [id]
  @override
  Future<void> updateDog(Dog dog) async {
    log("Updating record with id: ${dog.id}");
    await database
        .update('dog', dog.toJson(), where: 'id = ?', whereArgs: [dog.id]);
  }

  /// Deletes [Dog] record from the database
  /// If the record doesn't exist, does nothing
  @override
  Future<void> deleteDog(Dog dog) async {
    log("Deleting dog: ${dog.name}");
    await database.delete('dogs', where: 'id = ?', whereArgs: [dog.id]);
  }

  Future<void> insertMockData() async {
    await insertDog(const Dog(id: 1, name: "Lucky", age: 12));
    await insertDog(const Dog(id: 2, name: "Tuffy", age: 3));
    await insertDog(const Dog(id: 3, name: "Kutta", age: 5));
    await insertDog(const Dog(id: 4, name: "Oscar", age: 10));
    await insertDog(const Dog(id: 5, name: "Scooby", age: 7));
  }
}
