enum AiSearchDestination {
  findLawyer,
  applications,
  procedureGuide,
  verificationHub,
  translation,
  scanner,
}

class AiSearchIntent {
  final AiSearchDestination destination;
  final String title;
  final String description;
  final String actionLabel;
  final List<String> fields;

  const AiSearchIntent({
    required this.destination,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.fields,
  });

  static const List<AiSearchIntent> available = [
    AiSearchIntent(
      destination: AiSearchDestination.findLawyer,
      title: 'Find Lawyer',
      description: 'Find the right lawyer for your legal matter.',
      actionLabel: 'Find Lawyers',
      fields: [
        'Lawyer name or specialty',
        'Practice area',
        'Location',
      ],
    ),
    AiSearchIntent(
      destination: AiSearchDestination.applications,
      title: 'Applications',
      description: 'Find and prepare the legal application you need.',
      actionLabel: 'Open Applications',
      fields: [
        'Application type',
        'Legal category',
        'Search application',
      ],
    ),
    AiSearchIntent(
      destination: AiSearchDestination.procedureGuide,
      title: 'Procedure Guide',
      description: 'Explore the legal procedure relevant to your matter.',
      actionLabel: 'Find Procedure',
      fields: [
        'Legal category',
        'Procedure or legal issue',
      ],
    ),
    AiSearchIntent(
      destination: AiSearchDestination.verificationHub,
      title: 'Verification Hub',
      description: 'Access government and court verification services.',
      actionLabel: 'Open Verification',
      fields: [
        'Verification service',
        'Document or record details',
      ],
    ),
    AiSearchIntent(
      destination: AiSearchDestination.translation,
      title: 'Translation',
      description: 'Translate legal documents and text.',
      actionLabel: 'Open Translation',
      fields: [
        'Source language',
        'Target language',
        'Text or document',
      ],
    ),
    AiSearchIntent(
      destination: AiSearchDestination.scanner,
      title: 'Scanner',
      description: 'Scan and convert your legal documents.',
      actionLabel: 'Open Scanner',
      fields: [
        'Document type',
        'Scanning action',
      ],
    ),
  ];

  static AiSearchIntent forDestination(
    AiSearchDestination destination,
  ) {
    return available.firstWhere(
      (intent) => intent.destination == destination,
    );
  }
}