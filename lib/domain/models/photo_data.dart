import 'package:photo_map_poc/database/photo_entity.dart';

class PhotoData {
  final int? id;
  final String path;
  final double latitude;
  final double longitude;
  final bool isPaid;

  PhotoData({
    required this.id,
    required this.path,
    required this.latitude,
    required this.longitude,
    required this.isPaid,
  });

  const PhotoData.empty()
      : id = 0,
        path = "",
        latitude = 0.0,
        longitude = 0.0,
        isPaid = false;

  PhotoData copyWith({int? id, String? path, double? latitude, double? longitude, bool? isPaid}){
    return PhotoData(
      id : id ?? this.id,
      path : path ?? this.path,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isPaid: isPaid ?? this.isPaid
    );
  }

  PhotoData.fromEntity(PhotoEntity entity)
      : id = entity.id,
        path = entity.path,
        latitude = entity.latitude,
        longitude = entity.longitude,
        isPaid = entity.isPaid;

  PhotoEntity toEntity() => PhotoEntity(id: id, path: path, latitude: latitude, longitude: longitude, isPaid: isPaid);

  @override
  String toString() {
    return 'PhotoData{id: $id, path: $path, latitude: $latitude, longitude: $longitude, isPaid: $isPaid}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoData && runtimeType == other.runtimeType && id == other.id && path == other.path && latitude == other.latitude && longitude == other.longitude && isPaid == other.isPaid;

  @override
  int get hashCode => id.hashCode ^ path.hashCode ^ latitude.hashCode ^ longitude.hashCode ^ isPaid.hashCode;
}
