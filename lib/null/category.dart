

class Category {
  late String name;
  late String imgName;
  late int price;
  late int number;
  late List<Category> subCategories;

  Category(
      {required this.name,
      required this.imgName,
      required this.price,
      required this.number,
      required this.subCategories});
}
