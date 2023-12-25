import 'package:sqlite_cookbook/model/dog.dart';

abstract class LocalDB {
  /// Creates the [doggie_database] if not created already
  Future<void> initialize();

  /// Inserts a [Dog] in the database, if the dog is already
  /// present it overwrites the existing data
  Future<void> insertDog(Dog dog);

  /// Retrieves all the dogs from the database
  Future<List<Dog>> getAllDogs();

  /// Updates [Dog] on the basis of [id]
  Future<void> updateDog(Dog dog);

  /// Deletes [Dog] record from the database
  /// If the record doesn't exist, does nothing
  Future<void> deleteDog(Dog dog);

  void close();
}
