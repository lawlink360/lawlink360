/// Languages supported by the currently installed
/// `google_mlkit_text_recognition: ^0.14.0` dependency.
///
/// Urdu and Arabic are NOT supported by the installed
/// ML Kit text recognition dependency. Do not add
/// Urdu/Arabic enum values pretending they are currently
/// supported.
enum ScannerLanguage {
  latin,
  chinese,
  devanagari,
  japanese,
  korean,
}