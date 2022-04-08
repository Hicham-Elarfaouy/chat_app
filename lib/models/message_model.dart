class MessageModel{
  String? idReceiver;
  String? idSender;
  String? date;
  String? message;

  MessageModel(this.idReceiver,this.idSender,this.date,this.message);

  MessageModel.fromJson(Map<String, dynamic>? json){
    idReceiver = json?['idReceiver'];
    idSender = json?['idSender'];
    date = json?['date'];
    message = json?['message'];
  }

  Map<String, dynamic> toMap() {
    return {
      'idReceiver': idReceiver,
      'idSender': idSender,
      'date': date,
      'message': message,
    };
  }
}