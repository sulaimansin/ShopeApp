// @dart=2.9



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mm/layout/shope_app/cubit/cubit.dart';
import 'package:mm/shared/cubit/cubit.dart';
import 'package:mm/shared/cubit/states.dart';
import 'package:mm/shared/network/local/cache_helper.dart';
import 'package:mm/shared/style/themes.dart';

import 'layout/shope_app/shope_layout.dart';
import 'modules/shope_app/login/login_screen.dart';
import 'modules/shope_app/on_boarding/on_boarding_screen.dart';
import 'shared/components/constants.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'OnBoarding');
   token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(FApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class FApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  FApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => NewsCubit()
        //     ..getBusiness()
        //     ..getSports()
        //     ..getScience(),
        // ),
        BlocProvider(
          create: (context) => AppCubit()..changeMode(fromShare: isDark),
        ),
        BlocProvider(
          create: (context) => ShopeCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
           // darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
