import '../models/judgment_model.dart';

class JudgmentIndexData {
  static const List<String> courts = [
    'Supreme Court of Pakistan',
    'Lahore High Court',
    'Islamabad High Court',
    'Sindh High Court',
    'Peshawar High Court',
    'Balochistan High Court',
    'Federal Shariat Court',
  ];

  static const List<String> categories = [
    'Criminal',
    'Civil',
    'Family',
    'Constitutional',
    'Property',
    'Banking',
    'Labour',
    'Tax',
    'Service',
    'Corporate',
    'Other',
  ];

  static const List<String> lawReports = [
    'PLD',
    'SCMR',
    'CLC',
    'MLD',
    'YLR',
    'PCr.LJ',
    'PLC',
    'PTD',
    'CPC',
  ];

  static const List<JudgmentModel> judgments = [
    JudgmentModel(
      id: 'j001',
      title: 'Sample Criminal Judgment',
      citation: '2024 SCMR 123',
      court: 'Supreme Court of Pakistan',
      caseNumber: 'Criminal Petition No. 123 of 2024',
      judgmentDate: '15 March 2024',
      judges: 'Honourable Supreme Court Bench',
      category: 'Criminal',
      relevantLaws: [
        'Section 497 Cr.P.C.',
        'Section 302 PPC',
      ],
      keywords: [
        'Bail',
        'Further Inquiry',
        'Criminal',
      ],
      summary:
          'Sample judgment entry for the LawLink360 judgment research system.',
      judgmentText:
          'This is sample judgment text. The actual structured judgment database will be connected later.',
    ),
    JudgmentModel(
      id: 'j002',
      title: 'Sample Property Judgment',
      citation: '2023 CLC 456',
      court: 'Lahore High Court',
      caseNumber: 'Civil Revision No. 456 of 2023',
      judgmentDate: '20 September 2023',
      judges: 'Honourable Lahore High Court Bench',
      category: 'Property',
      relevantLaws: [
        'Specific Relief Act',
        'Limitation Act',
      ],
      keywords: [
        'Property',
        'Specific Performance',
        'Limitation',
      ],
      summary:
          'Sample property judgment entry for testing the judgment module.',
      judgmentText:
          'This is sample judgment text for development and UI testing.',
    ),
    JudgmentModel(
      id: 'j003',
      title: 'Sample Family Judgment',
      citation: '2024 MLD 789',
      court: 'Islamabad High Court',
      caseNumber: 'Family Appeal No. 789 of 2024',
      judgmentDate: '10 January 2024',
      judges: 'Honourable Islamabad High Court Bench',
      category: 'Family',
      relevantLaws: [
        'Family Courts Act, 1964',
      ],
      keywords: [
        'Family',
        'Maintenance',
        'Custody',
      ],
      summary:
          'Sample family judgment entry for testing categories and search.',
      judgmentText:
          'This is sample judgment text for development and UI testing.',
    ),
  ];
}