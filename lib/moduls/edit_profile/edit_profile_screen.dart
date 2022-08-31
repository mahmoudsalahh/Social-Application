import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:original_social_app/shared/shared.component/component.dart';
import 'package:original_social_app/shared/social_cubit/cubit.dart';
import 'package:original_social_app/shared/social_cubit/state.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
        listener: (context ,state){},
    builder: (context ,state) {
    var userModel =SocialCubit.get(context).model;
    var profilImage = SocialCubit.get(context).profileImage;
    var coverImage = SocialCubit.get(context).coverImage;
    bioController.text = userModel!.bio!;
    nameController.text = userModel.name!;
   phoneController.text = userModel.phone!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Edit your Profile'),
        actions: [
          InkWell(
            onTap: (){
              SocialCubit.get(context).updateUserData(name: nameController.text, phone: phoneController.text ,bio:bioController.text );

            },
            child: Container(
              height: 30,
              width: 80,
              margin: EdgeInsetsDirectional.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(
                    'assets/hhhhhhh.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20)
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Center(child: Text('Update',style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold,color: Colors.white),)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/hhhh.jpg'), fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    if (state is SocialupdateUserLoudingState)
                      SizedBox(height: 10,),
                    if (state is SocialupdateUserLoudingState)
                    LinearProgressIndicator(color: Colors.white,backgroundColor: Colors.orange),
                    SizedBox(height: 10,),
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
                           // alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                  height: 170,
                                  //child: profilImage == null ? Image(image: NetworkImage('${userModel.image}')):Image.file(profilImage,fit: BoxFit.fill),

                                  child: coverImage == null ? Image.network('${userModel.cover}', height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,): Image.file(coverImage,height: 150,
                                  width: double.infinity,fit: BoxFit.cover,)
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
                                            SocialCubit.get(context).getCoverImage();
                                          },
                                          icon: Icon(Icons.add_a_photo_outlined),color: Colors.white,iconSize: 15.5),),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    CircleAvatar(
                                      radius: 51,
                                      backgroundColor: Colors.grey,
                                      child: CircleAvatar(
                                        child: profilImage == null ? Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              image:DecorationImage(image: NetworkImage('${userModel.image}'),fit: BoxFit.cover),)) :
                                        Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image:DecorationImage(image: FileImage(profilImage),fit: BoxFit.cover),),

                                          ),

                                        radius: 50,
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.orangeAccent,
                                      child: IconButton(
                                          onPressed: (){
                                           SocialCubit.get(context).getProfilImage();
                                          },
                                          icon: Icon(Icons.add_a_photo_outlined),color: Colors.white,iconSize: 15.5),),
                                  ],
                                ),
                              )
                            ])),
            SizedBox(height: 15,),
            if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
            Row(
              children: [
                if(SocialCubit.get(context).coverImage != null)
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
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
                            onpressed: () {
                              SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);

                            },
                            text: 'Upload Cover', color: Colors.white),
                      ),
                      if (state is SocialupdateUserLoudingState)
                        Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: LinearProgressIndicator(color: Colors.white,backgroundColor: Colors.orange),
                      ),
                    ],
                  ),
                ),
                if(SocialCubit.get(context).profileImage != null)
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
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
                          child: defaultButton(
                              onpressed: () {
                                SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                              },
                              text: 'Upload Profile', color: Colors.white),
                      ),
                      if (state is SocialupdateUserLoudingState)
                        Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: LinearProgressIndicator(color: Colors.white,backgroundColor: Colors.orange),
                      ),
                    ],
                  ),
                ),

              ]),
            if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)

                    SizedBox(height: 20,),
                    defaulttextformfeild(
                        background: Colors.white,
                      type: TextInputType.name,
                        controller: nameController,
                        label: 'name',
                        validate: (value){
                        if(value.isEmpty)
                          {
                            return 'name must Entered';
                          }
                        return null;
                        },
                        prefix: Icons.person_outline_sharp),
                    SizedBox(height: 20,),
                    defaulttextformfeild(
                        background: Colors.white,
                        type: TextInputType.name,
                        controller: bioController,
                        label: 'Bio',
                        validate: (value){
                          if(value.isEmpty)
                          {
                            return 'bio must Entered';
                          }
                          return null;
                        },
                        prefix: Icons.add_circle),
                    SizedBox(height: 20),
                    defaulttextformfeild(
                        background: Colors.white,
                        type: TextInputType.name,
                        controller: phoneController,
                        label: 'Phone',
                        validate: (value){
                          if(value.isEmpty)
                          {
                            return 'bio must Entered';
                          }
                          return null;
                        },
                        prefix: Icons.add_circle)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
     );
        },
    );
  }
  }

