class MessageModel {
  String? messageDate ;
  String? receiverId;
  String? senderId;
  String? message;



  MessageModel({this.message,this.messageDate,this.receiverId,this.senderId,});

  MessageModel.formJson(Map<String , dynamic> json){
    message = json['message'];
    messageDate = json['massageDate'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];

  }

  Map<String , dynamic> MessageMap(){
    return {
      'message' : message,
      'messageDate' : messageDate,
      'senderId' : senderId,
      'receiverId' : receiverId,

    };
  }

}