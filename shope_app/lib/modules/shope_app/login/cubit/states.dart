import 'package:mm/models/shope_app/shope_app.dart';

abstract class ShopeLoginStates{}

class ShopeLoginInitialState extends ShopeLoginStates{}

class ShopeLoginLoadingState extends ShopeLoginStates{}

class ShopeLoginSuccessState extends ShopeLoginStates{
  final ShopeLoginModel loginModel;

  ShopeLoginSuccessState(this.loginModel);
}

class ShopeLoginErrorState extends ShopeLoginStates{
  final String error;

  ShopeLoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends ShopeLoginStates{}