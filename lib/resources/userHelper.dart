class UserHelper {
  final String imageUrl;
  final String? mediaPost;
  final String name;
  final String email;
  final String id;
  final String period;
  final String? message;

  UserHelper(this.imageUrl, this.mediaPost, this.name, this.email, this.id,
      this.period, this.message);

  Map<String, dynamic> toJson() => {
        'imageUrl': imageUrl,
        'mediaPost': mediaPost,
        'name': name,
        'email': email,
        'id': id,
        'period': period,
        'message': message
      };

  static UserHelper fromJson(Map<String, dynamic> json) => UserHelper(
      json['imageURl'],
      json['mediaPost'],
      json['name'],
      json['email'],
      json['id'],
      json['period'],
      json['message']);
}

class MessageField {
  static String createdAt = 'createdAt';
}
