import 'package:flutter/material.dart';
import 'package:kairomarket/AllOurProductsPage/UserProductsListPage/user_products_list_actions.dart';
import 'package:kairomarket/AllOurProductsPage/UserProductsListPage/user_products_list_actions.dart';
import 'package:kairomarket/AllOurProductsPage/models/user_product_model.dart';
import 'package:kairomarket/AllOurProductsPage/models/user_product_model.dart';
import 'package:kairomarket/utils/base_provider.dart';

class UserProductsListProvider extends BaseProvider {
  List<UserProducts> userproductList = [];
  List<UserProducts> userproductListToDsplay = [];
  // String searchParam = '';

  set setUserProductListToDisplay(List<UserProducts> userproduct) {
    userproductListToDsplay = userproduct;
    print(userproductListToDsplay);
    notifyListeners();
  }

  void initialize() async {
    var m = 'Loading your products list...';
    try {
      backToLoading(message: m);
      var userproductResponse = await UserProductsActions.getUserProductsList();
      print(userproductResponse.runtimeType);
      // print('product: ${productResponse['data']}');
      userproductList.clear();
      userproductList = userproductList;
      userproductResponse.forEach((pro) {
        userproductList.add(UserProducts.fromMap(pro));
      });
      userproductList.shuffle();
      userproductList = userproductList;
      setUserProductListToDisplay = userproductList.take(20).toList();

      // print('ProductList: $ProductList');
      backToLoaded();
    } catch (error) {
      print(error);
      backToFailed(message: '$error');
      throw error;
    }
    if (userproductResponse.statusCode == 401) {
      Navigator.pushReplacementNamed('/login');
    }
  }

  void searchUserProduct({String searchParam}) {
    backToInProgress(message: 'Searching your products...');
    if (searchParam.isEmpty) {
      userproductList.shuffle();
      setUserProductListToDisplay = userproductList.take(20).toList();
      backToLoaded();
    } else {
      // print(searchParam);

      setUserProductListToDisplay = userproductList
          .where((element) =>
              element.image.toLowerCase().contains(searchParam.toLowerCase()))
          .toList();
      // print(filtered);
      backToLoaded();
    }
  }

  UserProductsListProvider() {
    initialize();
  }
}
