

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mm/layout/shope_app/cubit/cubit.dart';
import 'package:mm/shared/components/constants.dart';

import '../../../layout/shope_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopeCubit,ShopeStates>(
      listener: (context, state){
        if(state is ShopeSuccessUserDataState){

        }
      },
      builder: (context, state){

        var model = ShopeCubit.get(context).userModel;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;


        return  ConditionalBuilder(
          condition: ShopeCubit.get(context).userModel != null,
          builder: (context) =>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopeLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  const SizedBox(height: 20,),
                  defaultFormField(
                    controller: nameController,
                    textInputType: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefixIcon: Icons.person,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: emailController,
                    textInputType: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email',
                    prefixIcon: Icons.email,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    textInputType: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefixIcon: Icons.phone,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  defaultButton(
                      function: (){
                        if(formKey.currentState!.validate()){
                          ShopeCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }

                      },
                      buttonText: 'Update'
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  defaultButton(
                      function: (){
                        signOut(context);
                      },
                      buttonText: 'Logout'
                  ),
                ],
              ),
            ),
          ),
          fallback:(context) => Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
