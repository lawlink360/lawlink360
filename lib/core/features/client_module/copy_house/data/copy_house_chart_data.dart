import 'package:flutter/foundation.dart';

/// One row in a fee table.
@immutable
class CopyHouseChartRow {
  final String label;
  final String amount;

  const CopyHouseChartRow({
    required this.label,
    required this.amount,
  });
}

/// Complete data for a Copy House payment chart.
///
/// This is informational only. It is rendered by
/// `CopyHouseChartLayout`. No amount here is computed, deducted,
/// credited, or charged. There is no Firestore write, no payment
/// processing, and no billing logic anywhere in Copy House.
@immutable
class CopyHouseChartData {
  final String title;
  final String subtitle;
  final List<CopyHouseChartRow> initialAdvanceRows;
  final String totalInitialAdvanceLabel;
  final String totalInitialAdvanceAmount;
  final String afterConfirmationCaption;
  final List<CopyHouseChartRow> afterConfirmationRows;
  final String regularEstimate;
  final String urgentEstimate;
  final String completionNotice;
  final List<String> paymentTerms;
  final String disclaimer;

  const CopyHouseChartData({
    required this.title,
    required this.subtitle,
    required this.initialAdvanceRows,
    required this.totalInitialAdvanceLabel,
    required this.totalInitialAdvanceAmount,
    required this.afterConfirmationCaption,
    required this.afterConfirmationRows,
    required this.regularEstimate,
    required this.urgentEstimate,
    required this.completionNotice,
    required this.paymentTerms,
    required this.disclaimer,
  });
}

// ---------------------------------------------------------------------------
// Shared wording (identical across all four charts where applicable).
// ---------------------------------------------------------------------------

const String _afterConfirmationCaption =
    'After confirming the process and checking the availability of the '
    'requested copy, the following charges will apply:';

const String _completionNotice =
    'The estimated completion period covers processing time only. '
    'Delivery time is not included.';

const List<String> _sharedPaymentTerms = <String>[
  'Initial payment: The processing fee and platform fee are payable in '
      'advance.',
  'Availability and information confirmation: Once the availability and '
      'information-checking process for the requested copy is complete, '
      'the customer will be notified through the LawLink360 app and by a '
      'representative of the support team.',
  'Service advance: After the process is confirmed, the requested copy\'s '
      'availability is checked, and the customer approves the final '
      'quotation, 50% of the confirmed service charges is payable in '
      'advance.',
  'Remaining payment: The remaining 50% of the confirmed service charges '
      'must be paid before dispatch or delivery.',
  'Additional charges: Any additional applicable charges must be '
      'communicated to and approved by the customer before collection.',
  'Delivery time: Courier or delivery time is separate from the '
      'estimated processing period.',
];

const String _paymentDisclaimer =
    'All payments must be made through the official payment methods '
    'provided within the LawLink360 app.\n\n'
    'Payments made or transferred outside the app through personal '
    'accounts, private arrangements, or unauthorized representatives '
    'will not be recognized as valid Copy House payments and may not '
    'be eligible for claims or reimbursement through LawLink360.\n\n'
    'Always retain your in-app payment confirmation or official '
    'receipt. If anyone asks you to pay outside the app, please '
    'contact the official Copy House support team before making any '
    'payment.';

// ---------------------------------------------------------------------------
// Chart 1 — District Court.
// ---------------------------------------------------------------------------

const CopyHouseChartData districtCourtChart = CopyHouseChartData(
  title: 'District Court Copy Charges Chart',
  subtitle: 'District Court Certified Copies',
  initialAdvanceRows: <CopyHouseChartRow>[
    CopyHouseChartRow(
      label: 'Processing Fee (Advance)',
      amount: 'Rs. 499/-',
    ),
    CopyHouseChartRow(
      label: 'Platform Fee (Advance)',
      amount: 'Rs. 499/-',
    ),
  ],
  totalInitialAdvanceLabel: 'Total Initial Advance Payment',
  totalInitialAdvanceAmount: 'Rs. 998/-',
  afterConfirmationCaption: _afterConfirmationCaption,
  afterConfirmationRows: <CopyHouseChartRow>[
    CopyHouseChartRow(
      label: 'Requested Copy Fee (up to 15 pages)',
      amount: 'Rs. 3,000/-',
    ),
    CopyHouseChartRow(
      label: 'Additional Pages (beyond 15 pages)',
      amount: 'Rs. 100/- per page',
    ),
    CopyHouseChartRow(
      label: 'Service Fee — Regular Application',
      amount: 'Rs. 1,000/-',
    ),
    CopyHouseChartRow(
      label: 'Service Fee — Urgent Application',
      amount: 'Rs. 2,000/-',
    ),
  ],
  regularEstimate:
      'Rs. 1,000/- · Estimated completion: 7 working days.',
  urgentEstimate:
      'Rs. 2,000/- · Estimated completion: 2 working days.',
  completionNotice: _completionNotice,
  paymentTerms: _sharedPaymentTerms,
  disclaimer: _paymentDisclaimer,
);

