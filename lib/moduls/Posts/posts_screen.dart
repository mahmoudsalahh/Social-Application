import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:original_social_app/moduls/home_screen/home_screen.dart';
import 'package:original_social_app/shared/shared.component/component.dart';
import 'package:original_social_app/shared/social_cubit/cubit.dart';
import 'package:original_social_app/shared/social_cubit/state.dart';

class PostsScreen extends StatelessWidget {
  //const PostsScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit , SocialStates>
      (
        listener: (context ,state){
          if(state is SocialCreatePostSuccessState){
            navigateTo(context, HomeScreen());
            SocialCubit.get(context).removePostImage();
          }
        },
    builder: (context ,state) {
    var userModel =SocialCubit.get(context).model;
      return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Add Post'),
        actions: [
          Container(
            height: 30,
            width: 80,
            margin: EdgeInsetsDirectional.all(12),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(
                    'assets/hhhhhhh.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20)
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: OutlinedButton(
              child: Text('Post',style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold,color: Colors.white),),
              onPressed: (){
                var now =DateTime.now();
                if(SocialCubit.get(context).postImage == null){
                  SocialCubit.get(context).createPost(
                    dateTime: now.toString() ,
                    text: textController.text,);

                }
                if(SocialCubit.get(context).postImage != null){
                  SocialCubit.get(context).uploadPostImage(
                      dateTime: now.toString() ,
                      text: textController.text);
                }
                },
            ),
          ),
        ],
      ),
      body: Container(
    decoration: BoxDecoration(
    image: DecorationImage(image:AssetImage('assets/hhhh.jpg'),fit:BoxFit.cover ),),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              if(state is SocialCreatePostLoudingState)
              LinearProgressIndicator(color: Colors.orange,),
             SizedBox(height: 20,),
                Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
          CircleAvatar(
          radius: 30,
                    backgroundImage: NetworkImage('${userModel!.image}'),),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Text('Mahmoud Salah',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                  height: 1.9
                              ),),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'What is in your Mind ...',
                          hintStyle: TextStyle(color: Colors.grey , fontWeight: FontWeight.w700),
                          //enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(color: Colors.white) ),
                          hoverColor: Colors.white,
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.white , fontSize: 20.0),
                        controller: textController,
                      )
                    ],
                  ),
                ),
              ),
              if (SocialCubit.get(context).postImage!= null)
              Stack(
                // alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 170,
                        child:  Image.file(SocialCubit.get(context).postImage!, height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.orangeAccent,
                          child: IconButton(
                              onPressed: (){
                                SocialCubit.get(context).removePostImage();
                              },
                              icon: Icon(Icons.close),color: Colors.white,iconSize: 15.5),),
                      ),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: (){
                          SocialCubit.get(context).getPostImage();
                        }, child: Row(
                      children: [
                        Icon(Icons.image,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text('Add Photo',style: TextStyle(
                          color: Colors.white ,
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                        ),)
                      ],
                    )),
                  ),
                  Expanded(
                    child: TextButton(onPressed: (){}, child: Text('#Tags',style: TextStyle(
                        color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),)),
                  ),

                ],
              )
            ],
          ),
        ),
    ),
    );
        });
  }
}
