import 'package:store/models/addproductclass.dart';

DateTime s = DateTime(2022, 2, 1);
DateTime s1 = DateTime(2021, 12, 30);
DateTime s2 = DateTime(2022, 1, 11);
DateTime s3 = DateTime(2022, 1, 31);

class Utils {
  static List<AddProduct> getproduct = [
    AddProduct(
      name: "Clothes",
      image: null,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0018/9005/8313/products/Infra_Red_Set_0edcadd5-4d6f-4b1f-ba69-6d2c36747e99.jpg?v=1622829052',
      contactNumber: 0934186624,
      expirationdate: s,
      category: "clothes",
      category_id: 0,
      quantity: 3,
      basicprice: 30,
      periods: '',
    ),
    AddProduct(
      name: "Food",
      image: null,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0018/9005/8313/products/Infra_Red_Set_0edcadd5-4d6f-4b1f-ba69-6d2c36747e99.jpg?v=1622829052',
      contactNumber: 0934186624,
      expirationdate: s,
      category: "food",
      quantity: 2,
      category_id: 0,
      basicprice: 30,
      periods: '',
    ),
    AddProduct(
      name: "Ps5",
      image: null,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0018/9005/8313/products/Infra_Red_Set_0edcadd5-4d6f-4b1f-ba69-6d2c36747e99.jpg?v=1622829052',
      contactNumber: 0934186624,
      expirationdate: s,
      category: "other",
      category_id: 0,
      quantity: 6,
      basicprice: 30,
      periods: '',
    ),
    AddProduct(
      name: "shoes",
      image: null,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0018/9005/8313/products/Infra_Red_Set_0edcadd5-4d6f-4b1f-ba69-6d2c36747e99.jpg?v=1622829052',
      contactNumber: 0934186624,
      expirationdate: s,
      category_id: 0,
      category: "clothes",
      quantity: 7,
      basicprice: 30,
      periods: '',
    ),
  ];
}
