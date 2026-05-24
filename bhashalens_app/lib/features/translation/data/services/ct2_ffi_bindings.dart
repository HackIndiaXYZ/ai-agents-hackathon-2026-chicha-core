import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

// FFI signatures
typedef CT2CreateC = Pointer<Void> Function(Pointer<Utf8> modelPath, Pointer<Utf8> device);
typedef CT2CreateDart = Pointer<Void> Function(Pointer<Utf8> modelPath, Pointer<Utf8> device);

typedef CT2TranslateC = Pointer<Utf8> Function(
    Pointer<Void> translator, Pointer<Utf8> text, Pointer<Utf8> sourceLang, Pointer<Utf8> targetLang);
typedef CT2TranslateDart = Pointer<Utf8> Function(
    Pointer<Void> translator, Pointer<Utf8> text, Pointer<Utf8> sourceLang, Pointer<Utf8> targetLang);

typedef CT2DestroyC = Void Function(Pointer<Void> translator);
typedef CT2DestroyDart = void Function(Pointer<Void> translator);

typedef CT2FreeStringC = Void Function(Pointer<Utf8> str);
typedef CT2FreeStringDart = void Function(Pointer<Utf8> str);

typedef CT2ModelSizeBytesC = Int32 Function(Pointer<Utf8> modelPath);
typedef CT2ModelSizeBytesDart = int Function(Pointer<Utf8> modelPath);

class CT2FfiBindings {
  static final DynamicLibrary _dylib = _loadLibrary();

  static DynamicLibrary _loadLibrary() {
    if (Platform.isAndroid) {
      return DynamicLibrary.open('libct2_bridge.so');
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return DynamicLibrary.process();
    }
    if (Platform.isWindows) {
      return DynamicLibrary.open('ct2_bridge.dll');
    }
    if (Platform.isLinux) {
      return DynamicLibrary.open('libct2_bridge.so');
    }
    throw UnsupportedError('Unsupported platform for CTranslate2 FFI');
  }

  // Bindings cache
  late final CT2CreateDart ct2Create =
      _dylib.lookupFunction<CT2CreateC, CT2CreateDart>('ct2_create');

  late final CT2TranslateDart ct2Translate =
      _dylib.lookupFunction<CT2TranslateC, CT2TranslateDart>('ct2_translate');

  late final CT2DestroyDart ct2Destroy =
      _dylib.lookupFunction<CT2DestroyC, CT2DestroyDart>('ct2_destroy');

  late final CT2FreeStringDart ct2FreeString =
      _dylib.lookupFunction<CT2FreeStringC, CT2FreeStringDart>('ct2_free_string');

  late final CT2ModelSizeBytesDart ct2ModelSizeBytes =
      _dylib.lookupFunction<CT2ModelSizeBytesC, CT2ModelSizeBytesDart>('ct2_model_size_bytes');

  // Singleton pattern
  static final CT2FfiBindings _instance = CT2FfiBindings._internal();
  factory CT2FfiBindings() => _instance;
  CT2FfiBindings._internal();
}
