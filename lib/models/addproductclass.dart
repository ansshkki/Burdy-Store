import 'dart:io' as used;

class AddProduct {
  String? name;
  used.File? image;
  String? imageUrl;
  DateTime? expirationdate;
  String? category;
  double category_id;
  double contactNumber;
  double quantity;
  double basicprice;
  String periods;

  AddProduct(
      {required this.name,
      required this.image,
      this.imageUrl,
      required this.category,
      required this.category_id,
      required this.expirationdate,
      required this.contactNumber,
      required this.quantity,
      required this.basicprice,
      required this.periods});
}
