
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:original_social_app/moduls/edit_profile/edit_profile_screen.dart';
import 'package:original_social_app/shared/shared.component/component.dart';
import 'package:original_social_app/shared/social_cubit/cubit.dart';
import 'package:original_social_app/shared/social_cubit/state.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
 BlocConsumer<SocialCubit , SocialStates>(
      listener: (context ,state){},
      builder: (context ,state) {
        var userModel =SocialCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)
                      )
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 170,
                            child: Image(image: NetworkImage('${userModel!.cover}'),
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,),
                          ),
                        ),
                        CircleAvatar(
                          radius: 51,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage('${userModel.image}'),

                          ),
                        )
                      ])),
              Text('${userModel.name}',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    height: 1.9
                ),),
              Text('${userModel.bio}',
                style: Theme
                    .of(context)
                    .textTheme
                    .caption!
                    .copyWith(
                    color: Colors.grey,
                    fontSize: 14,
                    height: 1.7

                ),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('100 ',
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                color: Colors.white,
                                fontSize: 20,
                                height: 1.9
                            ),),
                          Text('Posts',
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.7

                            ),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('256 ',
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                color: Colors.white,
                                fontSize: 20,
                                height: 1.9
                            ),),
                          Text('photos',
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.7

                            ),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('10K ',
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                color: Colors.white,
                                fontSize: 20,
                                height: 1.9
                            ),),
                          Text('Followers',
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.7

                            ),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('64 ',
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                color: Colors.white,
                                fontSize: 20,
                                height: 1.9
                            ),),
                          Text('Following',
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.7

                            ),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsetsDirectional.all(10),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(
                            'assets/hhhhhhh.jpg'), fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60.0),
                            topRight: Radius.circular(60.0),
                            topLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: defaultButton(
                          onpressed: () {},
                          text: 'Add Photo', color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsetsDirectional.all(10),
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(
                              'assets/hhhhhhh.jpg'), fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: IconButton(
                          onPressed: () {
                            navigateTo(context, EditProfileScreen());
                          },
                          icon: Icon(Icons.edit_note, color: Colors.white),
                        )
                    ),
                  ),


                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white12 ,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: OutlinedButton(
                          onPressed: (){
                            FirebaseMessaging.instance.subscribeToTopic('announcemect');
                          },
                          child: Text('SUBSCRIBE'  ,style: TextStyle(color: Colors.white,fontSize: 20 ,fontWeight: FontWeight.w700)),
                      )),
                  SizedBox(width: 50,),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white12 ,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: OutlinedButton(
                          onPressed: (){
                            FirebaseMessaging.instance.unsubscribeFromTopic('announcement');
                          },
                          child: Text('UNSUBSCRIBE',style: TextStyle(color: Colors.white,fontSize: 18 ,fontWeight: FontWeight.w700)),)),
                  )
                ],
              )
            ],
          ),
        );
      }
    );



  }
}