class QuestionModel {
  final String questionText;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String categoryId;

  QuestionModel({
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.categoryId,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      questionText: map['question'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctIndex: map['answer_index'] ?? 0,
      explanation: map['explanation'] ?? '',
      categoryId: map['category_id'] ?? 'diger',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': questionText,
      'options': options,
      'answer_index': correctIndex,
      'explanation': explanation,
      'category_id': categoryId,
    };
  }
}