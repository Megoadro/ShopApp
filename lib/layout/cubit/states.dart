import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_models.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

// States For BNB
class ShopChangeBottomNaviState extends ShopStates {}

// States For HomeData
class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}


//To display Categories at  Home
class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}


//To listen Change Favorite
class ShopChangeFavoritesState extends ShopStates {}

// To Toggle between To States Favorites
class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model ;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates {}


// To Get Favorite In FavoriteScreen
class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}


//For Get User Data To Profile Screen
class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates {}

//To update profile data
class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {}

class ShopErrorUpdateUserState extends ShopStates {}

