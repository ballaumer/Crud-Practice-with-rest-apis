import 'package:crud_again/views/login.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>
{
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
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
              Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                    child: const Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(230.0, 50.0, 0.0, 0.0),
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
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                       TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String input) {
                          if (input.isEmpty) {
                            return 'Please enter Fullname';
                          }
                          if (input.length < 7) {
                            return 'Name should be more than 7 characters';
                          }
                          return null;
                        },

                        decoration: const InputDecoration(
                          labelText: 'NAME',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                       TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String input) {
                          if (input.isEmpty) {
                            return 'Please enter Username';
                          }
                          if (input.length <= 6) {
                            return 'Your username needs to be at least 6 characters';
                          }
                          // else if(input.length > 12){
                          //   return 'Your username needs to be at most 12 characters';
                          // }
                          // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(input)) {
                          //   return 'Please enter a valid username.';
                          // }
                          return null;
                        },

                        decoration: const InputDecoration(
                          labelText: 'USERNAME',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                       TextFormField(
                        validator: (String input) {
                          if (input.isEmpty) {
                            return 'Please enter Phone Number';
                          }
                          if (input.length < 10) {
                            return "Phone Number should be valid";
                          }
                          if (input.length > 10) {
                            return "Phone Number should be valid";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: "PHONE",
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      // circular?CircularProgressIndicator():
                       TextFormField(

                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: (input) => !input.contains('@') ? "Email Id should be valid" : null,
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                       TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: password,
                        validator: (String input) {
                          if (input.isEmpty) {
                            return 'Please enter password';
                          }
                          if (input.length < 5) {
                            return "Password should be more than 5 characters";
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          // prefixIcon: Icon(
                          //   Icons.lock,
                          //   color: Colors.black,
                          // ),
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
                          labelText: 'PASSWORD',
                          labelStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                        obscureText: hidePassword,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                       TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: confirmpassword,
                        validator: (String input) {
                          if (input.isEmpty) {
                            return 'Please re-enter password';
                          }
                          // print(password.text);
                          // print(confirmpassword.text);
                          if (password.text != confirmpassword.text) {
                            return "Password does not match";
                          }
                          return null;
                        },

                        decoration: InputDecoration(
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
                          labelText: 'CONFIRM PASSWORD',
                          labelStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                        obscureText: hidePassword,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),

                      // DropdownButton<String>(
                      //
                      //   isExpanded: true,
                      //   value: _chosenValue,
                      //   //elevation: 5,
                      //   style: TextStyle(
                      //       fontFamily: 'Montserrat',
                      //       color: Colors.black,
                      //       fontSize: 17),
                      //
                      //   items: <String>[
                      //     'Traveller',
                      //     'Driver',
                      //   ].map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      //   hint: Text(
                      //     "Stakeholder",
                      //     style: TextStyle(
                      //       fontFamily: 'Montserrat',
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      //   onChanged: (String value) {
                      //     setState(() {
                      //       _chosenValue = value;
                      //     });
                      //   },
                      // ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                          ),
                          color: Colors.teal,
                          onPressed: () async{
                            if (validateAndSave()) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 19),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  'Signup',
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
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                            side: const BorderSide(color: Colors.teal),
                          ),
                          onPressed: () {},
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
                    'Already have an account?',
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
                          return  MyHomePage();
                        }),
                      );
                    },
                    child: const Text(
                      'Login',
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

