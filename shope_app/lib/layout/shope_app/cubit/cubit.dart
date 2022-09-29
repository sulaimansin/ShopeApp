import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mm/layout/shope_app/cubit/states.dart';
import 'package:mm/models/shope_app/categories_model.dart';
import 'package:mm/models/shope_app/change_favorites_model.dart';
import 'package:mm/models/shope_app/favorites_model.dart';
import 'package:mm/models/shope_app/home_model.dart';
import 'package:mm/modules/shope_app/cateogries/cateogries.dart';
import 'package:mm/modules/shope_app/favorites/favorites.dart';
import 'package:mm/modules/shope_app/products/products.dart';
import 'package:mm/modules/shope_app/settings/settings.dart';
import 'package:mm/shared/components/constants.dart';
import 'package:mm/shared/network/remote/dio_helper.dart';

import '../../../models/shope_app/shope_app.dart';
import '../../../shared/network/remote/end_points.dart';

class ShopeCubit extends Cubit<ShopeStates> {
  ShopeCubit() : super(ShopeInitialState());

  static ShopeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomWidgets = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(index) {
    currentIndex = index;
    emit(ShopeChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int?, bool?>? favorites = {};

  void getHomeData() {
    emit(ShopeLoadingHomeDataState());

    DioHelper.getData(url: HOME, authorization: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      printFullText(homeModel?.data?.banners![0].image);


      homeModel!.data!.products!.forEach((element) {
        favorites?.addAll({
          element.id: element.inFavorites,
        });
      });

      emit(ShopeSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());

      emit(ShopeErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(url: GET_GATEOGIRES, authorization: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopeSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());

      emit(ShopeErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites![productId] = !favorites![productId]!;
    emit(ShopeChangeFavoriteState());


    DioHelper.postData(
      url: FAVORIES,
      data: {
       'product_id':productId
      },
      authorization: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status!){ // اذا في مشكلة في اضافة المنتج رح يرجع الحالة الى قيتها الاصلية
        favorites![productId] = !favorites![productId]!;
      }else{
        getFavorites();
      }
      emit(ShopeSuccessChangeFavoriteState(changeFavoritesModel!));
    }
    ).catchError((error) {
      favorites![productId] = !favorites![productId]!;
      emit(ShopeErrorChangeFavoriteState());
    });
  }



  FavoritesModelGanerate? favoritesModelGenerate;

  void getFavorites() {
    emit(ShopeLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORIES, authorization: token).then((value) {
      favoritesModelGenerate = FavoritesModelGanerate.fromJson(value.data);


      emit(ShopeSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());

      emit(ShopeErrorGetFavoritesState());
    });
  }



ShopeLoginModel? userModel;
  void getUserData() {
    emit(ShopeLoadingUserDataState());
    DioHelper.getData(url: PROFILE, authorization: token).then((value) {
      userModel = ShopeLoginModel.fromJson(value.data);


      emit(ShopeSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());

      emit(ShopeErrorUserDataState());
    });
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopeLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      authorization: token,
      data:{
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      userModel = ShopeLoginModel.fromJson(value.data);


      emit(ShopeSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());

      emit(ShopeErrorUpdateUserState());
    });
  }
}
