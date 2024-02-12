import 'package:fake_store_api/Controller/Whislist_Controller.dart';
import 'package:flutter/foundation.dart';

class FavoriteModel {
  bool isFav(WishlistController wishlistController, int id) {
    return wishlistController.whislist.contains(id);
  }

   static List<FavoriteModel> favorites = [];
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  FavoriteModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: map['description'],
      category: map['category'],
      image: map['image'],
    );
  }
  
  static void add(FavoriteModel favoriteProduct) {
    if (!favorites.contains(favoriteProduct)) {
      favorites.add(favoriteProduct);
      print("Product added to favorites");
    } else {
      print("Product is already in favorites");
    }
  }

  static void remove(FavoriteModel favoriteProduct) {
    if (favorites.contains(favoriteProduct)) {
      favorites.remove(favoriteProduct);
      print("Product removed from favorites");
    } else {
      print("Product is not in favorites");
    }
  }
}
