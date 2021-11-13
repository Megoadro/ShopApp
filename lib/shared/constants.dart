

import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/cache_helper.dart';
import 'package:shop_app/shared/compenents.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      navigateToAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text){

  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));

}
String token ='';