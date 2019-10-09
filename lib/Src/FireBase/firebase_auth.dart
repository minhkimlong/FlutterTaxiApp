import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FireAuth {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterError) {
    _fireBaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      _createUser(user.user.uid, name, phone, onSuccess, onRegisterError);
      print(user);
    }).catchError((err) {
      _onSignUpError(err.code, onRegisterError);
    });
  } // Sign Up Function

  _createUser(String userId, String name, String phone, Function onSuccess,
      Function(String) onRegister) {
    var user = {"name": name, "phone": phone};

    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userId).set(user).then((user) {
      onSuccess();
    }).catchError((err) {
      onRegister("SignUp fail, please try again");
    });
  } // Create User Function

  _onSignUpError(String code, Function(String) onRegisterError) {
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        {
          onRegisterError("Invalid email");
          break;
        }
      case "ERROR_EMAIL_ALREADY_IN_USE":
        {
          onRegisterError("Email has existed");
          break;
        }
      case "ERROR_WEAK_PASSWORD":
        {
          onRegisterError("The password is not strong enough");
          break;
        }
      default:
        onRegisterError("SignUp fail, please try again");
        break;
    }
  } // Handle SignUp Error Function

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInErr) {
    _fireBaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      print(user);
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onSignInErr("Sign in fail, Please try again !");
    });
  } // Sign In Function
}
