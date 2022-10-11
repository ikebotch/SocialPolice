import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:socialpolice/src/utils/constants.dart';
import 'package:rxdart/subjects.dart';
import 'package:socialpolice/src/utils/utils.dart';
import 'package:path/path.dart' as p;

class FirebaseStorageDataProvider {
  late FirebaseStorage STORAGE_BUCKET;
  String? STORAGE_PATH;

  static const String INCIDENT_PATH = 'socialPolice/incident';
  static const String PROFILE_PATH = 'socialPolice/profile';

  static const String INCIDENT_IMAGES_PREFIX = 'incident_';
  static const String PROFILE_IMAGES_PREFIX = 'profile_';

  var filePath = '';

  FirebaseStorageDataProvider() {
    STORAGE_PATH = Constants.API_BASE_URL;
    STORAGE_BUCKET = FirebaseStorage.instance;
  }

  final _uploadFetcher = PublishSubject<List<String>>();

  Stream<List<String>> get productImageUpload => _uploadFetcher.stream;

  uploadImage(
    List<File?> images, {
    Function(int, int)? progress,
    bool isIncident = true,
    bool isProfile = false,
  }) async {
    try {
      List<String> pictures = [];
      for (var image in images) {
        Utils.log(">>>STRATRING IMAGE UPLOAD");
        String fileName = Utils.getRandomCharacters(12) +
            p.extension(image!.uri.toFilePath());

        late UploadTask task;
        if (isIncident) {
          filePath =
              '$INCIDENT_PATH/$STORAGE_PATH/$INCIDENT_IMAGES_PREFIX$fileName';

          /// FOR [incident] upload
          task = STORAGE_BUCKET.ref(filePath).putFile(image);
        }
        if (isProfile) {
          filePath =
              '$PROFILE_PATH/$STORAGE_PATH/$PROFILE_IMAGES_PREFIX$fileName';

          /// FOR [profile] upload
          task = STORAGE_BUCKET.ref(filePath).putFile(image);
        }

        task.snapshotEvents.listen((TaskSnapshot snapshot) async {
          if (snapshot.state == TaskState.running && progress != null) {
            progress(snapshot.bytesTransferred, snapshot.totalBytes);
          } else
          // successful upload
          if (snapshot.state == TaskState.success) {
            Utils.log("SUCCESSFUL UPLOAD");
            var pth = await snapshot.ref.getDownloadURL();
            pictures.add(pth);
            if (!Utils.isEmptyOrNull(pictures) &&
                pictures.length >= images.length) {
              _uploadFetcher.sink.add(pictures);
            }
          }

          // failed upload
          else {
            _uploadFetcher.addError('Upload failed');
            return;
          }
        }, onError: (e) {
          // The final snapshot is also available on the task via `.snapshot`,
          // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
          Utils.log(task.snapshot);

          if (e.code == 'permission-denied') {
            Utils.log(
                'User does not have permission to upload to this reference.');
          }

          _uploadFetcher.addError('Upload failed');
        });
      }
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      Utils.log(e);
      _uploadFetcher.addError('Failed');
    }
  }

  dispose() {
    _uploadFetcher.close();
  }
}
