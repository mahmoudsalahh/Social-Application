import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:original_social_app/moduls/Map/map.dart';
import 'package:original_social_app/moduls/home_screen/home_screen.dart';
import 'package:original_social_app/moduls/register/register_cubit/cubit.dart';
import 'package:original_social_app/moduls/register/register_cubit/states.dart';
import 'package:original_social_app/shared/shared.component/component.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  bool obsecure = true;


  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        create: (BuildContext context)=>RegisterCubit(),
         child: BlocConsumer<RegisterCubit, SocialRegisterStates>(
        listener: (context , state){
          if (state is SocialCreateUserSuccessState) {
           navigateAndRemoveUntil(context, HomeScreen());
          }
          // else if(state is SocialCreateUserErrorState){
          //   showToast(
          //       text: state.error,
          //       state: ToastState.ERROR);
          // }
        },
    builder: (context , state)=>
      Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 900,
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.only(topRight: Radius.circular(40.0)),
              image:DecorationImage(image:AssetImage('assets/hhhh.jpg'),fit:BoxFit.cover ),
            ),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children:
                  [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height:100 ,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  //color: Colors.white.withOpacity(0.3),
                                  image: DecorationImage(image: AssetImage('assets/hhhhhhh.jpg')),
                                  borderRadius: BorderRadius.all(Radius.circular(20)),),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child:defaultTextButton(
                                onpressed:(){
                                  navigateTo(context, MapScreen());
                                } ,
                                text: 'My Map',
                                color: Colors.white70
                              ),
                              ),],
                          ),
                        ),
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15,),
                        Text(
                          'Register Now to communicate with your friends',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.grey,fontSize: 18),
                        ),
                        SizedBox(height: 40,),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15 , top: 22 ,left: 20 ,right: 20),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white12.withOpacity(0.1),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(65.0),topRight:Radius.circular(65.0) ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,

                            height: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    defaulttextformfeild(
                                        controller: nameController,
                                        label: 'Name',
                                        background: Colors.white,
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter Your Name';
                                          }
                                          return null;
                                        },
                                        prefix: Icons.person),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    defaulttextformfeild(
                                        controller: emailController,
                                        label: 'Email',
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return 'Email is Wrong';
                                          }
                                          return null;
                                        },
                                        prefix: Icons.email_outlined,
                                      background: Colors.white,

                                    ),
                                    SizedBox(height: 10.0,),
                                    defaulttextformfeild(
                                      controller: passwordController,
                                      label: 'Password',
                                      validate: (value) {
                                        if(value.isEmpty){
                                          return 'Password is Too Short';
                                        }
                                        return null ;
                                      },
                                      obsecureText: obsecure,
                                      suffixPressed: (){
                                        setState(() {
                                          obsecure = !obsecure;
                                        });
                                      },
                                      prefix: Icons.lock,
                                      background: Colors.white,
                                      suffix: obsecure? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                    ),
                                    SizedBox(height: 10.0,),
                                    defaulttextformfeild(
                                      controller: phoneController,
                                      label: 'Phone',
                                      validate: (value) {
                                        if(value.isEmpty){
                                          return 'Phone is not correct';
                                        }
                                        return null ;
                                      },
                                      prefix: Icons.phone,
                                      background: Colors.white,
                                    ),
                                    SizedBox(height: 15.0,),
                                    ConditionalBuilder(
                                      condition: state is! SocialRegisterLoudingState,
                                      builder:(context) =>  Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image:AssetImage('assets/hhhhhhh.jpg'),fit:BoxFit.fitWidth ),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(80.0),
                                              topRight:Radius.circular(80.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0)
                                          ),
                                        ),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                          child: defaultButton(
                                          onpressed: (){
                                            if(formKey.currentState!.validate()){
                                              RegisterCubit.get(context).registerUser(
                                                  email: emailController.text,
                                                  password: passwordController.text,
                                                name: nameController.text,
                                                phone: phoneController.text,

                                              );
                                          //navigateAndRemoveUntil(context, HomeScreen());
                                            } },
                                          text: 'REGISTER',color: Colors.white ),
                                      ),
                                      fallback: (context)=>Center(child: CircularProgressIndicator()),
                                    ),


                                  ],

                          ),
                            )

                  ),
                        ),

                ]),
                    ),
                ]),
              ),
            ),
          ),
      ),
    ))));
  }
}
