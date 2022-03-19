import 'package:crud_again/controllers/google_sign_in.dart';
import 'package:crud_again/views/profile_page.dart';
import 'package:crud_again/views/sign_up.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    // SvgPicture.asset('images/waver.svg'),
                    // Image(image:AssetImage('images/wave-haikei.png')),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: const Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                      child: const Text(
                        'There',
                        style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(200.0, 175.0, 0.0, 0.0),
                      child: const Text(
                        '.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String input) {
                          if (input.isEmpty) {
                            return 'Please enter Email';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(input)) {
                            return "Email Id should be valid";
                          }
                          return null;
                        },
                        cursorColor: Colors.teal,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.2))),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String input) {
                          if (input.isEmpty) {
                            return 'Please enter password';
                          }
                          if (input.length < 5) {
                            return "Password should be more than 5 characters";
                          }
                          return null;
                        },
                        cursorColor: Colors.teal,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.2))),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.teal,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            color: Colors.black.withOpacity(0.4),
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        alignment: const Alignment(1.0, 0.0),
                        padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                          },
                          child: const Text(
                            'Forget Password',
                            style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                          ),
                          color: Colors.teal,
                          onPressed: () {
                            if (validateAndSave()) {
                              Navigator.pushReplacementNamed(context, '/mainpage');
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 19),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                            side: const BorderSide(color: Colors.teal),
                          ),
                          onPressed: () {
                            signInWithGoogle().then((result) {
                              if (result != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return FirstScreen();
                                    },
                                  ),
                                );
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Image(
                                  height: 30,
                                  width: 20,
                                  image: AssetImage(
                                    'assets/images/google.png',
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text('Connect with google')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'New to Bitrix ?',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return SignUp();
                        }),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                        fontFamily: 'Montserrat',
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
