

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mm/models/shope_app/shope_app.dart';
import 'package:mm/modules/shope_app/register/cubit/states.dart';

import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_points.dart';

ShopeLoginModel? loginModel;

class ShopeRegisterCubit extends Cubit<ShopeRegisterStates> {
  ShopeRegisterCubit() : super(ShopeRegisterInitialState());

  static ShopeRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {
         String? name,
         String? email,
         String? password,
         String? phone,
      }
      ) {
    emit(ShopeRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      loginModel = ShopeLoginModel.fromJson(value.data);
      print(loginModel!.status);
      emit(ShopeRegisterSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopeRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopeRegisterChangePasswordVisibilityState());
  }
}
