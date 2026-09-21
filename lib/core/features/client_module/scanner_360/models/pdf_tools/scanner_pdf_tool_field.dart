import 'package:meta/meta.dart';

/// The kind of value a tool field accepts.
///
/// This is a UI-layer enum, used by the generic tool flow screen to
/// render the appropriate input widget. It does not represent any
/// domain concept and is not part of the frozen model set.
enum ScannerPdfToolFieldType {
  text,
  integer,
  integerList,
  pageIndexList,
  rotationMap,
  password,
  format,
  compressionLevel,
  encryptionAlgorithm,
}

/// Description of one configuration field required by a PDF tool.
///
/// A [ScannerPdfToolConfig] declares a list of these; the flow
/// screen renders each one and collects its value into a
/// `Map<String, Object?>` keyed by [id].
@immutable
class ScannerPdfToolField {
  const ScannerPdfToolField({
    required this.id,
    required this.label,
    required this.type,
    this.required = true,
    this.hint,
    this.defaultValue,
  });

  /// Stable identifier used as the key in the values map.
  final String id;

  /// Human-readable label shown above the input widget.
  final String label;

  /// Which UI to render.
  final ScannerPdfToolFieldType type;

  /// Whether the tool requires a value for this field.
  final bool required;

  /// Optional placeholder hint shown inside the input widget.
  final String? hint;

  /// Optional initial value.
  ///
  /// The runtime type must match [type]:
  ///  - text / password / format → String
  ///  - integer → int
  ///  - integerList / pageIndexList → List<int
  ///  - rotationMap → Map<int, PdfRotation
  ///  - compressionLevel → PdfCompressionLevelChoice
  ///  - encryptionAlgorithm → PdfEncryptionAlgorithmChoice
  final Object? defaultValue;
}