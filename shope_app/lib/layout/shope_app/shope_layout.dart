import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mm/layout/shope_app/cubit/cubit.dart';
import 'package:mm/layout/shope_app/cubit/states.dart';
import 'package:mm/modules/shope_app/login/login_screen.dart';
import 'package:mm/modules/shope_app/search/search.dart';
import 'package:mm/shared/components/components.dart';
import 'package:mm/shared/network/local/cache_helper.dart';

class ShopeLayout extends StatelessWidget {
  const ShopeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopeCubit,ShopeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/images/mac-uni.png',
              fit: BoxFit.cover,
              height: 150,
            ),
            centerTitle: true,
            titleSpacing: 90,
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  navigateTo(context, SearchScreen());
                },
              )
            ],
          ),
          body: cubit.bottomWidgets[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Cateogries'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),

        );
      },
    );
  }
}
