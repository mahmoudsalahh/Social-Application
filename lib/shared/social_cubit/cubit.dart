import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:original_social_app/models/messege_model.dart';
import 'package:original_social_app/models/post_model.dart';
import 'package:original_social_app/models/user_model.dart';
import 'package:original_social_app/moduls/Posts/posts_screen.dart';
import 'package:original_social_app/moduls/chats/chats_screen.dart';
import 'package:original_social_app/moduls/feeds/feeds_screen.dart';
import 'package:original_social_app/moduls/settings/sittings_screen.dart';
import 'package:original_social_app/moduls/users/users_screen.dart';
import 'package:original_social_app/shared/constant.dart';
import 'state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void changeIndex(int index) {
    if (index == 1)
    getAllUsers();
    if (index == 2)
      emit(SocialAddPostState());
    else {
      currentIndex = index;
      emit(SocialChangeItemState());
    }
  }

  List <Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    PostsScreen(),
    UserScreen(),
    SettingsScreen()

  ];
  List <String> titles = [
    'Feeds',
    'Chats',
    'Posts',
    'Users',
    'Settings'
  ];
  List <BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(Icons.menu),
        label: 'Feeds'

    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: 'Chats'


    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.upload_file_outlined),
        label: 'Post'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.supervised_user_circle_sharp),
        label: 'Users'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings'
    ),
  ];
  UserModel? model;

  void getUserData() {
    emit(SocialUserLoudingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId).get().then((value) {
      model = UserModel.formJson(value.data()!);
      print(model!.uId);
      emit(SocialUserSuccessState());
    }).catchError((error) {
      emit(SocialUserErrorState());
    });
  }

  //
  // Image(String Camera)async{
  //   if(Camera =="cam"){
  //     userImage= await imagePicker.pickImage(source: ImageSource.camera);
  //     await storage.ref().child("images/").child("${registerUser.id}.jpg").putFile(File(userImage!.path));
  //     registerUser.photoUrl= await storage.ref().child("images/").child("${registerUser.id}.jpg").getDownloadURL();
  //     return userImage?.readAsBytes();
  //   }else{
  //     userImage=await imagePicker.pickImage(source: ImageSource.gallery);
  //   }
  //
  // }
  File? profileImage;

  ImagePicker picker = ImagePicker();

  Future<void> getProfilImage() async {
    //emit(SocialProfileImageLoudingState());
    var imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      profileImage = File(imageFile.path);
      print('ffffg');
      emit(SocialProfileImageSuccessState());
    }
    else {
      print('no image uploaded');
      emit(SocialProfileImageErrorState());
    }
  }


  File? coverImage;

  Future<void> getCoverImage() async {
    var imageFile1 = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile1 != null) {
      coverImage = File(imageFile1.path);
      print('image uploaded');
      emit(SocialCoverImageSuccessState());
    }
    else {
      print('no image uploaded');
      emit(SocialCoverImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String? bio,}) {
    emit(SocialupdateUserLoudingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        updateUserData(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String? bio,}) {
    emit(SocialupdateUserLoudingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        updateUserData(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String? bio,
  // }) {
  //   emit(SocialupdateUserLoudingState());
  //    if(coverImage != null){
  //   uploadCoverImage();
  //   }
  //   else if(profileImage != null){
  //     uploadProfileImage();
  //   }
  //
  //   else if(coverImage != null && profileImage != null){}
  //   else{
  //     updateUserData(
  //       bio: bio ,
  //       phone : phone,
  //       name: name,
  //     );
  //   }
  //   }
  void updateUserData({
    required String name,
    required String phone,
    required String? bio,
    String? image,
    String? cover,

  }) {
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? model!.image,
      cover: cover ?? model!.cover,
      email: model!.email,
      uId: model!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(userModel.userMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialupdateUserDataErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    var imageFile = await picker.pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      postImage = File(imageFile.path);
      print('image uploaded');
      emit(SocialPostImagePickedSuccessState());
    }
    else {
      print('no image uploaded');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    String? name,
    String? uId,
    String? image,
    required String? dateTime,
    required String? text,}) {
    emit(SocialCreatePostLoudingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
            name: name,
            uId: uId,
            image: image,
            dateTime: dateTime,
            text: text,
            postImage: value);
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    String? name,
    String? uId,
    String? image,
    required String? dateTime,
    required String? text,
    String? postImage,

  }) {
    PostModel postModel = PostModel(
      name: model!.name,
      uId: model!.uId,
      image: model!.image,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );
    //emit(SocialCreatePostLoudingState());
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.postMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialPostImageRemoverState());
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference
            .collection('likes')
            .get()
            .then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.formJson(element.data()));
          emit(SocialGetPostSuccessState());
        })
            .catchError((error) {

        });
      });

    })
        .catchError((error) {
      emit(SocialGetPostErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like': true
    })
        .then((value) {
      emit(SocialLikePostSuccessState());
    })
        .catchError((error) {
      emit(SocialLikePostErrorState());
    });


    void likePost(String postId, String comment) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(model!.uId)
          .set({
        'comment': comment
      })
          .then((value) {
        emit(SocialLikePostSuccessState());
      })
          .catchError((error) {
        emit(SocialLikePostErrorState());
      });
    }
  }
List<UserModel>? users ;
  void getAllUsers(){
    users = [];
    emit(SocialGetAllUsersLoudingState());
    FirebaseFirestore.instance
        .collection('users')
        .get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != model!.uId)
        users!.add(UserModel.formJson(element.data()));
      });
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetAllUsersErrorState());
    });
  }

  sendMessage({
    String? messageDate ,
    String? receiverId,
    String? message
}){
    MessageModel messageModel = MessageModel(
      message: message,
      messageDate: messageDate,
      receiverId:receiverId ,
      senderId: model!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel
        .MessageMap())
        .then((value){
          emit(SocialSendMessageSuccessState());
    }).catchError((error){});
    emit(SocialSendMessageSuccessState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel
        .MessageMap())
        .then((value){
      emit(SocialSendMessageSuccessState());
    }).catchError((error){});
    emit(SocialSendMessageSuccessState());
  }
List <MessageModel> messages = [];
  getMessage({
    String? receiverId,
  }){

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('messageDate')
        .snapshots()
        .listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModel.formJson(element.data()));
          });
          emit(SocialGetMessageSuccessState());

        });

  }

}