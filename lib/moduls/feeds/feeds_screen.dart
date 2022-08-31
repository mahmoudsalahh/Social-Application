import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:original_social_app/models/post_model.dart';
import 'package:original_social_app/shared/social_cubit/cubit.dart';
import 'package:original_social_app/shared/social_cubit/state.dart';

class FeedsScreen extends StatelessWidget {
  var commentController = TextEditingController();
  bool like = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
         listener: (context ,state){},
      builder: (context ,state){

        return ConditionalBuilder(
          condition:SocialCubit.get(context).posts.length>0 && SocialCubit.get(context).model != null,
          builder:(context) =>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Card(
                          elevation: 10,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: EdgeInsets.only(right: 15 ,top: 15 , left: 15),
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: Image(image: AssetImage('assets/ggg.webp'),fit: BoxFit.fill,)),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text('Communicate With Friends' ,
                                  style: Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    fontFamily: 'FristLogin'
                                  ),),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index)=>addFeed(SocialCubit.get(context).posts[index],context,index),
                          separatorBuilder: (context,index) => Divider(color: Colors.grey,),
                          itemCount: SocialCubit.get(context).posts.length,
                        )
                      ],
                    )
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),

        );
      },
    );
  }

  Widget  addFeed (PostModel model ,context,index )=> Card(
    elevation: 10,
    margin: EdgeInsets.all(12),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:  NetworkImage('${model.image}'),

                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("${model.name}",style: Theme.of(context).textTheme.headline5?.copyWith(
                                fontSize: 15.0,fontWeight: FontWeight.bold,height: 1.5,
                            ),),
                            SizedBox(width: 2),
                            Icon(Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            )
                          ],
                        ),
                        Text("${model.dateTime}",style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontSize: 12.0,
                            color: Colors.grey
                        ),),

                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(width: 20,),
              IconButton(
                onPressed: (){},
                icon:Icon(Icons.more_vert,
                  size: 19,
                    color: Colors.black
                ),
              )
            ],
          ),
        ),
        Container(
          height: .5,
          color: Colors.grey,
        ),
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    style: TextStyle(
                        fontWeight: FontWeight.w700,height: 1.4,fontSize: 15),
                    maxLines: 5,
                    '${model.text}'),
                Text('#Friendship  #Mobile' ,
                  style: TextStyle(fontWeight: FontWeight.w500,
                      //fontFamily: 'FristLogin',
                      height: 1.6,color: Colors.blue),  )
              ],
            ),
          ),
          color: Colors.white,
        ),
        if(model.postImage != '')
        Padding(
          padding: const EdgeInsets.only(left: 13,right: 13),
          child: Image(image: NetworkImage('${model.postImage}'),height: 150,width: double.infinity,fit: BoxFit.cover,),
        ),

          Container(
            height:120,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              like = !like;
                              SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                            },
                              child: like ? Icon(Icons.favorite_border,size: 17,color: Colors.red,) : Icon(Icons.favorite,size: 17,color: Colors.red,)),
                          SizedBox(width: 5,),
                          Text('${SocialCubit.get(context).likes[index]}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.grey),),
                          Spacer(),
                          Icon(Icons.comment,size: 17,color: Colors.amberAccent,),
                          SizedBox(width: 5,),
                          Text('0 Comments',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.grey),),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Container(
                        height: .5,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: MediaQuery.of(context).size.height,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 17,
                              backgroundImage:  NetworkImage('${SocialCubit.get(context).model!.image}'),),

                            SizedBox(width: 15,),
                            Container(
                              height: 36,
                              width: 240,
                              child: TextField(decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                  hintText: 'Add Comment ...',
                                  hintStyle: TextStyle(fontSize: 13)
                              ),),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              height: 22,
                              width:22,
                            //margin: EdgeInsetsDirectional.all(2),
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage(
                                      'assets/hhhhhhh.jpg'), fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,)
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ],
    ),
  );
}