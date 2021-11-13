import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/cache_helper.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/dio_helper.dart';
import 'package:shop_app/shared/thems.dart';



void main () async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  //bool isDark>.....

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
 // String token = CacheHelper.getData(key: 'token');
  if (onBoarding != null){
    if(token!= null ) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  }else
    {
    widget = OnBoardingScreen();
  }

  //print(onBoarding);
  runApp(MyApp (startWidget :widget ),);
  



}
class MyApp extends StatelessWidget {
  //final bool isDark;
  // final bool onBoarding;
  final Widget startWidget;
   MyApp({this.startWidget}) ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
      child: MaterialApp(
        // انت خلاص عديت ع onBoarding  يعني true  خلاص انقل علي login  غير كدا يعني onBoarding  ب false  خلاص يبق ترجع لل onBoarding
        //home:  onBoarding ?   ShopLoginScreen() : OnBoardingScreen(),
        home:  startWidget,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: lightTheme,
      ),
    );
  }
}

