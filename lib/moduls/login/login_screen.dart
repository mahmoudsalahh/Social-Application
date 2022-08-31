import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:original_social_app/moduls/home_screen/home_screen.dart';
import 'package:original_social_app/moduls/login/login_cubit/cubit.dart';
import 'package:original_social_app/moduls/login/login_cubit/states.dart';
import 'package:original_social_app/moduls/register/register_screen.dart';
import 'package:original_social_app/shared/shared.component/component.dart';
import 'package:original_social_app/shared/shared.network/cashe_helper/cashe_helper.dart';

class LoginScreen extends StatefulWidget {
  //const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value)
            { navigateAndRemoveUntil(context, HomeScreen());}
            );



        }else if(state is SocialLoginErrorState){
            showToast(
                text: state.error,
                state: ToastState.ERROR);
          }
          },
        builder: (context, state) => Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: 900,
                  decoration: BoxDecoration(
                    image: DecorationImage(image:AssetImage('assets/hhhh.jpg'),fit:BoxFit.fill ),
                  ),

                   clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Login Now to communicate with your friends ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.grey,fontSize: 18),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaulttextformfeild(

                              controller: emailController,
                              background: Colors.white,
                              label: 'Email',
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Email is Wrong';
                                }
                                return null;
                              },
                              prefix: Icons.email_outlined),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaulttextformfeild(
                            onSubmit: (value){
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).loginUser(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            controller: passwordController,
                            label: 'Password',
                            background: Colors.white,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Password is Too Short';
                              }
                              return null;
                            },
                            obsecureText: obsecure,
                            suffixPressed: () {
                              setState(() {
                                obsecure = !obsecure;
                              });
                            },
                            prefix: Icons.lock,
                            suffix: obsecure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition:state is! SocialLoginLoudingState ,
                            builder: (context) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(image:AssetImage('assets/hhhhhhh.jpg'),fit:BoxFit.cover ),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(80.0),
                                      topRight:Radius.circular(80.0),
                                      topLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0)
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: defaultButton(
                                  onpressed: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).loginUser(
                                          email: emailController.text,
                                          password: passwordController.text);

                                      //navigateAndRemoveUntil(context, HomeScreen());

                                    }
                                  },
                                  text: 'LOGIN',color: Colors.white),
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don/t have an Accont ? ',
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              defaultTextButton(
                                  text: 'REGISTER',
                                  color: Colors.white,
                                  onpressed: () {
                                    navigateTo(context, RegisterScreen());
                                  })
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }
}
