class BudgetItem {
  String id;
  String category;
  double totalBudget;
  double spent;

  BudgetItem({
    required this.id,
    required this.category,
    required this.totalBudget,
    required this.spent,
  });

  factory BudgetItem.fromMap(Map<String, dynamic> data, String id) {
    return BudgetItem(
      id: id,
      category: data['category'] ?? '',
      totalBudget: data['totalBudget']?.toDouble() ?? 0.0,
      spent: data['spent']?.toDouble() ?? 0.0,
    );
  }
}
