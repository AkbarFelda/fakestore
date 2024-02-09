import 'dart:ffi';

import 'package:fake_store_api/Controller/Produk_database.dart';
import 'package:fake_store_api/Model/Favorite_Model.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  RxList<FavoriteModel> whislist = <FavoriteModel>[].obs;

  @override
  void onInit() {
    fetchFavorites();
    super.onInit();
  }

  Future<void> fetchFavorites() async {
    var db = DatabaseHelper();
    var whislistItem = await db.getFavorites();
    whislist.assignAll(whislistItem);
  }

  Future<void> deleteWhislist(FavoriteModel favoriteModel) async {
    var db = DatabaseHelper();
    await db.deleteFavorite(favoriteModel);
    whislist.remove(favoriteModel);
  }

}
