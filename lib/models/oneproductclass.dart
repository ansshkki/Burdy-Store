import 'package:store/models/addusersclass.dart';

class OneProduct {
  int? id;
  String? name;
  String? imageUrl;
  String? expirationDate;
  num? price;
  String? periods;
  int? quantity;
  int? views;
  int? userId;
  int? categoryId;
  int? commentsCount;
  int? likesCount;
  num? currentPrice;

  // int? isLiked;
  User? user;
  List<String>? comments;

  //List<int>? likes;
  int? current_sale;

  OneProduct({
    this.id,
    this.name,
    this.imageUrl,
    this.expirationDate,
    this.price,
    this.periods,
    this.quantity,
    this.views,
    this.userId,
    this.categoryId,
    this.commentsCount,
    this.likesCount,
    this.currentPrice,
    //  this.isLiked,
    this.user,
    //  this.comments,
    //  this.likes
    this.current_sale,
  });

  OneProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    expirationDate = json['expiration_date'];
    price = json['price'];
    // periods = json['periods'];
    quantity = json['quantity'];
    views = json['views'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    currentPrice = json['current_price'];
    current_sale = json['current_sale'];
    // isLiked = json['is_liked'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    //  if (json['comments'] != null) {
    //    comments = [];
    //    json['comments'].forEach((v) {
    //      comments!.add(v);
    // });
    //  }
    //  if (json['likes'] != null) {
    //   // likes = new List<Null>();
    //    json['likes'].forEach((v) {
    //      likes!.add(v);
    //    });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    data['expiration_date'] = this.expirationDate;
    data['price'] = this.price;
    data['periods'] = this.periods;
    data['quantity'] = this.quantity;
    data['views'] = this.views;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['comments_count'] = this.commentsCount;
    data['likes_count'] = this.likesCount;
    data['current_price'] = this.currentPrice;
    //  if (this.user != null) {
    //    data['user'] = this.user.toJson();
    //  }
    // if (this.comments != null) {
    //   data['comments'] = this.comments.map((v) => v.toJson()).toList();
    // }
    // if (this.likes != null) {
    //   data['likes'] = this.likes.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

/*class User {
  int id;
  String name;
  String email;
  String phone;
  String address;

  User({this.id, this.name, this.email, this.phone, this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}*/
