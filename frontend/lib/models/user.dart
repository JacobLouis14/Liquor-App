class UserData {
  String? token;
  User? user;

  UserData({this.token, this.user});

  UserData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  bool? isAdmin;
  String? dateOfBirth;
  List<String>? wishlist;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
      this.name,
      this.email,
      this.isAdmin,
      this.dateOfBirth,
      this.wishlist,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['Name'];
    email = json['Email'];
    isAdmin = json['IsAdmin'];
    dateOfBirth = json['DateOfBirth'];
    wishlist = json['Wishlist'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['IsAdmin'] = this.isAdmin;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Wishlist'] = this.wishlist;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
