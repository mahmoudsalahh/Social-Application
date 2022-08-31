import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:original_social_app/models/messege_model.dart';
import 'package:original_social_app/models/user_model.dart';
import 'package:original_social_app/shared/social_cubit/cubit.dart';
import 'package:original_social_app/shared/social_cubit/state.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;
  ChatDetailsScreen(this.userModel);
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context ){
      SocialCubit.get(context).getMessage(receiverId: userModel!.uId);
         return BlocConsumer<SocialCubit , SocialStates>(
  listener: (context , state){},
  builder: (context , state)=> Scaffold(
    appBar:  AppBar(
      backgroundColor: Colors.black,
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('${userModel!.image}'),
          ),
          SizedBox(width: 15,),
          Text('${userModel!.name}')
        ],
      ),
    ),
    body: ConditionalBuilder(
      condition: SocialCubit.get(context).messages.length >= 0,
      builder: (context ) =>Container(
        decoration: BoxDecoration(
          image: DecorationImage(image:AssetImage('assets/hhhh.jpg'),fit:BoxFit.cover ),),
        child:  Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
             Expanded(
               child: ListView.separated(
                   itemBuilder: (context , index) {
                     var message = SocialCubit.get(context).messages[index];
                     if( SocialCubit.get(context).model!.uId ==  message.senderId  )
                       return buildMyMessage(message);

                     return buildMessage(message);
                   },
                   separatorBuilder: (context , index) => SizedBox(height: 0.0,),
                   itemCount: SocialCubit.get(context).messages.length),
             ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1
                      ),
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            style: TextStyle(color: Colors.grey , fontSize: 22 , fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type your Messege',
                                hintStyle: TextStyle(color: Colors.grey , fontSize: 20),
                                fillColor: Colors.grey
                              //helperStyle: TextStyle(color: Colors.grey)
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(17)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: MaterialButton(
                            color: Colors.white12,
                            onPressed: (){
                              SocialCubit.get(context).sendMessage(
                                  receiverId: userModel!.uId,
                                  messageDate: DateTime.now().toString(),
                                  message: messageController.text
                              );
                              messageController.text = '';
                            },
                            child: Icon(Icons.arrow_forward_ios , color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,)
            ],

          ),
        ),),
      fallback: (context )=> Center(child: CircularProgressIndicator()),

    ),

  ),
);
    });
  }
  Widget buildMessage(MessageModel model)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal:  20.0 ,vertical: 5),
    child: Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft:Radius.circular(15.0),bottomRight: Radius.circular(15.0), )
          ),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text('${model.message}',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 18),),
          )),
    ),
  );
  Widget buildMyMessage(MessageModel model)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal:  20.0 ,vertical: 5),
    child: Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft:Radius.circular(15.0),bottomLeft: Radius.circular(15.0), )
          ),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text('${model.message}',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 18,),),
          )),
    ),
  );

}
