import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_caster/signup.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool obscureText = true;
  bool invisible = true;
  String _password;
  // Toggles the password show status
  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void inContact(TapDownDetails details) {
    setState(() {
      invisible = false;
    });
  }

  void outContact(TapUpDetails details) {
    setState(() {
      invisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: SizedBox(
              height: 1000,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                                  'Note Caster',
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 20, 0, 0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Username/Email',
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
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
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
                          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
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
                                textAlignVertical: TextAlignVertical.center,
                                obscuringCharacter: "*",
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: GestureDetector(
                                    onTapDown: inContact,
                                    onTapUp: outContact,
                                    child: IconButton(
                                      icon: Icon(Icons.lock_open_outlined),
                                      color: Colors.deepPurpleAccent,
                                      onPressed: () {
                                        setState(() {
                                          invisible = false;
                                        });
                                      },
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(15),
                                  fillColor: Colors.white,
                                ),
                                validator: (val) =>
                                    val.length < 6 ? 'Password too short.' : null,
                                obscureText: obscureText,
                                onSaved: (val) => _password = val,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: SizedBox(
                            width: 350,
                            height: 50,
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.deepPurpleAccent),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                          color: Colors.deepPurpleAccent)),
                                ),
                              ),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
