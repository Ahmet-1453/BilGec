class QuestionModel {
  final String id;
  final String categoryId;
  final String questionText;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  QuestionModel({
    required this.id,
    required this.categoryId,
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '',
      categoryId: json['categoryId'] ?? '',
      questionText: json['questionText'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctIndex: json['correctIndex'] ?? 0,
      explanation: json['explanation'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'options': options,
      'correctIndex': correctIndex,
      'explanation': explanation,
      'categoryId': categoryId,
    };
  }
}