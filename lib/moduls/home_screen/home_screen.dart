
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:original_social_app/moduls/Posts/posts_screen.dart';
import 'package:original_social_app/moduls/search/search_screen.dart';
import 'package:original_social_app/shared/shared.component/component.dart';
import 'package:original_social_app/shared/social_cubit/cubit.dart';

import '../../shared/social_cubit/state.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit ,SocialStates>(
      listener: (BuildContext context, Object? state) {
        if(state is SocialAddPostState){
          navigateTo(context, PostsScreen());
        }
      },
      builder: (BuildContext context, state) {
        var userModel =SocialCubit.get(context).model;
    return Scaffold(
            body: Container(
          decoration: BoxDecoration(
             image: DecorationImage(image:AssetImage('assets/hhhh.jpg'),fit:BoxFit.cover ),),
              child: SocialCubit.get(context).screens[SocialCubit.get(context).currentIndex],
            ),
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(SocialCubit.get(context).titles[SocialCubit.get(context).currentIndex]),
              actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search)),
              ],
            ),

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: SocialCubit.get(context).currentIndex,
              items: SocialCubit.get(context).items,
              unselectedItemColor:Colors.grey,
              selectedItemColor:Colors.white,
             elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              onTap: (index){
                SocialCubit.get(context).changeIndex(index);
              },

            ),
          ) ;
      }

    );
  }
}
