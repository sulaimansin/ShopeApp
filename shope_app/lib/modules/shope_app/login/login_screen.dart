import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mm/layout/shope_app/shope_layout.dart';
import 'package:mm/modules/shope_app/login/cubit/cubit.dart';
import 'package:mm/modules/shope_app/login/cubit/cubit.dart';
import 'package:mm/modules/shope_app/login/cubit/cubit.dart';
import 'package:mm/modules/shope_app/login/cubit/cubit.dart';
import 'package:mm/modules/shope_app/login/cubit/cubit.dart';
import 'package:mm/modules/shope_app/login/cubit/states.dart';
import 'package:mm/shared/components/constants.dart';
import 'package:mm/shared/network/local/cache_helper.dart';

import '../../../shared/components/components.dart';

import '../register/shope_register_screen.dart';


class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKye = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopeLoginCubit(),
      child: BlocConsumer<ShopeLoginCubit, ShopeLoginStates>(
        listener: (context,state){
          if(state is ShopeLoginSuccessState) {
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
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKye,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Login now to brows our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'Email must not be empty';
                            }
                            return null;
                          },
                          label:'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          suffixIcon:ShopeLoginCubit.get(context).suffix,
                          obscureText: ShopeLoginCubit.get(context).isPassword,
                          suffixPress: (){
                          ShopeLoginCubit.get(context).changePasswordVisibility();
                          },
                          onSubmit: (value){
                            if(formKye.currentState!.validate()){
                              ShopeLoginCubit.get(context).userLogin(email: emailController.text, password:passwordController.text);
                            }
                          },
                          validate: (value){
                            if(value!.isEmpty){
                              return 'Password is too short';
                            }
                            return null;
                          },
                          label:'Password',
                          prefixIcon: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopeLoginLoadingState,
                          builder: (context)=>defaultButton(
                            function: (){
                              if(formKye.currentState!.validate()){
                                ShopeLoginCubit.get(context).userLogin(email: emailController.text, password:passwordController.text);
                              }
                            },
                            buttonText: 'LOGIN',
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(onPressed: (){
                              navigateTo(context, ShopeRegisterScreen());
                            },
                              child: Text('REGISTER'),
                            ),
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
