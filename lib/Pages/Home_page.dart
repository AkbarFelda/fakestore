import 'package:fake_store_api/Controller/Produk_Controller.dart';
import 'package:fake_store_api/Controller/Produk_database.dart';
import 'package:fake_store_api/Controller/Whislist_Controller.dart';
import 'package:fake_store_api/Model/Favorite_Model.dart';
import 'package:fake_store_api/Pages/Whislist_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final WishlistController wishlistController = Get.put(WishlistController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fake Store"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            color: Colors.red,
            onPressed: () {
              Get.to(WishlistPage());
            },
          ),
        ],
      ),
      body: Obx(
        () => productController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: productController.productModels.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = productController.productModels[index];
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(product.image),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${product.price.toString()}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        DatabaseHelper().insertFavorite(
                                          FavoriteModel(
                                            id: product.id,
                                            title: product.title,
                                            price: product.price,
                                            description: product.description,
                                            category: product.category.toString(),
                                            image: product.image,
                                          ),
                                        );
                                        Get.snackbar(
                                          'Added to Favorites',
                                          'Product ${product.title} added to favorites!',
                                          snackPosition: SnackPosition.TOP,
                                          duration: Duration(seconds: 2),
                                        );
                                      },
                                      child: Obx(() {
                                        return Icon(
                                          Icons.favorite,
                                          color: wishlistController
                                                  .whislist
                                                  .contains(product.id)
                                              ? Colors.red
                                              : Colors.grey,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
