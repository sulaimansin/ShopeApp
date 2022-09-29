import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mm/models/shope_app/shope_app.dart';
import 'package:mm/modules/shope_app/login/cubit/states.dart';
import 'package:mm/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/remote/end_points.dart';

ShopeLoginModel? loginModel;

class ShopeLoginCubit extends Cubit<ShopeLoginStates> {
  ShopeLoginCubit() : super(ShopeLoginInitialState());

  static ShopeLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(ShopeLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopeLoginModel.fromJson(value.data);
      print(loginModel!.status);
      emit(ShopeLoginSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopeLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
