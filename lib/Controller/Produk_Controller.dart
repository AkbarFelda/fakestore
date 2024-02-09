import 'dart:convert';

import 'package:fake_store_api/Model/Produk_Model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isFavorite = false.obs;
  RxList allProduct = [].obs;
  var productModels = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future fetchProducts() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        isLoading(false);
        final content = json.decode(response.body);
        for (var item in content) {
          productModels.add(ProductModel.fromJson(item));
        }
        
      } else {
        print('Failed to load products!');
      }
    } catch (e) {
      print(e);
    }
  }

}