// ---------------------------------------------------------------------------
// Chart 2 — High Court.
// ---------------------------------------------------------------------------

const CopyHouseChartData highCourtChart = CopyHouseChartData(
  title: 'High Court Copy Charges Chart',
  subtitle: 'High Court Certified Copies',
  initialAdvanceRows: <CopyHouseChartRow>[
    CopyHouseChartRow(
      label: 'Processing Fee (Advance)',
      amount: 'Rs. 1,000/-',
    ),
    CopyHouseChartRow(
      label: 'Platform Fee (Advance)',
      amount: 'Rs. 499/-',
    ),
  ],
  totalInitialAdvanceLabel: 'Total Initial Advance Payment',
  totalInitialAdvanceAmount: 'Rs. 1,499/-',
  afterConfirmationCaption: _afterConfirmationCaption,
  afterConfirmationRows: <CopyHouseChartRow>[
    CopyHouseChartRow(
      label: 'Requested Copy Fee (up to 15 pages)',
      amount: 'Rs. 5,000/-',
    ),
    CopyHouseChartRow(
      label: 'Additional Pages (beyond 15 pages)',
      amount: 'Rs. 100/- per page',
    ),
    CopyHouseChartRow(
      label: 'Service Fee — Regular Application',
      amount: 'Rs. 1,500/-',
    ),
    CopyHouseChartRow(
      label: 'Service Fee — Urgent Application',
      amount: 'Rs. 3,000/-',
    ),
  ],
  regularEstimate:
      'Rs. 1,500/- · Estimated completion: 7 working days.',
  urgentEstimate:
      'Rs. 3,000/- · Estimated completion: 2 working days.',
  completionNotice: _completionNotice,
  paymentTerms: _sharedPaymentTerms,
  disclaimer: _paymentDisclaimer,
);

// ---------------------------------------------------------------------------
// Chart 3 — Mutation. No additional-page row, per approval.
// ---------------------------------------------------------------------------

const CopyHouseChartData mutationChart = CopyHouseChartData(
  title: 'Mutation Copy Charges Chart',
  subtitle: 'Mutation Copies',
  initialAdvanceRows: <CopyHouseChartRow>[
    CopyHouseChartRow(
      label: 'Processing Fee (Advance)',
      amount: 'Rs. 499/-',
    ),
    CopyHouseChartRow(
      label: 'Platform Fee (Advance)',
      amount: 'Rs. 499/-',
    ),
  ],
  totalInitialAdvanceLabel: 'Total Initial Advance Payment',
  totalInitialAdvanceAmount: 'Rs. 998/-',
  afterConfirmationCaption: _afterConfirmationCaption,
  afterConfirmationRows: <CopyHouseChartRow>[
    CopyHouseChartRow(
      label: 'Requested Copy Fee',
      amount: 'Rs. 3,000/-',
    ),
    CopyHouseChartRow(
      label: 'Service Fee — Regular Application',
      amount: 'Rs. 1,000/-',
    ),
    CopyHouseChartRow(
      label: 'Service Fee — Urgent Application',
      amount: 'Rs. 2,000/-',
    ),
  ],
  regularEstimate:
      'Rs. 1,000/- · Estimated completion: 7 working days.',
  urgentEstimate:
      'Rs. 2,000/- · Estimated completion: 2 working days.',
  completionNotice: _completionNotice,
  paymentTerms: _sharedPaymentTerms,
  disclaimer: _paymentDisclaimer,
);

// ---------------------------------------------------------------------------
// Chart 4 — Registered Documents. No additional-page row, per approval.
// ---------------------------------------------------------------------------

const CopyHouseChartData registeredDocumentsChart =
    CopyHouseChartData(
  title: 'Registered Documents Copy Charges Chart',
  subtitle: 'Registered Document Copies',
  initialAdvanceRows: <CopyHouseChartRow>[
    CopyHouseChartRow(
      label: 'Processing Fee (Advance)',
      amount: 'Rs. 499/-',
    ),
    CopyHouseChartRow(
      label: 'Platform Fee (Advance)',
      amount: 'Rs. 499/-',
    ),
  ],
  totalInitialAdvanceLabel: 'Total Initial Advance Payment',
  totalInitialAdvanceAmount: 'Rs. 998/-',
  afterConfirmationCaption: _afterConfirmationCaption,
  afterConfirmationRows: <CopyHouseChartRow>[
    CopyHouseChartRow(
      label: 'Requested Copy Fee',
      amount: 'Rs. 3,000/-',
    ),
    CopyHouseChartRow(
      label: 'Service Fee — Regular Application',
      amount: 'Rs. 1,000/-',
    ),
    CopyHouseChartRow(
      label: 'Service Fee — Urgent Application',
      amount: 'Rs. 2,000/-',
    ),
  ],
  regularEstimate:
      'Rs. 1,000/- · Estimated completion: 7 working days.',
  urgentEstimate:
      'Rs. 2,000/- · Estimated completion: 2 working days.',
  completionNotice: _completionNotice,
  paymentTerms: _sharedPaymentTerms,
  disclaimer: _paymentDisclaimer,
);