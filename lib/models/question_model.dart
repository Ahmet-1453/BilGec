class QuestionModel {
  final String id;
  final String categoryId;
  final String questionText;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  QuestionModel({
    this.id = '',
    required this.categoryId,
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  // JSON'dan Model üretme
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '',
      categoryId: json['categoryId'] ?? 'diger',
      questionText: json['questionText'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctIndex: json['correctIndex'] ?? 0,
      explanation: json['explanation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'questionText': questionText,
      'options': options,
      'correctIndex': correctIndex,
      'explanation': explanation,
    };
  }
}