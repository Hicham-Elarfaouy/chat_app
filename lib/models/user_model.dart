class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? bio;
  String? image;
  String? cover;

  UserModel(this.uid, this.name, this.email, this.phone,{this.image,this.bio,this.cover});

  UserModel.fromJson(Map<String, dynamic>? json){
    uid = json?['uid'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    bio = json?['bio'];
    image = json?['image'];
    cover = json?['cover'];
  }

  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'bio': bio,
      'image': image,
      'cover': cover,
    };
  }
}
