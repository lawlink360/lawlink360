class FaqItem {
  final String question;
  final String answer;
  final bool expanded;

  const FaqItem({
    required this.question,
    required this.answer,
    this.expanded = false,
  });
}