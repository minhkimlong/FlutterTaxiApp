import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:taxi_app/Src/Resource/home_page.dart';
import 'package:taxi_app/Src/Resource/register_page.dart';
import 'package:taxi_app/Src/app_page.dart';
import 'package:taxi_app/Src/Resource/Dialog/loading_dialog.dart';
import 'package:taxi_app/Src/Resource/Dialog/msg_dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  void _clickToSignInUser() {
    String email = _emailController.text;
    String pass = _passController.text;
    var authBloc = AppPage.of(context).authBloc;
    LoadingDialog.showLoadingDialog(context, "Loading...");
    authBloc.signIn(email, pass, () {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign In", msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
      constraints: BoxConstraints.expand(),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Image.asset("assets/img/ic_car_green.png"),
            Container(
              padding: EdgeInsets.only(
                top: 20,
                bottom: 5,
              ),
              child: Text(
                " Welcome To My Taxi ! ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: Text(
                "Login to continue using my taxi",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 100,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset("assets/img/ic_mail.png"),
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 8),
                    child: TextFormField(
                      controller: _passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset("assets/img/ic_lock.png"),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 15),
                    width: double.infinity,
                    height: 83,
                    child: RaisedButton(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      onPressed: _clickToSignInUser,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        text: "New User ? ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                            text: "Sign up for a new account",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
