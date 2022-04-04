class PostModel{
  String? uid;
  String? profile;
  String? name;
  String? date;
  String? text;
  String? image;
  int? likes;
  int? comments;

  PostModel (this.uid,this.profile,this.name,this.date,this.text,{this.image,this.likes,this.comments});

  PostModel.fromJson(Map<String, dynamic>? json){
    uid = json?['uid'];
    profile = json?['profile'];
    name = json?['name'];
    date = json?['date'];
    text = json?['text'];
    likes = json?['likes'];
    image = json?['image'];
    comments = json?['comments'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'profile': profile,
      'name': name,
      'date': date,
      'text': text,
      'likes': likes,
      'image': image,
      'comments': comments,
    };
  }
}