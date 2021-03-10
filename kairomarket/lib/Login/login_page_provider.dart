import 'package:flutter/material.dart';
import 'package:kairomarket/AllOurProductsPage/ProductsListPage/products_list_page.dart';
import 'package:kairomarket/Login/login_page_actions.dart';
import 'package:kairomarket/utils/base_provider.dart';
import 'package:flutter/cupertino.dart';
import '../homepage.dart';
import '../navigation.dart';
import 'package:kairomarket/navigation.dart';

class LoginPageProvider extends BaseProvider {
  String email = '';
  String password = '';
  bool passwordIsVisible = false;

  set setPasswordIsVisible(bool passVisibe) {
    passwordIsVisible = passVisibe;
    notifyListeners();
  }

  // Initialize Default Variables
  void initialize() async {
    backToLoaded();
  }

  void verifyInput(BuildContext context) {
    print('Was clicked');
    if (email.isEmpty && password.isEmpty) {
      backToInfo(message: 'All fields are required');
    } else if (email.isNotEmpty && password.isEmpty) {
      backToInfo(message: 'Password field is required');
    } else if (email.isEmpty && password.isNotEmpty) {
      backToInfo(message: 'Email field is required');
    } else {
      _login(context);
    }
  }

  void _login(BuildContext context) async {
    try {
      backToInProgress(message: 'Login in progress...');
      var loginData = {'email': email, 'password': password};
      var loginResponse = await LoginPageAction.login(loginData: loginData);
      print('LoginResponse: $loginResponse');
      if (loginResponse['status'] == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Navigation()));
      } else {
        backToFailed(message: loginResponse['Incorrect Username or Passsword']);
      }
    } catch (error) {
      backToFailed(message: '$error');
    }
  }

  LoginPageProvider() {
    initialize();
  }
}
