import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:note_caster/main.dart';
import 'dart:async';
import 'dart:convert';

import 'UserClass.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
class User{
  String username,  firstname, lastname, email, password;
  User({this.username, this.firstname, this.lastname, this.email, this.password});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      firstname: json['fname'],
      lastname: json['lname'],
      email: json['email'],
      password: json['password']
    );
  }
}
class _SignUpState extends State<SignUp> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _repasswordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _validate = false;
  String nameeeee='hello';

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'invalid';
    else
      return null;
  }

  Future<User> createUser(String username, String firstname, String lastname, String email, String password) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "fName": firstname,
        "lName": lastname,
        "username": username,
        "email": email,
        "password": password
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else if(response.statusCode == 422) {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Validation error.');
    }
    //return User.fromJson(jsonDecode(response.body));
  }

    Future<void> _performLogin() async {
      String username = _usernameController.text;
      String password = _passwordController.text;
      String firstName = _firstnameController.text;
      String lastName = _lastnameController.text;
      String email = _emailController.text;
      String confirmPass = _repasswordController.text;

      _usernameController.text.isEmpty ? _validate = true : _validate = false;
      _passwordController.text.isEmpty ? _validate = true : _validate = false;
      _firstnameController.text.isEmpty ? _validate = true : _validate = false;
      _lastnameController.text.isEmpty ? _validate = true : _validate = false;
      _emailController.text.isEmpty ? _validate = true : _validate = false;
      _repasswordController.text.isEmpty ? _validate = true : _validate = false;
      if (password != confirmPass) {

      }
      else if(_validate!=false)
        {

        }
      else if (validateEmail(email)!=null) {

      }
      else {
        User user = await createUser(username, firstName, lastName, email, password);
        setState(() {
          nameeeee=user.firstname;
        });

       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              alignment: Alignment(-.2, 0),
                              image: NetworkImage(
                                  'https://source.unsplash.com/random/?dark,people'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 35, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.article_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              'Note Caster $nameeeee',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 500,
                  child: LayoutBuilder(
                      builder: (BuildContext context,
                          BoxConstraints constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25, 20, 0, 0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Username',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                        ),
                                        textAlign: TextAlign.start,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    height: 50,
                                    child: Material(
                                      elevation: 20.0,
                                      shadowColor: Colors.black54,
                                      borderRadius: BorderRadius.circular(30),
                                      child: TextFormField(
                                        controller: _usernameController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter a username';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          errorText: _validate
                                              ? 'Field Can\'t Be Empty'
                                              : null,
                                          contentPadding: EdgeInsets.all(15),
                                          fillColor: Colors.white,
                                          suffixIcon: Icon(Icons.mail_outline,
                                              color: Colors.deepPurpleAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25, 20, 0, 0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'First Name',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                        ),
                                        textAlign: TextAlign.start,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    height: 50,
                                    child: Material(
                                      elevation: 20.0,
                                      shadowColor: Colors.black54,
                                      borderRadius: BorderRadius.circular(30),
                                      child: TextFormField(
                                        controller: _firstnameController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter your first name';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          errorText: _validate
                                              ? 'Field Can\'t Be Empty'
                                              : null,
                                          contentPadding: EdgeInsets.all(15),
                                          fillColor: Colors.white,
                                          suffixIcon: Icon(
                                              Icons.account_circle_sharp,
                                              color: Colors.deepPurpleAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25, 20, 0, 0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Last Name',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                        ),
                                        textAlign: TextAlign.start,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    height: 50,
                                    child: Material(
                                      elevation: 20.0,
                                      shadowColor: Colors.black54,
                                      borderRadius: BorderRadius.circular(30),
                                      child: TextFormField(
                                        controller: _lastnameController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter last name';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          errorText: _validate
                                              ? 'Field Can\'t Be Empty'
                                              : null,
                                          contentPadding: EdgeInsets.all(15),
                                          fillColor: Colors.white,
                                          suffixIcon: Icon(
                                              Icons.account_circle_rounded,
                                              color: Colors.deepPurpleAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25, 20, 0, 0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Email',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                        ),
                                        textAlign: TextAlign.start,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    height: 50,
                                    child: Material(
                                      elevation: 20.0,
                                      shadowColor: Colors.black54,
                                      borderRadius: BorderRadius.circular(30),
                                      child: TextFormField(
                                        controller: _emailController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter an email';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          errorText: _validate
                                              ? 'Field Can\'t Be Empty'
                                              : null,
                                          contentPadding: EdgeInsets.all(15),
                                          fillColor: Colors.white,
                                          suffixIcon: Icon(Icons.mail_outline,
                                              color: Colors.deepPurpleAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25, 20, 0, 0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Password',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                        ),
                                        textAlign: TextAlign.start,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    height: 50,
                                    child: Material(
                                      elevation: 20.0,
                                      shadowColor: Colors.black54,
                                      borderRadius: BorderRadius.circular(30),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter an email';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          errorText: _validate
                                              ? 'Field Can\'t Be Empty'
                                              : null,
                                          contentPadding: EdgeInsets.all(15),
                                          fillColor: Colors.white,
                                          suffixIcon: Icon(Icons.lock,
                                              color: Colors.deepPurpleAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25, 20, 0, 0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Confirm Password',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                        ),
                                        textAlign: TextAlign.start,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    height: 50,
                                    child: Material(
                                      elevation: 20.0,
                                      shadowColor: Colors.black54,
                                      borderRadius: BorderRadius.circular(30),
                                      child: TextFormField(
                                        controller: _repasswordController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          errorText: _validate
                                              ? 'Field Can\'t Be Empty'
                                              : null,
                                          contentPadding: EdgeInsets.all(15),
                                          fillColor: Colors.white,
                                          suffixIcon: Icon(Icons.lock,
                                              color: Colors.deepPurpleAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: SizedBox(
                                    width: 350,
                                    height: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        _performLogin();
                                      },
                                      style: ButtonStyle(
                                        foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                        backgroundColor: MaterialStateProperty
                                            .all<Color>(
                                            Colors.deepPurpleAccent),
                                        shape:
                                        MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(30),
                                              side:
                                              BorderSide(color: Colors
                                                  .deepPurpleAccent)),
                                        ),
                                      ),
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

