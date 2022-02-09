/// userToken : "sasdsdd"
/// uID : "asdss"
/// name : "asdss"
/// email : "asdss"
/// profileImage : "asdss"

class UserModel {
  String? userToken;
  String? uId;
  String? name;
  String? email;
  String? profileImage;

  UserModel({
      this.userToken, 
      this.uId,
      this.name, 
      this.email, 
      this.profileImage,});

  UserModel.fromJson(Map<String,dynamic> json) {
    userToken = json['userToken'];
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userToken'] = userToken;
    map['uId'] = uId;
    map['name'] = name;
    map['email'] = email;
    map['profileImage'] = profileImage;
    return map;
  }

}