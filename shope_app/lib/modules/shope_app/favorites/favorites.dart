import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mm/models/shope_app/favorites_model.dart';

import '../../../layout/shope_app/cubit/cubit.dart';
import '../../../layout/shope_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopeCubit, ShopeStates>(
      listener: (context,state){},
      builder: (context,state){
        var favoriteModel = ShopeCubit.get(context).favoritesModelGenerate;
        return ConditionalBuilder(
          condition: state is! ShopeLoadingGetFavoritesState,
          builder:(context) => ListView.separated(

            itemBuilder: (context, index)=>buildListProducts(favoriteModel!.data!.data![index].product, context),
            separatorBuilder: (context, index)=>myDivider(),
            itemCount: favoriteModel!.data!.data!.length,
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }


}

