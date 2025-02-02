class FAQModel {
  // final int id;
  final String question;
  final String answer;
  final String? ket;

  FAQModel({this.ket, required this.question, required this.answer});

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(
      // id: json['id'],
      question: json['question'],
      answer: json['answer'],
      ket: json['field_extra'],
    );
  }
}
