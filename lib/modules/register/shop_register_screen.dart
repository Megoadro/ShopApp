import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/cache_helper.dart';
import 'package:shop_app/shared/compenents.dart';
import 'package:shop_app/shared/constants.dart';

class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                navigateToAndFinish(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              print(state.loginModel.message);
              // Toast
              showToast(
                  text: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' Register',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(' Register now to browse our hot offers ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.grey)),
                        const SizedBox(
                          height: 30,
                        ),
                        defalutFormfeild(
                            controller: nameController,
                            type: TextInputType.name,
                            valdiate: (value) {
                              if (value.isEmpty) {
                                return ' Pleas enter your name ';
                              }
                            },
                            label: 'Name',
                            prefix: Icons.person),
                        const SizedBox(
                          height: 15,
                        ),
                        defalutFormfeild(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            valdiate: (value) {
                              if (value.isEmpty) {
                                return ' Pleas enter your emailAddress ';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined),
                        const SizedBox(
                          height: 15,
                        ),
                        defalutFormfeild(
                            controller: phoneController,
                            type: TextInputType.phone,
                            valdiate: (value) {
                              if (value.isEmpty) {
                                return ' Pleas enter your phone ';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone),
                        const SizedBox(
                          height: 15,
                        ),
                        defalutFormfeild(
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          valdiate: (value) {
                            if (value.isEmpty) {
                              return ' password is too short ';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixpressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          // To login when enter email and pass directly
                          onSubmited: (value) {
                            // if(formKey.currentState.validate()){
                            //   ShopRegisterCubit.get(context).userLogin(
                            //     email : emailController.text,
                            //     password: passController.text ,
                            //   );
                            // }
                          },
                          // to make pass invisible
                          ispassword: ShopRegisterCubit.get(context).isPassword,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
