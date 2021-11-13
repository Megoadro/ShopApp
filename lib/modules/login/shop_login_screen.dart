

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/shop_register_screen.dart';
import 'package:shop_app/shared/cache_helper.dart';
import 'package:shop_app/shared/compenents.dart';
import 'package:shop_app/shared/constants.dart';

class ShopLoginScreen extends StatelessWidget {
   ShopLoginScreen({Key key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=> ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status){
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(key: 'token', value:state.loginModel.data.token ).then((value) {
                token = state.loginModel.data.token;
                navigateToAndFinish(context,  ShopLayout(),);
              });
              //Toast
              // showToast(
              //     text: state.loginModel.message,
              //     state: ToastStates.SUCCESS,
              // );

            } else
              {
                print(state.loginModel.message);
                // Toast
                showToast(
                    text: state.loginModel.message,
                    state: ToastStates.ERROR
                );
              }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key:formKey ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(' LOGIN',style: Theme.of(context).textTheme.headline5,),
                        Text(' Login now to browse our hot offers ',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey)),
                        const SizedBox(height: 30,),
                        defalutFormfeild(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            valdiate: (value){
                              if(value.isEmpty){
                                return ' Pleas enter your emailAddress ';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined),
                        const SizedBox(height: 15,),
                        defalutFormfeild(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          valdiate: (value){
                            if(value.isEmpty){
                              return ' password is too short ';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix:  ShopLoginCubit.get(context).suffix ,
                          suffixpressed: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                            // To login when enter email and pass directly
                          onSubmited: (value){
                            if(formKey.currentState.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                email : emailController.text,
                                password: passwordController.text ,
                              );
                            }
                          },
                          // to make pass invisible
                          ispassword: ShopLoginCubit.get(context).isPassword,
                        ),
                        const SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=> defaultButton(
                            function: (){
                              if(formKey.currentState.validate()){
                                ShopLoginCubit.get(context).userLogin(
                                  email : emailController.text,
                                  password: passwordController.text ,
                                );
                              }
                            },
                            text: 'login',
                          ),
                          fallback:(context) => const Center(child: CircularProgressIndicator()) ,

                        ),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an acount ?'),
                            defaultTextButton(
                                function: (){
                                  navigateTo(
                                    context,
                                     ShopRegisterScreen(),
                                  );
                                },
                                text: 'Register Now !'
                            )
                          ],
                        )


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }


      ),
    );
  }
}
