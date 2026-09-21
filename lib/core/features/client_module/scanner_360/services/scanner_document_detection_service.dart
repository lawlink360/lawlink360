import '../constants/scanner_constants.dart';
import '../models/crop_data.dart';

/// Scanner 360 automatic document boundary/corner detection.
///
/// ## Status
///
/// The currently installed LawLink360 dependency set does not
/// include any package that performs automatic document boundary,
/// corner, or quad detection from an image buffer.
///
/// - `flutter_box_transform` is a manual transformation /
///   interaction widget. It lets a user drag the four corners of
///   a rectangle. It does not detect corners.
/// - `crop_your_image` is a manual cropping / interaction widget.
///   It lets a user select a crop region. It does not detect
///   document edges.
///
/// Neither package is used by this service as a detection engine.
///
/// ## Future replacement
///
/// When a real detection dependency is added to the project, only
/// this class needs to be replaced. The rest of Scanner 360
/// consumes `CropData?` from [detect] and does not depend on how
/// it was produced.
class ScannerDocumentDetectionService {
  const ScannerDocumentDetectionService();

  /// Attempts to detect the document boundary in [imagePath].
  ///
  /// This method always throws [UnsupportedError] because no
  /// installed dependency performs automatic document detection.
  ///
  /// Callers that need crop coordinates should obtain them from
  /// the user through the manual crop UI instead of calling this
  /// method.
  Future<CropData?> detect(String imagePath) {
    throw UnsupportedError(
      ScannerConstants.detectionUnsupportedMessage,
    );
  }
}