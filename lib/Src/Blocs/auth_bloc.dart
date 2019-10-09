import 'dart:async';
import 'package:taxi_app/Src/FireBase/firebase_auth.dart';

class AuthBloc {
  FireAuth _fireAuth = FireAuth();

  StreamController _nameController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passwordController = new StreamController();

  Stream get nameStream => _nameController.stream;

  Stream get phoneStream => _phoneController.stream;

  Stream get emailStream => _emailController.stream;

  Stream get passStream => _passwordController.stream;

  bool isValid(String name, String phone, String email, String password) {
    if (name == null || name.isEmpty) {
      _nameController.sink.addError("Please Enter Your Name !");
      return false;
    }
    _nameController.sink.add("");

    if (phone == null || phone.isEmpty) {
      _phoneController.sink.addError("Please Enter Your Phone !");
      return false;
    }
    _phoneController.sink.add("");

    if (email == null || email.isEmpty) {
      _emailController.sink.addError("Please Enter Your Email !");
      return false;
    }
    _emailController.sink.add("");

    if (password == null || password.isEmpty) {
      _passwordController.sink.addError("Please Enter Your Password !");
      return false;
    }
    _passwordController.sink.add("");

    return true;
  }

  void signUp(String name, String phone, String email, String pass,
      Function onSuccess, Function(String) onRegisterErr) {
    _fireAuth.signUp(email, pass, name, phone, onSuccess, onRegisterErr);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInErr) {
    _fireAuth.signIn(email, pass, onSuccess, onSignInErr);
  }

  void dispose() {
    _nameController.close();
    _phoneController.close();
    _emailController.close();
    _passwordController.close();
  }
}
