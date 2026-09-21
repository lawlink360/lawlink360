import '../models/scanner_document_category.dart';

/// Default document name generation for Scanner 360.
///
/// Per spec section 26, names are user-facing and non-legal-binding:
/// "Scanned Document", "Legal Document", "Court Document",
/// "Document - 19 Sep 2026", etc.
class ScannerNamingUtils {
  ScannerNamingUtils._();

  static const List<String> _monthAbbrev = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  /// Returns a sensible default title for a newly created document.
  ///
  /// The category is used only as a hint; nothing is hard-coded that
  /// would misrepresent the document's legal nature.
  static String defaultNameFor(
    ScannerDocumentCategory category, {
    DateTime? now,
  }) {
    final date = now ?? DateTime.now();
    final formatted = formatShortDate(date);

    switch (category) {
      case ScannerDocumentCategory.courtDocument:
        return 'Court Document - $formatted';
      case ScannerDocumentCategory.legalNotice:
        return 'Legal Notice - $formatted';
      case ScannerDocumentCategory.contract:
        return 'Contract - $formatted';
      case ScannerDocumentCategory.cnicOrDocumentScan:
        return 'Document Scan - $formatted';
      case ScannerDocumentCategory.propertyDocument:
        return 'Property Document - $formatted';
      case ScannerDocumentCategory.agreement:
        return 'Agreement - $formatted';
      case ScannerDocumentCategory.application:
        return 'Application - $formatted';
      case ScannerDocumentCategory.affidavit:
        return 'Affidavit - $formatted';
      case ScannerDocumentCategory.judgment:
        return 'Judgment - $formatted';
      case ScannerDocumentCategory.evidenceDocument:
        return 'Evidence - $formatted';
      case ScannerDocumentCategory.caseFile:
        return 'Case File - $formatted';
      case ScannerDocumentCategory.legalCorrespondence:
        return 'Legal Correspondence - $formatted';
      case ScannerDocumentCategory.other:
        return 'Document - $formatted';
    }
  }

  /// Formats [date] as "19 Sep 2026".
  static String formatShortDate(DateTime date) {
    final day = date.day.toString();
    final month = _monthAbbrev[date.month - 1];
    final year = date.year;
    return '$day $month $year';
  }
}