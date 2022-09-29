import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mm/layout/shope_app/cubit/cubit.dart';
import 'package:mm/layout/shope_app/cubit/states.dart';
import 'package:mm/models/shope_app/categories_model.dart';
import 'package:mm/shared/components/components.dart';
import 'package:mm/shared/style/colors.dart';
import '../../../models/shope_app/home_model.dart';

class ProductsScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopeCubit, ShopeStates>(
      listener: (context, state) {
        if (state is ShopeSuccessChangeFavoriteState) {
          if (!state.model.status!) {
            showToast(message: state.model.message!, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var homeModel = ShopeCubit.get(context).homeModel;
        var categoriesModel = ShopeCubit.get(context).categoriesModel;



        return ConditionalBuilder(
          condition: homeModel != null && categoriesModel != null,
          builder: (context) =>
              productsBuilder(homeModel!, categoriesModel!, context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel homeModel, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel.data?.banners
                ?.map(
                  (e) =>
                  Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            )
                .toList(),
            options: CarouselOptions(
              height: 200,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              //onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoriesModel.data!.data[index]),
                    separatorBuilder: (context, index) =>
                        SizedBox(
                          width: 20.0,
                        ),
                    itemCount: categoriesModel.data!.data.length,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    )),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
             childAspectRatio: 0.57,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                homeModel.data!.products!.length,
                    (index) =>
                    buildGridProduct(
                        homeModel.data!.products![index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildCategoryItem(DataModel model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
            color: Colors.black.withOpacity(.8),
            width: 100,
            child: Text(
              model.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            )),
      ],
    );

Widget buildGridProduct(Products model, context) {
  return Container(
    color: Colors.white,
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage(model.image),
            width: double.infinity,
            height: 200,
          ),
          if(model.discount != 0)
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            color: Colors.red,
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Row(
              children: [
                Text(
                  '${model.price.round()}',
                  style: TextStyle(fontSize: 12, color: defaulteColor),
                ),
                SizedBox(
                  width: 5.0,
                ),
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                Spacer(),
                IconButton(
                  icon: CircleAvatar(
                    backgroundColor: ShopeCubit.get(context).favorites![model.id]!
                        ? defaulteColor
                        : Colors.grey,
                    child: Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: Colors.white,
                    ),
                    radius: 15,
                  ),
                  onPressed: () {
                    ShopeCubit.get(context).changeFavorites(model.id!);

                  },
                )
              ],
            ),
          ],
        ),
      ),

    ]),
  );


}


