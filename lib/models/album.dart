class Album {
  final int id;
  final String name;
  DateTime expirationdate;
  final int amount;
  final double price;

  Album(
      {required this.id,
      required this.name,
      required this.expirationdate,
      required this.amount,
      required this.price});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        id: json['category_id'],
        name: json['name'],
        expirationdate: json['expiration_date'],
        amount: json['quantity'],
        price: json['price']);
  }
}
