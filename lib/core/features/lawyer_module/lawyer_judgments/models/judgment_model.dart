class JudgmentModel {
  final String id;
  final String title;
  final String citation;
  final String court;
  final String caseNumber;
  final String judgmentDate;
  final String judges;
  final String category;
  final List<String> relevantLaws;
  final List<String> keywords;
  final String summary;
  final String judgmentText;

  const JudgmentModel({
    required this.id,
    required this.title,
    required this.citation,
    required this.court,
    required this.caseNumber,
    required this.judgmentDate,
    required this.judges,
    required this.category,
    required this.relevantLaws,
    required this.keywords,
    required this.summary,
    required this.judgmentText,
  });

  JudgmentModel copyWith({
    String? id,
    String? title,
    String? citation,
    String? court,
    String? caseNumber,
    String? judgmentDate,
    String? judges,
    String? category,
    List<String>? relevantLaws,
    List<String>? keywords,
    String? summary,
    String? judgmentText,
  }) {
    return JudgmentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      citation: citation ?? this.citation,
      court: court ?? this.court,
      caseNumber: caseNumber ?? this.caseNumber,
      judgmentDate: judgmentDate ?? this.judgmentDate,
      judges: judges ?? this.judges,
      category: category ?? this.category,
      relevantLaws: relevantLaws ?? this.relevantLaws,
      keywords: keywords ?? this.keywords,
      summary: summary ?? this.summary,
      judgmentText: judgmentText ?? this.judgmentText,
    );
  }
}