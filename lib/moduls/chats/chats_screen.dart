
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:original_social_app/models/user_model.dart';
import 'package:original_social_app/moduls/chat_details_screen/chat_details_screen.dart';
import 'package:original_social_app/shared/shared.component/component.dart';
import 'package:original_social_app/shared/social_cubit/cubit.dart';
import 'package:original_social_app/shared/social_cubit/state.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
        listener: (context ,state){},
        builder: (context ,state) {
          var userModel =SocialCubit.get(context).model;
          return Scaffold(
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image:AssetImage('assets/hhhh.jpg'),fit:BoxFit.cover ),),
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context , index)=> beUsers(SocialCubit.get(context).users![index] , context),
                    separatorBuilder: (context , index) => Divider(height: 0.2,color: Colors.grey,),
                    itemCount: SocialCubit.get(context).users!.length)
            ),
          );
        });
  }

// flutter pub run easy_localization:generate -O lib/core/lang -f keys -o locale_keys.g.
// dart --source-dir ./assets/translation
// flutter pub run easy_localization:generate
  // List<UserModel>? list ;
  Widget beUsers(UserModel? userModel ,context){
    return InkWell(
      onTap: (){
        navigateTo(context, ChatDetailsScreen(userModel));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage('${userModel!.image}'),
            ),
            SizedBox(width: 25,),
            Text('${userModel.name}',style: TextStyle(fontSize: 22 ,color: Colors.white),)
          ],
        ),
      ),
    );
  }}