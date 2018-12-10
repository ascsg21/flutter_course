import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import './connected_products.dart';

mixin ProductsModel on ConnectedProducts {
  bool _showFavorite = false;

  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if (_showFavorite) {
      return products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(products);
  }

  int get selectedProductIndex {
    return selProductIndex;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return products[selectedProductIndex];
  }

  bool get displayFavoriteOnly {
    return _showFavorite;
  }

  void updateProduct(String title, String description, String image, double price) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    products[selectedProductIndex] = updatedProduct;
    selProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(selectedProductIndex);
    selProductIndex = null;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updateProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavorite: newFavoriteStatus);
    products[selectedProductIndex] = updateProduct;
    notifyListeners();
    selProductIndex = null;
  }

  void selectProduct(int index) {
    selProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorite = !_showFavorite;
    notifyListeners();
  }
}
