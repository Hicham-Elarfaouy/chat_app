class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phone;

  UserModel(this.uid, this.name, this.email, this.phone);

  UserModel.fromJson(Map<String, dynamic>? json){
    uid = json?['uid'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
  }

  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
