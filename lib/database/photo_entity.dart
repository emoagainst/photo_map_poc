const String tablePhotos = 'photos';
const String columnId = '_id';
const String _columnPath = 'path';
const String _columnLatitude = 'latitude';
const String _columnLongitude = 'longitude';
const String _columnIsPaid = 'isPaid';

class PhotoEntity {
  final int? id;
  final String path;
  final double latitude;
  final double longitude;
  final bool isPaid;

  PhotoEntity({
    required this.id,
    required this.path,
    required this.latitude,
    required this.longitude,
    required this.isPaid,
  });

  PhotoEntity.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        path = map[_columnPath],
        latitude = map[_columnLatitude],
        longitude = map[_columnLongitude],
        isPaid = map[_columnIsPaid] == 1;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      _columnPath: path,
      _columnLatitude: latitude,
      _columnLongitude: longitude,
      _columnIsPaid: isPaid ? 1 : 0,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  static const String CREATE_TABLE =
      'CREATE TABLE $tablePhotos ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $_columnPath TEXT, $_columnLatitude NUMBER, $_columnLongitude NUMBER, $_columnIsPaid INTEGER);';
}
