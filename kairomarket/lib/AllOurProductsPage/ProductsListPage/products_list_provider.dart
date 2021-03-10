import 'package:kairomarket/AllOurProductsPage/ProductsListPage/products_list_actions.dart';
import 'package:kairomarket/AllOurProductsPage/models/product.model.dart';
import 'package:kairomarket/AllOurProductsPage/models/product.model.dart';
import 'package:kairomarket/utils/base_provider.dart';

class ProductsListProvider extends BaseProvider {
  List<Products> productList = [];
  List<Products> productListToDsplay = [];
  // String searchParam = '';

  set setProductListToDisplay(List<Products> products) {
    productListToDsplay = products;
    print(productListToDsplay);
    notifyListeners();
  }

  void initialize() async {
    var m = 'Loading products list...';
    try {
      backToLoading(message: m);
      var productResponse = await ProductsListActions.getProductsList();
      print(productResponse.runtimeType);
      // print('product: ${productResponse['data']}');
      productList.clear();
      productList = productList;
      productResponse.forEach((pro) {
        productList.add(Products.fromMap(pro));
      });
      productList.shuffle();
      productList = productList;
      setProductListToDisplay = productList.take(20).toList();

      // print('ProductList: $ProductList');
      backToLoaded();
    } catch (error) {
      print(error);
      backToFailed(message: '$error');
      throw error;
    }
  }

  void searchProduct({String searchParam}) {
    backToInProgress(message: 'Searching products...');
    if (searchParam.isEmpty) {
      productList.shuffle();
      setProductListToDisplay = productList.take(20).toList();
      backToLoaded();
    } else {
      // print(searchParam);

      setProductListToDisplay = productList
          .where((element) =>
              element.image.toLowerCase().contains(searchParam.toLowerCase()))
          .toList();
      // print(filtered);
      backToLoaded();
    }
  }

  ProductsListProvider() {
    initialize();
  }
}
