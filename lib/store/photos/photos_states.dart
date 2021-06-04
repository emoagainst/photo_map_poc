import 'package:photo_map_poc/domain/models/photo_data.dart';

class PhotosState {
  final bool loading;
  final List<PhotoData> photos;

  const PhotosState({
    this.loading = true,
    this.photos = const <PhotoData>[],
  });

  PhotosState copyWith({bool? loading, List<PhotoData>? photos}) {
    return PhotosState(
      loading: loading ?? this.loading,
      photos: photos ?? this.photos,
    );
  }
}