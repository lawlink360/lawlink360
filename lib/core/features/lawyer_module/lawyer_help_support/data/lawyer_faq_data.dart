class LawyerFaqItem {
  final String question;
  final String answer;

  const LawyerFaqItem({
    required this.question,
    required this.answer,
  });
}

class LawyerFaqData {
  static const List<LawyerFaqItem> items = [
    LawyerFaqItem(
      question: 'How can I manage my appointments?',
      answer:
          'You can view and manage your lawyer appointments from the Appointments section.',
    ),
    LawyerFaqItem(
      question: 'How can I communicate with a client?',
      answer:
          'Open Messages and select the relevant client conversation.',
    ),
    LawyerFaqItem(
      question: 'How does lawyer verification work?',
      answer:
          'Verification allows lawyers to submit and manage their professional verification information.',
    ),
    LawyerFaqItem(
      question: 'Where can I manage my profile?',
      answer:
          'You can manage your professional profile from the Settings section.',
    ),
    LawyerFaqItem(
      question: 'How can I get help with payments?',
      answer:
          'For payment and earnings questions, contact LawLink360 support.',
    ),
  ];
}