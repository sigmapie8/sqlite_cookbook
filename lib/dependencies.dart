import 'package:get_it/get_it.dart';
import 'package:sqlite_cookbook/local_db/local_db.dart';
import 'package:sqlite_cookbook/local_db/local_db_impl.dart';

final GetIt getIt = GetIt.instance;

void initializeDependencies() {
  getIt.registerSingleton<LocalDB>(LocalDBImpl());
}
