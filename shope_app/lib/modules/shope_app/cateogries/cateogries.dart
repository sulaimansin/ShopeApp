import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mm/layout/shope_app/cubit/cubit.dart';
import 'package:mm/layout/shope_app/cubit/states.dart';
import 'package:mm/models/shope_app/categories_model.dart';
import 'package:mm/shared/components/components.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopeCubit, ShopeStates>(
      listener: (context,state){},
      builder: (context,state){
        var categoriesModel = ShopeCubit.get(context).categoriesModel;
        return ListView.separated(
          itemBuilder: (context, index)=>BuildCatItem(categoriesModel!.data!.data[index]),
          separatorBuilder: (context, index)=>myDivider(),
          itemCount: categoriesModel!.data!.data.length,
        );
      },

    );
  }

  Widget BuildCatItem(DataModel model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(
             model.image,),
          width: 120.0,
          height: 120.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
         model.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios,),
      ],
    ),
  );
}
