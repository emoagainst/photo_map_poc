
import 'package:photo_map_poc/domain/models/photo_data.dart';
import 'package:photo_map_poc/store/native_pay/native_pay_state.dart';
import 'package:photo_map_poc/store/photo_details/photo_details_states.dart';
import 'package:photo_map_poc/store/photos/photos_states.dart';

bool photosLoadingSelector(PhotosState state) => state.loading;
List<PhotoData> photosSelector(PhotosState state) => state.photos;
PhotoData currentPhotoDetailsSelector(PhotoDetailsState state) => state.photo;
bool currentPhotoDetailsLoadingSelector(PhotoDetailsState state) => state.loading;
bool currentNativePayInProgressSelector(NativePayState state) => state.inProgress;
bool currentNativePaySucceededSelector(NativePayState state) => state.succeeded;