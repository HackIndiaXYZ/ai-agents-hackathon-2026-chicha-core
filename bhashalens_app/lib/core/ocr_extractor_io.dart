import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:bhashalens_app/features/translation/data/services/ml_kit_translation_service.dart';

/// VM/IO: extract text from image file using ML Kit (uses dart:io File).
Future<String> extractTextFromImageFile(XFile image,
    {required String languageCode}) async {
  final mlKitService = MlKitTranslationService();
  final file = File(image.path);
  return mlKitService.extractTextFromFile(file, languageCode: languageCode);
}
