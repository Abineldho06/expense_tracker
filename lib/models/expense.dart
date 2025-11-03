class Expense {
  int? id;
  int categoryId;
  double amount;
  String note;
  String date;

  Expense({
    this.id,
    required this.categoryId,
    required this.amount,
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'amount': amount,
      'note': note,
      'date': date,
    };
  }
}
