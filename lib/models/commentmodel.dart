class CommentModel {
  String? body;
  String? username;

  CommentModel({this.body, this.username});

  CommentModel.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['username'] = this.username;
    return data;
  }
}
