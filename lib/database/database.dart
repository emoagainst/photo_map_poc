import 'package:path/path.dart';
import 'package:photo_map_poc/database/photo_entity.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  return await openDatabase (
    join(await getDatabasesPath(), "photo_map.db"),
    onCreate: (db, version) async {
      await db.execute(PhotoEntity.CREATE_TABLE);
    },
    version : 1,
  );


}