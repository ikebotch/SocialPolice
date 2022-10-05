enum ButtonSize { COMPACT, NORMAL, FULL, SMALL, TINY, ICON, MEDIUM }
enum AuthTokenType { USER, DOMAIN, CLIENT }
enum CommentType { FEED, CHAT }


class CameraType {
  // CAMERA, GALLERY
  const CameraType._internal(this.value);
  final String value;

  static const CAMERA = CameraType._internal('CAMERA');
  static const GALLERY = CameraType._internal('GALLERY');

  static CameraType which(String find) {
    if (find.toUpperCase() == GALLERY.value) {
      return CameraType.GALLERY;
    }
    return CameraType.CAMERA;
  }

  @override
  String toString() {
    return value;
  }
}
