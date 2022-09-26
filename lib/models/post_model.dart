class PostModel {
  String? name;
  String? image;
  String? uId;
  String? postCaption;
  String? postImage;
  String? dateTime;

  PostModel({this.name,this.image,this.uId,this.postCaption,this.postImage,this.dateTime});

  PostModel.fromJson(Map<String,dynamic> json){
    name = json["name"];
    image = json["image"];
    uId = json["uId"];
    postCaption = json["postCaption"];
    postImage = json["postImage"];
    dateTime = json["dateTime"];
  }

  Map<String,dynamic> toMap(){
    return {
      "name": name,
      "image": image,
      "uId": uId,
      "postCaption": postCaption,
      "postImage": postImage,
      "dateTime": dateTime,
    };
  }
}