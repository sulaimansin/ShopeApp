
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mm/modules/shope_app/register/cubit/cubit.dart';
import 'package:mm/modules/shope_app/register/cubit/states.dart';
import 'package:mm/shared/network/local/cache_helper.dart';

import '../../../layout/shope_app/shope_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';

class ShopeRegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  var formKye = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopeRegisterCubit(),
      child: BlocConsumer<ShopeRegisterCubit, ShopeRegisterStates>(
        listener: (context, state) {
          if(state is ShopeRegisterSuccessState) {
            if ((state.loginModel.status) == true) {
              CacheHelper.saveData(kye: 'token', value: state.loginModel.data!.token)?.then((value) {
                token = state.loginModel.data!.token!;
                navigateAndFinish(context, ShopeLayout());
              });

            }else{
              String? message =state.loginModel.message;
              if(message != null){
                showToast(
                  message: message,
                  state: ToastState.ERROR,
                );
              }
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKye,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'REGISTER now to brows our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            controller: nameController,
                            textInputType: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            label: 'User name',
                            prefixIcon: Icons.person,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Email must not be empty';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            prefixIcon: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            suffixIcon: ShopeRegisterCubit.get(context).suffix,
                            obscureText:
                                ShopeRegisterCubit.get(context).isPassword,
                            suffixPress: () {
                              ShopeRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {},
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Password is too short';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefixIcon: Icons.lock_outline,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: phoneController,
                            textInputType: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            label: 'Phone',
                            prefixIcon: Icons.phone,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopeRegisterLoadingState,
                            builder: (context) => defaultButton(
                              function: () {
                                if (formKye.currentState!.validate()) {
                                  ShopeRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              buttonText: 'REGISTER',
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
