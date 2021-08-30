import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/database/storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_app/database/auth.dart';
import 'package:mobile_app/utilities/toast.dart';
import 'home_page.dart';
import 'package:mobile_app/utilities/navigation.dart';


class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginSignUpPageState createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> with SingleTickerProviderStateMixin {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  bool _loading = false;

  String _email = '';
  String _password = '';
  String _msg = '';

  static const Color primaryColor = const Color(0xff2D1E40);
  static const Color primarylightColor = const Color(0x4DE3CBED);
  static const Color primaryhighlightColor = Colors.greenAccent;

  int eyeicon1 = 1;
  int eyeicon2 = 1;

  void _updateeyeicon1() {

    if (eyeicon1 == 1){
      setState(() {
        eyeicon1 = 0 ;
      });}
    else if (eyeicon1 == 0){
      setState(() {
        eyeicon1 = 1 ;
      });}
    print(eyeicon1);
  }
  void _updateeyeicon2() {

    if (eyeicon2 == 1)
      setState(() {
        eyeicon2 = 0 ;
      });
    else if (eyeicon2 == 0)
      setState(() {
        eyeicon2 = 1 ;
      });
  }

  TabController _controller;
  var _controller2 ;

  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
    _controller2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: Center(

        child: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              height: 290,
              decoration: BoxDecoration(
                color:primaryColor,
                  image: DecorationImage(
                  image: AssetImage("images/T_9-01.jpg"),
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    fit: BoxFit.cover,
                  ),

              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top:95.0),
                      child:
                      Text(
                        'Phy',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontFamily: "kg-legacy-of-virtue",
                          fontSize: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:8.0,bottom: 60),
                      child:
                      Text(
                        //'GCSE O Levels | GCSE A Levels | Edexcel',
                        'A Walkthrough Physics',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 16,
                          color:const Color(0x99E3CBED)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(color: primaryColor),
              child: TabBar(
                labelColor: primaryhighlightColor,
                unselectedLabelColor: Colors.white,
                indicatorColor:primaryhighlightColor,
                controller:_controller,
                tabs: [
                  new Tab(
                    text: 'Login',

                  ),
                  new Tab(
                    text: 'Sign up',
                  ),
                ],
              ),
            ),
            Container(
              height: 345.0,
              decoration: BoxDecoration(color: Colors.white),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: TabBarView(
                  controller:_controller,
                  children: [

                    //LOGIN TAB
                    Container(
                      decoration: BoxDecoration(color: primarylightColor),
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[

                              const SizedBox(height: 30),
                              ConstrainedBox(

                                constraints: BoxConstraints.tightFor(width: 250, height: 50),

                                child: TextFormField(
                                  validator: (val) => val.isEmpty || !val.contains("@") ? 'Enter a valid email' : null,
                                  onChanged: (val) {
                                    setState(() => _email = val);
                                    print(_email);
                                  },

                                  //textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15.0, color: primaryColor),
                                  cursorColor: primaryColor,

                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: primaryhighlightColor, width: 2.5),
                                    ),
                                    errorBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.redAccent, width: 2.5),
                                      borderRadius: BorderRadius.circular(10)
                                    ),

                                    fillColor: const Color(0x40576681),
                                    //filled: true,

                                    //isDense: true,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(left: 30.0, right: 10.0),
                                      child: Icon(
                                        Icons.person,
                                        color: primaryColor,
                                        size: 20,),
                                    ),

                                    hintText: 'Your Email',

                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: primaryColor,
                                    ),

                                  ),
                                ),

                              ),
                              ConstrainedBox(

                                constraints: BoxConstraints.tightFor(width: 250, height: 50),

                                child: TextFormField(

                                  validator: (val) => val.length < 6 ? 'Enter a password 6+ characters long' : null,
                                  onChanged: (val) {
                                    setState(() => _password = val);
                                    print(_password);
                                  },

                                  //textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15.0, color: primaryColor),
                                  cursorColor: primaryColor,
                                  obscureText: (eyeicon1 == 1) ? true : false,
                                  decoration: InputDecoration(

                                    errorBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.redAccent, width: 2.5),
                                        borderRadius: BorderRadius.circular(10)
                                    ),

                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color:primaryhighlightColor, width: 2.5),
                                    ),

                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(left: 30.0, right: 10.0),
                                      child: Icon(
                                        Icons.lock,
                                        color: primaryColor,
                                        size: 20,),
                                    ),

                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(right: 15.0),
                                      child: IconButton(
                                        color: primaryColor,
                                        iconSize: 20,
                                        onPressed: (){
                                          print('Pressed');
                                          _updateeyeicon1();
                                        }, //=> _controller2.clear(),
                                        icon: (eyeicon1 == 1) ? Icon(Icons.visibility,) : Icon(Icons.visibility_off,),
                                      ),),

                                    hintText: 'Your Password',

                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: primaryColor,
                                    ),

                                  ),
                                ),

                              ),
                              const SizedBox(height: 17),
                              ElevatedButton(

                                style:

                                ElevatedButton.styleFrom(

                                  primary: primaryColor,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                  padding: EdgeInsets.only(right:100.0,left: 100, top:10.0, bottom: 10.0),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(10.0),
                                  ),

                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => _loading = true);
                                    dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);

                                    if (result == null) {
                                      print('unsuccessful sign in');

                                      setState(() {
                                        _loading = false;
                                        _msg = 'Invalid email or password';
                                      });
                                    }

                                    else {
                                      setState(() {
                                        _loading = false;
                                        _msg = 'Signing in';
                                      });
                                    }

                                    print(_msg);

                                    // display toast message
                                    displayToast(_msg);

                                    if (result != null) {
                                          navigateToHomePage(context);
                                    }
                                  }
                                },
                                child: Text('Login',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color:Colors.white,
                                  ),
                                ),

                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top:0.0),
                                    child:
                                    Text(
                                      'Trouble signing in? ',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  TextButton(

                                      style: TextButton.styleFrom(

                                        primary: primaryhighlightColor,
                                        onSurface: Colors.blueAccent,
                                        padding: EdgeInsets.only(right:0.0,left: 0),

                                      ),

                                      child: Text('Forgot Password',textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                            decoration: TextDecoration.underline
                                        ),

                                      ),
                                      onPressed: () async {
                                        print('forgot password pressed');

                                        // need an email
                                        if (_email.isEmpty || !_email.contains('@')) {
                                          setState(() {
                                            _msg = 'Provide an email';
                                          });
                                        }

                                        // test out the email
                                        else {
                                          dynamic result = await _auth.resetPassword(_email);

                                          // if reset password failed
                                          if (result == null) {
                                            setState(() {
                                              _msg = 'Password Reset Unsuccessful';
                                            });
                                          }

                                          // if successful
                                          else {
                                            setState(() {
                                              _msg = 'Password Reset Email Sent';
                                            });
                                          }
                                        }

                                        // display confirmation / warning message
                                        displayToast(_msg);
                                      }

                                  )
                                ],
                              ),

                            ]
                        ),
                      ),
                    ),

                    //SIGN UP TAB
                    Container(
                      decoration: BoxDecoration(color:primarylightColor),
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[

                              const SizedBox(height: 30),
                              ConstrainedBox(

                                constraints: BoxConstraints.tightFor(width: 250, height: 50),

                                child: TextFormField(
                                  validator: (val) => val.isEmpty || !val.contains("@") ? 'Enter a valid email' : null,
                                  onChanged: (val) {
                                    setState(() => _email = val);
                                    print(_email);
                                  },

                                  //textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15.0, color: primaryColor),
                                  cursorColor: primaryColor,

                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: primaryhighlightColor, width: 2.5),
                                    ),
                                    errorBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.redAccent, width: 2.5),
                                    ),

                                    fillColor: const Color(0x40576681),
                                    //filled: true,

                                    //isDense: true,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(left: 30.0, right: 10.0),
                                      child: Icon(
                                        Icons.person,
                                        color: primaryColor,
                                        size: 20,),
                                    ),

                                    hintText: 'Your Email',

                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: primaryColor,
                                    ),

                                  ),
                                ),

                              ),
                              ConstrainedBox(

                                constraints: BoxConstraints.tightFor(width: 250, height: 50),

                                child: TextFormField(
                                  validator: (val) => val.length < 5 ? 'Enter a password 6+ characters long' : null,
                                  onChanged: (val) {
                                    setState(() => _password = val);
                                    print(_password);
                                  },

                                  //textAlign: TextAlign.center,
                                  controller: _controller2,

                                  style: TextStyle(fontSize: 15.0, color: primaryColor),
                                  cursorColor: primaryColor,
                                  obscureText: (eyeicon2 == 1) ? true : false,
                                  decoration: InputDecoration(

                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: primaryhighlightColor, width: 2.5),
                                    ),
                                    errorBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.redAccent, width: 2.5),
                                    ),

                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(left: 30.0, right: 10.0),
                                      child: Icon(
                                        Icons.lock,
                                        color: primaryColor,
                                        size: 20,),
                                    ),

                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(right: 15.0),
                                      child: IconButton(
                                        color: primaryColor,
                                        iconSize: 20,
                                        onPressed: (){
                                          print('Pressed');
                                          _updateeyeicon2();
                                        }, //=> _controller2.clear(),
                                        icon: (eyeicon2 == 1) ? Icon(Icons.visibility,) : Icon(Icons.visibility_off,),
                                      ),),

                                    hintText: 'Your Password',

                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: primaryColor,
                                    ),

                                  ),
                                ),

                              ),
                              const SizedBox(height: 17),
                              ElevatedButton(

                                style:

                                ElevatedButton.styleFrom(

                                  primary: primaryColor,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                  padding: EdgeInsets.only(right:100.0,left: 100, top:10.0, bottom: 10.0),
                                  shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(10.0),
                                          ),

                                ),

                                // sign up button
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    dynamic result = await _auth.registerWithEmailAndPassword(_email, _password);

                                    if (result == null) {
                                      print('unsuccessful sign up');

                                      setState(() {
                                        _msg = 'Sign up unsuccessful';
                                      });
                                    }

                                    else {
                                      setState(() {
                                        _msg = 'Sign up successful';
                                      });
                                    }

                                    print(_msg);
                                    displayToast(_msg);
                                  }
                                },

                                child: Text('Sign up',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color:Colors.white,
                                  ),
                                ),

                              ),
                              const SizedBox(height: 17),


                              Text(
                                '__________________ OR __________________ ',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),

                              ConstrainedBox(

                                constraints: BoxConstraints.tightFor(width: 250, height: 40),

                                child:ElevatedButton(

                                style:

                                ElevatedButton.styleFrom(

                                  primary: const Color(0xffC94130),
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                  padding: EdgeInsets.only(right:30.0,left: 0.0, top:10.0, bottom: 10.0),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(10.0),
                                  ),

                                ),

                                // sign up with google
                                onPressed: () async {
                                  dynamic result = await _auth.signInWithGoogle();

                                  if (result == null) {
                                    print('sign in with google unsuccessful');
                                  }

                                  else {
                                    print('sign in with google successful');
                                    navigateToHomePage(context);

                                  }
                                },

                                child: Row( // Replace with a Row for horizontal icon + text
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.google,
                                    size: 20,),
                                    Text('Sign in with Google',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color:Colors.white,
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                              ),

                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}