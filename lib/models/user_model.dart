class UserModel {
   String? email ;
   String? name;
   String? phone;
   String? uId;
   String? image;
   String? bio;
   String? cover;


   UserModel({this.email,this.name,this.phone,this.uId,this.bio ,this.image,this.cover});

   UserModel.formJson(Map<String , dynamic> json){
     email = json['email'];
     name = json['name'];
     phone = json['phone'];
     uId = json['uId'];
     image = json['image'];
     bio = json['bio'];
     cover = json['cover'];

   }

   Map<String , dynamic> userMap(){
      return {
         'email' : email,
         'name' : name,
         'phone' : phone,
         'uId' : uId,
        'image' : image,
        'bio' : bio,
        'cover' : cover,

      };
   }

}