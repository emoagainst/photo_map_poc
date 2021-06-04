import 'package:photo_map_poc/domain/models/photo_data.dart';

class PhotoDetailsState {
  final bool loading;
  final PhotoData photo;

  const PhotoDetailsState({
    this.loading = true,
    this.photo = const PhotoData.empty(),
  });

  PhotoDetailsState copyWith({bool? loading, PhotoData? photo}) {
    return PhotoDetailsState(
        loading: loading ?? this.loading,
        photo: photo ?? this.photo
    );
  }
}
