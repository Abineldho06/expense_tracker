class User {
  int? id;
  String? name, email;
  int? budget;
  int? income;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.budget,
    required this.income,
  });

  Map<String, dynamic> toMap() {
    return {"name": name, "email": email, "budget": budget, "income": income};
  }
}
