import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:taxi_app/Src/Resource/login_page.dart';
import 'package:taxi_app/Src/Blocs/auth_bloc.dart';
import 'package:taxi_app/Src/Resource/Dialog/loading_dialog.dart';
import 'package:taxi_app/Src/Resource/Dialog/msg_dialog.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc authBloc = new AuthBloc();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void dispose() {
    super.dispose();
    authBloc.dispose();
  }

  void _clickToRegisterForNewUser() {
    var isValid = authBloc.isValid(
      _nameController.text,
      _phoneController.text,
      _emailController.text,
      _passwordController.text,
    );

    if (isValid) {
      //Create User
      // Loading Dialog
      LoadingDialog.showLoadingDialog(context, "Loading...");
      authBloc.signUp(_nameController.text, _phoneController.text,
          _emailController.text, _passwordController.text, () {
        // If create success turn off Loading Dialog
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
          (msg) => {
                LoadingDialog.hideLoadingDialog(context),
                MsgDialog.showMsgDialog(context, "Sign In", msg)
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset("assets/img/ic_car_red.png"),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 5,
                ),
                child: Text(
                  " Welcome To Register ! ",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Register my taxi in single steps",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: StreamBuilder(
                        stream: authBloc.nameStream,
                        builder: (context, snapshot) => TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2),
                            ),
                            prefixIcon: Container(
                              width: 50,
                              child: Image.asset("assets/img/ic_user.png"),
                            ),
                            labelText: "Name",
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            errorStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 20),
                        child: StreamBuilder(
                          stream: authBloc.phoneStream,
                          builder: (context, snapshot) => TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Container(
                                width: 50,
                                child: Image.asset("assets/img/ic_phone.png"),
                              ),
                              labelText: "Phone",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              errorStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
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
                        )),
                    Container(
                        padding: EdgeInsets.only(top: 20),
                        child: StreamBuilder(
                          stream: authBloc.emailStream,
                          builder: (context, snapshot) => TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Container(
                                width: 50,
                                child: Image.asset("assets/img/ic_mail.png"),
                              ),
                              labelText: "Email",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              errorStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
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
                        )),
                    Container(
                        padding: EdgeInsets.only(top: 20),
                        child: StreamBuilder(
                          stream: authBloc.passStream,
                          builder: (context, snapshot) => TextFormField(
                            controller: _passwordController,
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
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              errorStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
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
                        )),
                    Container(
                      width: double.infinity,
                      height: 83,
                      padding: EdgeInsets.only(top: 20, bottom: 15),
                      child: RaisedButton(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: _clickToRegisterForNewUser,
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      child: RichText(
                        text: TextSpan(
                          text: "Already a user ? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                              text: "Login",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                              ),
                            )
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
      ),
    );
  }
}
