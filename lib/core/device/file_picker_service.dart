import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'logger_service.dart';
import 'permission_service.dart';

@injectable
class FilePickerService {
  final ImagePicker _picker = ImagePicker();

  final PermissionService _permissionService;
  final LoggerService _loggerService;
  FilePickerService(
    this._permissionService,
    this._loggerService,
  );

  Future<XFile?> pickImageFromGallery() async {
    try {
      return _picker.pickImage(source: ImageSource.gallery);
    } catch (ex, s) {
      _loggerService.logException(ex, s);
      return null;
    }
  }

  Future<XFile?> pickImageFromCamera() async {
    try {
      return _picker.pickImage(source: ImageSource.camera);
    } catch (ex, s) {
      _loggerService.logException(ex, s);
      return null;
    }
  }

  Future<FilePickerResult?> pickFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      return result;
    } catch (ex, s) {
      _loggerService.logException(ex, s);
      return null;
    }
  }

  Future<FilePickerResult?> pickMultipleFiles() async {
    try {
      final FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      return result;
    } catch (ex, s) {
      _loggerService.logException(ex, s);
      return null;
    }
  }

  Future saveImageToFilesAndShare(
    Uint8List bytes,
    String imageName,
    String shareText,
  ) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final image = File('${directory.path}/$imageName.png');
      image.writeAsBytesSync(bytes);
      await Share.shareFiles([image.path], text: shareText);
    } catch (ex, s) {
      _loggerService.logException(ex, s);
    }
  }

  Future<dynamic> saveImageToGallery(Uint8List bytes, String imageName) async {
    if (await _permissionService.storagePermission()) {
      try {
        final result = await ImageGallerySaver.saveImage(
          bytes,
          name: imageName,
          isReturnImagePathOfIOS: true,
        );
        return result;
      } catch (ex, s) {
        _loggerService.logException(ex, s);
      }
    }
  }
}
