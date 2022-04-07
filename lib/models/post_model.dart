class PostModel{
  String? uid;
  String? profile;
  String? name;
  String? date;
  String? text;
  String? image;
  List? likes;
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
    comments = json?['comments'].round();
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

class CommentModel{
  String? profile;
  String? name;
  String? date;
  String? text;

  CommentModel(this.profile,this.name,this.date,this.text);

  CommentModel.fromJson(Map<String, dynamic>? json){
    profile = json?['profile'];
    name = json?['name'];
    date = json?['date'];
    text = json?['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'profile': profile,
      'name': name,
      'date': date,
      'text': text,
    };
  }
}