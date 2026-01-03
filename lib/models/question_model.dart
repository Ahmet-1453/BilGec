class QuestionModel {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String categoryId;
  final String explanation;

  QuestionModel({
    required this.question,
    required this.options,
    required this.correctIndex,
    this.categoryId = 'genel',
    this.explanation = '',
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['questionText'] ?? json['question'] ?? json['text'] ?? 'Soru Yüklenemedi',
      options: List<String>.from(json['options'] ?? []),
      correctIndex: json['correctIndex'] ?? json['answer_index'] ?? 0,
      categoryId: json['categoryId'] ?? 'genel',
      explanation: json['explanation'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctIndex': correctIndex,
      'categoryId': categoryId,
      'explanation': explanation,
    };
  }
}