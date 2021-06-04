import 'package:collection/collection.dart';
import 'package:photo_map_poc/database/photo_entity.dart';
import 'package:sqflite/sqflite.dart';

class PhotosDao {
  final Database database;

  PhotosDao(this.database);

  Future<List<PhotoEntity>> findAll() async {
    final photoMaps = await database.query(tablePhotos);
    return photoMaps.map((m) => PhotoEntity.fromMap(m)).toList();
  }

  Future<PhotoEntity?> findById(int id) async {
    final photoMaps = await database.query(tablePhotos, where: "$columnId = ?", whereArgs: [id]);
    return photoMaps.map((m) => PhotoEntity.fromMap(m)).firstOrNull;
  }

  Future<int> insert(PhotoEntity entity) async{
    return await database.insert(tablePhotos, entity.toMap());
  }

  Future delete(int id) async {
    return await database.delete(tablePhotos, where: "$columnId = ?", whereArgs: [id]);
  }

}