class GetProducts {
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
  int? isLiked;

  GetProducts(
      {this.id,
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
      this.isLiked});

  GetProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    expirationDate = json['expiration_date'];
    price = json['price'];
    periods = json['periods'];
    quantity = json['quantity'];
    views = json['views'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    isLiked = json['is_liked'];
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
    data['is_liked'] = this.isLiked;

    return data;
  }
}
