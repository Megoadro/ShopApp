import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/compenents.dart';
import 'package:shop_app/shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if (state is ShopLoadingUpdateUserState)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'Your Information',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defalutFormfeild(
                          controller: nameController,
                          type: TextInputType.name,
                          valdiate: (String value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defalutFormfeild(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          valdiate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          label: 'Email',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defalutFormfeild(
                          controller: phoneController,
                          type: TextInputType.phone,
                          valdiate: (String value) {
                            if (value.isEmpty) {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultButton(
                          function: () {
                            if (formKey.currentState.validate()) {
                              ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'Update',
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultButton(
                          function: () {
                            signOut(context);
                          },
                          text: 'Logout',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => const CircularProgressIndicator(),
        );
      },
    );
  }
}
