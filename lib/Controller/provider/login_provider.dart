import 'package:flutter/material.dart';
import 'package:noviindus_tech/Controller/service/login_servies.dart';
import 'package:noviindus_tech/Model/login_model.dart';
import 'package:noviindus_tech/View/tools/screts/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> login(BuildContext context,
      {required String username, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    LoginRepository loginRepository = LoginRepository();
    Login? loginResponse =
        await loginRepository.login(username: username, password: password);

    _isLoading = false;
    if (loginResponse != null && loginResponse.status == true) {
      if (loginResponse.token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', loginResponse.token!);
        Secrets.token = loginResponse.token!;
        debugPrint('Token stored successfully');
      }
      Navigator.pushReplacementNamed(context, 'homePage');
    } else {
      _errorMessage = loginResponse?.message ?? 'Login failed';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!)),
      );
    }
    notifyListeners();
  }
}
