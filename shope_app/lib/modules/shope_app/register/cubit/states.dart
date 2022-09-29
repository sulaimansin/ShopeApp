import 'package:mm/models/shope_app/shope_app.dart';

abstract class ShopeRegisterStates{}

class ShopeRegisterInitialState extends ShopeRegisterStates{}

class ShopeRegisterLoadingState extends ShopeRegisterStates{}

class ShopeRegisterSuccessState extends ShopeRegisterStates{
  final ShopeLoginModel loginModel;

  ShopeRegisterSuccessState(this.loginModel);
}

class ShopeRegisterErrorState extends ShopeRegisterStates{
  final String error;

  ShopeRegisterErrorState(this.error);
}

class ShopeRegisterChangePasswordVisibilityState extends ShopeRegisterStates{}