import 'package:mm/models/shope_app/change_favorites_model.dart';
import 'package:mm/models/shope_app/shope_app.dart';

abstract class ShopeStates{}

class ShopeInitialState extends ShopeStates {}

class ShopeChangeBottomNavState extends ShopeStates{}

class ShopeLoadingHomeDataState extends ShopeStates{}

class ShopeSuccessHomeDataState extends ShopeStates{}

class ShopeErrorHomeDataState extends ShopeStates{}

class ShopeSuccessCategoriesState extends ShopeStates{}

class ShopeErrorCategoriesState extends ShopeStates{}

class ShopeChangeFavoriteState extends ShopeStates{}

class ShopeSuccessChangeFavoriteState extends ShopeStates{
  final ChangeFavoritesModel model;

  ShopeSuccessChangeFavoriteState(this.model);
}
class ShopeErrorChangeFavoriteState extends ShopeStates{}

class ShopeLoadingGetFavoritesState extends ShopeStates{}

class ShopeSuccessGetFavoritesState extends ShopeStates{}

class ShopeErrorGetFavoritesState extends ShopeStates{}

class ShopeLoadingUserDataState extends ShopeStates{}

class ShopeSuccessUserDataState extends ShopeStates{
  final ShopeLoginModel loginModel;

  ShopeSuccessUserDataState(this.loginModel);
}

class ShopeErrorUserDataState extends ShopeStates{}

class ShopeLoadingUpdateUserState extends ShopeStates{}

class ShopeSuccessUpdateUserState extends ShopeStates{
  final ShopeLoginModel loginModel;

  ShopeSuccessUpdateUserState(this.loginModel);
}

class ShopeErrorUpdateUserState extends ShopeStates{}