
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mm/models/shope_app/search_model.dart';
import 'package:mm/modules/shope_app/search/cuibt/states.dart';
import 'package:mm/shared/components/constants.dart';
import 'package:mm/shared/network/remote/end_points.dart';

import '../../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{

   SearchCubit(): super(SearchInitialState());

    static SearchCubit get(context) =>BlocProvider.of(context);
  
  SearchModel? model;
  
  void search(String text){
    emit(SearchLoadingState());

    DioHelper.postData(url:SEARCH, authorization:token , data: {
      "text":text,
    }
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}