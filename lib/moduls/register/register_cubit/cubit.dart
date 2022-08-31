import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:original_social_app/models/user_model.dart';
import 'package:original_social_app/moduls/register/register_cubit/states.dart';

class RegisterCubit extends Cubit<SocialRegisterStates> {
  RegisterCubit() : super(SocialRegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoudingState());
    print('object');
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      CreateUser(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
      //emit(SocialRegisterSuccessState());
    })
        .catchError((error) {
      emit(SocialRegisterErrorState(error));
      // print(error.toString());
    });
  }

  void CreateUser({
    required String email,
    required String name,
    required String phone,
    required String uId,
    String? image,
    String? bio,
    String? cover,
  }) {
    UserModel userModel = UserModel(
        email:email,
        name:name,
        phone:phone,
        uId:uId,
        bio:"bio ...",
        image:'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
        cover:'https://img.freepik.com/free-photo/landscape-tropical-green-forest_181624-30814.jpg'
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.userMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error));
    });
  }


  ImagePicker imagepicker = ImagePicker();
  XFile? userImage;
  Image(String Camera) async {
    if (Camera == "cam") {
      userImage = await imagepicker.pickImage(source: ImageSource.camera);
      return userImage?.readAsBytes();
    }
  }
}
