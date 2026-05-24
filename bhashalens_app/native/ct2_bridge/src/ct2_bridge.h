#ifndef CT2_BRIDGE_H
#define CT2_BRIDGE_H

#ifdef __cplusplus
extern "C" {
#endif

#if defined(_WIN32)
#define FFI_EXPORT __declspec(dllexport)
#else
#define FFI_EXPORT __attribute__((visibility("default")))
#endif

// Opaque struct pointer representation for C API
typedef struct CT2Translator CT2Translator;

/**
 * Initialize a CTranslate2 Translator.
 * @param model_path Path to the quantized CTranslate2 model directory.
 * @param device The target execution device ("cpu" or "cuda").
 * @returns Pointer to the created CT2Translator instance, or NULL on failure.
 */
FFI_EXPORT CT2Translator* ct2_create(const char* model_path, const char* device);

/**
 * Translate input text.
 * @param translator The translator instance.
 * @param text The input text to translate.
 * @param source_lang Source language tag (e.g. "hin_Deva").
 * @param target_lang Target language tag (e.g. "eng_Latn").
 * @returns Null-terminated translated string. Must be freed with ct2_free_string.
 */
FFI_EXPORT char* ct2_translate(CT2Translator* translator, const char* text,
                               const char* source_lang, const char* target_lang);

/**
 * Release the CT2Translator instance.
 * @param translator The instance to destroy.
 */
FFI_EXPORT void ct2_destroy(CT2Translator* translator);

/**
 * Free a string allocated by the bridge.
 * @param str The string to free.
 */
FFI_EXPORT void ct2_free_string(char* str);

/**
 * Helper to check the binary model file size.
 * @param model_path Path to the model directory.
 * @returns Size in bytes, or -1 on error.
 */
FFI_EXPORT int ct2_model_size_bytes(const char* model_path);

#ifdef __cplusplus
}
#endif

#endif // CT2_BRIDGE_H
