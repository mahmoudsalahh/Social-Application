import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:original_social_app/moduls/login/login_cubit/states.dart';

class LoginCubit extends Cubit<SocialLoginStates>{

   LoginCubit() : super(SocialLoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  void loginUser({
    required String email ,
    required String password,
  }){
    emit(SocialLoginLoudingState());
   FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password
   ).then((value) {
     print(value.user!.email);
     print(value.user!.uid);
     emit(SocialLoginSuccessState(value.user!.uid));

   })
       .catchError((error){
     emit(SocialLoginErrorState(error.toString()));
     print(error.toString());
   });

  }

}
