import 'package:fake_store_api/Controller/Whislist_Controller.dart';
import 'package:fake_store_api/Model/Favorite_Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fake_store_api/Controller/Produk_Controller.dart';


class WishlistPage extends StatelessWidget {
  final productController = Get.find<ProductController>();
  final wishlistController = Get.find<WishlistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
      ),
      body: Obx(
        () => wishlistController.whislist.isEmpty
            ? Center(
                child: Text("Wishlist is empty."),
              )
            : ListView.builder(
                itemCount: wishlistController.whislist.length,
                itemBuilder: (BuildContext context, int index) {
                  final productId = wishlistController.whislist[index];
                  final product = productController.productModels
                      .firstWhere((p) => p.id == productId);
                  return Card(
                    margin: EdgeInsets.all(15),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(product.image),
                            ),
                          ),
                        ),
                        title: Text(
                          product.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${product.category}  \$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            wishlistController.deleteWhislist(FavoriteModel(
                              id: product.id,
                              title: product.title,
                              price: product.price,
                              description: product.description,
                              category: product.category.toString(),
                              image: product.image,
                            ));
                            Get.snackbar(
                              'Removed from Favorites',
                              'Product ${product.title} removed from favorites!',
                              snackPosition: SnackPosition.TOP,
                              duration: Duration(seconds: 2),
                            );
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
