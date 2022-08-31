import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:original_social_app/moduls/home_screen/home_screen.dart';
import 'package:original_social_app/moduls/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:original_social_app/shared/constant.dart';
import 'package:original_social_app/shared/shared.component/component.dart';
import 'package:original_social_app/shared/shared.network/cashe_helper/cashe_helper.dart';
import 'package:original_social_app/shared/social_cubit/cubit.dart';
import 'package:original_social_app/shared/social_cubit/state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  showToast(text: 'Background Message For you', state: ToastState.SUCCESS);
}
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  var token = await FirebaseMessaging.instance.getToken();
  print('token:$token');
   FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'On Message For you', state: ToastState.SUCCESS);
   });
   FirebaseMessaging.onMessageOpenedApp
      .listen((event) {
    print(event.data.toString());
    showToast(text: 'On Message Open For you', state: ToastState.SUCCESS);
   });
   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  uId = CacheHelper.getData(key: 'uId');
  Widget widget;
  if (uId == null){
    widget = LoginScreen();
  }else {
    widget = HomeScreen();
  }
  runApp(
    MyApp(
      isWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget? isWidget;
  MyApp({this.isWidget});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>SocialCubit()..getUserData()..getPosts(),)
      ],
      child:  BlocConsumer<SocialCubit , SocialStates>(
    listener: (context ,state){},
    builder: (context ,state)=>
        MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:isWidget,
      ),
    ));
  }
}

