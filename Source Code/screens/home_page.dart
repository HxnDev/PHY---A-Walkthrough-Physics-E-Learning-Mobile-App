import 'dart:ffi';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_app/utilities/navigation.dart';
import 'package:mobile_app/utilities/globals.dart';
import 'package:mobile_app/database/auth.dart';
import 'package:mobile_app/utilities/toast.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  int _currentindex = 0;
  int _childcount = 5;
  var appbartitletext = 'Home';
  Size size ;

  int tapped_index = 0;//for course selection in the home page

  static const Color primaryColor = const Color(0xff2D1E40);
  static const Color primarylightColor = const Color(0x4DE3CBED);
  static const Color primaryhighlightColor = Colors.greenAccent;

  // for the drawer and its listview
  List<String> courses = GlobalVars.courses;


  int get childcountnum{
    return _childcount;
  }

  set childcountnum(int x) {
    _childcount = x;
    _changecountofhomeoptions(x);
  }

  void _changeAppBarTitle(int x) {
    setState(() {

      if (x == 0 ){
        appbartitletext = 'Home';
      }
      if (x == 1 ){
        appbartitletext = 'Search';
      }
      if (x == 2 ){
        appbartitletext = 'Library';
      }
      if (x == 3 ){
        appbartitletext = 'Settings';
      }

    });
  }

  void _changecountofhomeoptions(int x) {
    setState(() {

      _childcount = x;

    });

  }
  void _updateSize(Size x) {
    setState(() {
      size = x ;
    });
  }

  // This is for the sign out button, you can add the code here for signing out
  void choiceAction(String choice){
    if(choice == Constants.SignOut){
      print('SignOut');
      navigateToStartPage(context);
    }
  }

  //USED IN THE HOME DRAWER
  void updateSelectedofDrawerList(int ind){
    setState(() {
      tapped_index = ind;
      GlobalVars.selectedCourseIndex = tapped_index;
    });
  }


  @override
  Widget build(BuildContext context) {

    Size nsize = MediaQuery.of(context).size;
    _updateSize(nsize);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        //Disabling drawer on search and settings tab
        drawerEdgeDragWidth: ((_currentindex == 0 || _currentindex == 2  )) ? nsize.width : 0,

        appBar: AppBar(
          centerTitle: true,
          title: Text(appbartitletext,
            style: TextStyle(
              color: Colors.white,
            ),

          ),
          backgroundColor: primaryColor,
          backwardsCompatibility: false,
          systemOverlayStyle:SystemUiOverlayStyle.dark.copyWith(statusBarIconBrightness: Brightness.light ,
          ),
          actions: <Widget>[
            PopupMenuButton<String>(

              color: Colors.white,
              icon: Icon(Icons.more_vert,
                color: Colors.white,
              ),
              onSelected: choiceAction,
              itemBuilder: (BuildContext context){
                return Constants.choices.map((String choice){
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],

          leading: Builder(
            builder: (BuildContext context) {
              if ((_currentindex == 0 || _currentindex == 2  )) {
                return IconButton(
                  icon: const Icon(Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              } else {
                return new Container(width: 0, height: 0);
              }
            },
          ),

        ),
        body:  //tabs[_currentindex],
        _currentindex  == 0 ? MyHomeLayout() : _currentindex  == 1 ? MySearchLayout() : _currentindex  == 2 ? MySavedLayout() : MySettingsLayout(),

        drawer:  Container(

          //width: 200,
          decoration: BoxDecoration(
            color: primaryColor,

          ),
          child:
          Drawer(

            child: ListView(

              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              //shrinkWrap: true,

              children: <Widget>[

                Container(

                  height: 200.0,

                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    //color: primarylightColor
                    color: const Color(0x8CE3CBED),

                  ),

                  child :
                  DrawerHeader(
                    //padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      image: DecorationImage(
                        image: (_currentindex == 0) ?

                        AssetImage("images/vector-formidable-forest-illustration.jpg"):
                        AssetImage("images/Sunset_Forest_Landscape_Illustration_generated.jpg"),

                        colorFilter: new ColorFilter.mode(Colors.blue.withOpacity(0.7), BlendMode.dstATop),
                        fit: BoxFit.cover,
                      ),
                      //borderRadius: BorderRadius.only(
                      // topRight: Radius.circular(20),
                      // ),
                    ),
                    child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('Courses',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,

                          ),
                        ]
                    ),
                  ),
                ),

                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child : Container(
                    height: (nsize.height/ 12)* (courses.length + 2), // Giving the box dynamic height, 12 fields fit in the screen
                    color: primarylightColor,
                    child : Column(

                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: (nsize.height/ 12),

                            child: new ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: courses.length,
                              itemBuilder: (BuildContext context, int index) {
                                return new ListTile(

                                  selected : (index == tapped_index) ? true : false ,
                                  selectedTileColor: (index % 2 == 0) ? Colors.purpleAccent : Colors.lightBlueAccent,
                                  tileColor: (index % 2 == 0) ? primarylightColor :const Color(0x998ECFE1),
                                  title: Text(courses[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,

                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  trailing: (index == tapped_index) ? Icon(Icons.arrow_right,
                                    color: Colors.black,
                                    size: 40,
                                  ): Icon(Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 40,

                                  ),
                                  onTap: () {

                                    updateSelectedofDrawerList(index);

                                  },
                                );
                              },
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




        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentindex,

          showUnselectedLabels: false,
          showSelectedLabels: false,
          iconSize: 20,
          type: BottomNavigationBarType.fixed,
          backgroundColor: primaryColor,
          selectedItemColor: primaryhighlightColor,
          unselectedItemColor: Colors.white,
          items: [

            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home),
              title : Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.search),
              title : Text('Search'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bookmark),
              title : Text('Library'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.cog),
              title : Text('Settings'),
            ),
          ],

          onTap:(index){
            setState(() {
              _currentindex = index;
              _changeAppBarTitle(index);
            });
          } ,
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyHomeLayout extends StatefulWidget {
  MyHomeLayout({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<MyHomeLayout>  {

  int homeButtonIndex; //For the Home page
  var button_name = GlobalVars.resources;
  List<IconData> icons = [Icons.description_outlined ,Icons.library_books_outlined,Icons.assignment_outlined,Icons.videocam_outlined,Icons.fact_check_outlined];
  //USED FOR HOME PAGE
  void updateHomeIndex(int ind){
    setState(() {
      homeButtonIndex = ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center (
      child : Scaffold(
        backgroundColor: _MyHomePageState.primarylightColor,
        body:
        Center(

          child:

          CustomScrollView(

            slivers: <Widget>[

              SliverPadding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),

                sliver :SliverGrid(

                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return ElevatedButton(

                        style:

                        ElevatedButton.styleFrom(

                          primary: Colors.purple[100 * (index % 9 + 1)],
                          onPrimary: Colors.white,
                          onSurface: Colors.greenAccent,
                          padding: EdgeInsets.only(right:10.0,left: 10, top:10.0, bottom: 10.0),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),

                        ),

                        onPressed: () {
                          updateHomeIndex(index);
                          print('selected index:');
                          print(index);

                          String selectedResource = GlobalVars.resources[index];
                          String selectedCourse = GlobalVars.courses[GlobalVars.selectedCourseIndex];

                          print('selected resource: ' + selectedResource);
                          print('selected course: ' + selectedCourse);

                          navigateToResourceView(context, selectedResource, selectedCourse);
                        },

                        child: Column (

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(icons[index],
                                size: 60,

                                color: (index == homeButtonIndex ) ? _MyHomePageState.primaryhighlightColor: Colors.white,
                              ),

                              const SizedBox(height: 5),

                              Text(button_name[index],
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: (index == homeButtonIndex ) ? _MyHomePageState.primaryhighlightColor: Colors.white,
                                ),
                              ),
                            ]
                        ),
                      ) ;
                    },
                    childCount: _MyHomePageState().childcountnum,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.0,

                  ),
                ),
              ),
            ],
          ),

        ),
        floatingActionButton:FloatingActionButton(

          backgroundColor: _MyHomePageState.primaryColor,
          foregroundColor: Colors.white,
          onPressed: () {
            // Respond to button press
            //Have to deal with additional code here and then obv designs will get back to ou about it
            // _MyHomePageState()._changecountofhomeoptions(_MyHomePageState().childcountnum + 1);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class MySearchLayout extends StatefulWidget {
  MySearchLayout({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SearchLayoutState createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<MySearchLayout>  {

  // This is for the sign out button, you can add the code here for signing out
  void choiceAction(String choice){
    if(choice == ConstantsforSearch.Save){
      print('Save');
      navigateToStartPage(context);
    }
  }

  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    if (search == "empty") return [];
    if (search == "error") throw Error();
    return List.generate(search.length,(int index) {
      return Post(
        "Title : $search $index",
        "Type  : Past Papers",
        "https://api.flutter.dev/flutter/material/ListTile-class.html",
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    Size sssize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:

      SafeArea(

        child: Container (


          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),

            image: new DecorationImage(
              alignment: Alignment.bottomLeft,
              fit: BoxFit.fitWidth,
              colorFilter: new ColorFilter.mode(const Color(0xff4D2EA6).withOpacity(0.2), BlendMode.overlay),
              image: AssetImage("images/Search Background3.png"),

            ),

            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end:  Alignment(0.2, 0.3),
                //colors: [const Color(0xffE4EDF0),Colors.purple]
                colors: [const Color(0xffE4EDF0),const Color(0xff4D2EA6)]
            ),

          ),

          child: Padding(

            padding: const EdgeInsets.symmetric(horizontal: 20),

            child:

            SearchBar<Post>(

              searchBarStyle: SearchBarStyle(

                backgroundColor: Colors.white,
                padding: EdgeInsets.all(0),
                borderRadius: BorderRadius.circular(20),

              ),

              hintText: 'Type here to search',
              hintStyle: TextStyle(
                color: Colors.grey[400],
              ),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              minimumChars: 1,
              loader: const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent))),

              iconActiveColor: _MyHomePageState.primaryhighlightColor ,

              icon: Padding(
                padding: const EdgeInsetsDirectional.only(start: 12.0),
                child: Icon(Icons.search), // myIcon is a 48px-wide widget.
              ),

              onSearch: search,
              onItemFound: (Post post, int index) {
                return
                  Container (

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),


                    ),

                    child: ListTile(


                      leading : ( post.types == "Type  : Past Papers" ) ? Icon(Icons.library_books_outlined, color: Colors.black, size: 30,) :
                      ( post.types == "Type  : Syllabus" ) ? Icon(Icons.description_outlined, color: Colors.black, size: 30,):
                      ( post.types == "Type  : Worksheets" ) ? Icon(Icons.assignment_outlined, color: Colors.black, size: 30,):
                      ( post.types == "Type  : Video Lectures" ) ? Icon(Icons.videocam_outlined,color: Colors.black, size: 30,):  Icon(Icons.fact_check_outlined,color: Colors.black, size: 30,),

                      tileColor:  const Color(0xffE3CBED), //_MyHomePageState.primarylightColor ,
                      trailing: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child:  PopupMenuButton<String>(

                            color: Colors.white,
                            icon: Icon(Icons.more_vert,
                              color: Colors.black,
                            ),
                            onSelected: choiceAction,
                            itemBuilder: (BuildContext context){
                              return ConstantsforSearch.choices.map((String choice){
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          )
                      ),

                      title: Text(post.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),


                      isThreeLine:true,

                      //selected: true,
                      selectedTileColor: Colors.purpleAccent,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(post.types,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),

                          GestureDetector(
                            child: Text(post.links,
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                            onTap: () { print("Lets Load the Link!");
                            _launchURL(post.links);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
              },
              onError: (error) {
                return Center(
                  //child: Text("Error occurred : $error"),//I AM KEEPING THIS FOR YOU IN CASE YOU WANT TO DISPLAY ANYTHING HERE
                  //WITH A VARIABLE (FOR SANA)
                  child: Text("No results found."),
                );
              },
              emptyWidget: Center(
                child: Text("Enter something to search."),
              ),
            ),
          ),
        ),

      ),

    );
  }
}

class MySavedLayout extends StatefulWidget {
  MySavedLayout({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SavedLayoutState createState() => _SavedLayoutState();
}

class _SavedLayoutState extends State<MySavedLayout>  {

  int homeButtonIndex; //For the Home page
  var button_name = ['Syllabus','Past Papers','Worksheets','Video Lectures','Quizzes'];
  List<IconData> icons = [Icons.description_outlined ,Icons.library_books_outlined,Icons.assignment_outlined,Icons.videocam_outlined,Icons.fact_check_outlined];
  //USED FOR HOME PAGE
  void updateHomeIndex(int ind){
    setState(() {
      homeButtonIndex = ind;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Center (
      child : Scaffold(
        backgroundColor: _MyHomePageState.primarylightColor,
        body:
        Center(

          child:

          CustomScrollView(

            slivers: <Widget>[

              SliverPadding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),

                sliver :SliverGrid(

                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return ElevatedButton(

                        style:

                        ElevatedButton.styleFrom(

                          primary: Colors.blue[100 * (index % 9 + 3)],
                          onPrimary: Colors.white,
                          onSurface: Colors.greenAccent,
                          padding: EdgeInsets.only(right:10.0,left: 10, top:10.0, bottom: 10.0),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),

                        ),

                        onPressed: () {
                          updateHomeIndex(index);
                        },

                        child: Column (

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(icons[index],
                                size: 60,

                                color: (index == homeButtonIndex ) ? _MyHomePageState.primaryhighlightColor: Colors.white,

                              ),
                              const SizedBox(height: 5),

                              Text(button_name[index],
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: (index == homeButtonIndex ) ? _MyHomePageState.primaryhighlightColor: Colors.white,
                                ),
                              ),
                            ]
                        ),
                      ) ;
                    },
                    childCount: _MyHomePageState().childcountnum,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.0,

                  ),
                ),
              ),
            ],
          ),

        ),

      ),
    );
  }
}

class MySettingsLayout extends StatefulWidget {
  MySettingsLayout({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SettingsLayoutState createState() => _SettingsLayoutState();
}

class _SettingsLayoutState extends State<MySettingsLayout>  {

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  Size size ;
  int eyeicon1 = 1;
  int eyeicon2 = 1;

  String _newpass = '';
  String _confirmpass = '';

  void _updateSize(Size x) {
    setState(() {
      size = x ;
    });
  }
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

  @override
  Widget build(BuildContext context) {
    Size sssize = MediaQuery.of(context).size;
    _updateSize(sssize);

    return Scaffold (
      resizeToAvoidBottomInset: false,
      body :


      Center(


        child : Stack(children: <Widget>[


          Container(

            //padding: EdgeInsets.only(top:100.0),
            height: sssize.height,
            decoration: BoxDecoration(color:Colors.white, //const Color(0xffE4EDF0),//

              image: new DecorationImage(
                alignment: Alignment.bottomLeft,

                fit: BoxFit.fitWidth,
                //colorFilter: new ColorFilter.mode(Colors.purple.withOpacity(0.1), BlendMode.srcOver),
                image: AssetImage("images/Free Caribou Vector 02.jpg"),
              ),

            ),
          ),
          Positioned(

            child :Align(

              alignment: Alignment.bottomCenter,
              child: Container(
                height: sssize.height/2 -86,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(1.0),
                          Colors.transparent,
                        ],
                        stops: [
                          0.0,
                          1.0
                        ])),
              ),
            ),),

          SingleChildScrollView(

            child: Stack(children: <Widget>[

              Center(

                child : Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    const SizedBox(height: 136,),
                    Container(

                      //color: Colors.white,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 8,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),

                      child: Padding(

                        padding:  EdgeInsets.only(left:20.0,right: 20.0,top:40 , bottom: 20,),
                        child:
                        Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _formKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: <Widget>[

                                ConstrainedBox(

                                  constraints: BoxConstraints.tightFor(width: 250, height: 50),

                                  child: TextFormField(
                                    //textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15.0, color: const Color(0xff2D1E40)),
                                    cursorColor: const Color(0xff2D1E40),

                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.greenAccent, width: 2.5),
                                      ),
                                      errorBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.redAccent, width: 2.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),

                                      fillColor: const Color(0x40576681),
                                      //filled: true,

                                      //isDense: true,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 30.0, right: 10.0),
                                        child: Icon(
                                          Icons.person,
                                          color: const Color(0xff2D1E40),
                                          size: 20,),
                                      ),

                                      hintText: _auth.currentUser.email,  // email of signed in user
                                      enabled: false, // user cannot edit their email

                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: const Color(0xff2D1E40),
                                      ),

                                    ),
                                  ),

                                ),
                                ConstrainedBox(

                                  constraints: BoxConstraints.tightFor(width: 250, height: 50),

                                  child: TextFormField(
                                    validator: (val) => val.length < 6 ? 'Enter a password 6+ characters long' : null,
                                    onChanged: (val) {
                                      setState(() => _newpass = val);
                                      print(_newpass);
                                    },

                                    //textAlign: TextAlign.center,

                                    style: TextStyle(fontSize: 15.0, color: const Color(0xff2D1E40)),
                                    cursorColor: const Color(0xff2D1E40),
                                    obscureText: (eyeicon1 == 1) ? true : false,
                                    decoration: InputDecoration(

                                      errorBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.redAccent, width: 2.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),

                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.greenAccent, width: 2.5),
                                      ),

                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 30.0, right: 10.0),
                                        child: Icon(
                                          Icons.lock,
                                          color: const Color(0xff2D1E40),
                                          size: 20,),
                                      ),

                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(right: 15.0),
                                        child: IconButton(
                                          color: const Color(0xff2D1E40),
                                          iconSize: 20,
                                          onPressed: (){
                                            print(eyeicon1);
                                            _updateeyeicon1();
                                          },
                                          icon: (eyeicon1 == 1) ? Icon(Icons.visibility,) : Icon(Icons.visibility_off,),
                                        ),),

                                      hintText: 'New Password',

                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: const Color(0xff2D1E40),
                                      ),

                                    ),
                                  ),

                                ),
                                ConstrainedBox(

                                  constraints: BoxConstraints.tightFor(width: 250, height: 50),

                                  child: TextFormField(
                                    validator: (val) => val != _newpass ? 'Passwords should match' : null,
                                    onChanged: (val) {
                                      setState(() => _confirmpass = val);
                                      print(_confirmpass);
                                    },

                                    //textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15.0, color: const Color(0xff2D1E40)),
                                    cursorColor: const Color(0xff2D1E40),
                                    obscureText: (eyeicon2 == 1) ? true : false,
                                    decoration: InputDecoration(

                                      errorBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.redAccent, width: 2.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),

                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.greenAccent, width: 2.5),
                                      ),

                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 30.0, right: 10.0),
                                        child: Icon(
                                          Icons.lock,
                                          color: const Color(0xff2D1E40),
                                          size: 20,),
                                      ),

                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(right: 15.0),
                                        child: IconButton(
                                          color: const Color(0xff2D1E40),
                                          iconSize: 20,
                                          onPressed: (){
                                            _updateeyeicon2();
                                          },
                                          icon: (eyeicon2 == 1 ) ? Icon(Icons.visibility,) : Icon(Icons.visibility_off,),
                                        ),),

                                      hintText: 'Confirm Password',

                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: const Color(0xff2D1E40),
                                      ),

                                    ),
                                  ),

                                ),
                                const SizedBox(height: 17),
                                ElevatedButton(

                                  style:

                                  ElevatedButton.styleFrom(

                                    primary: const Color(0xff2D1E40),
                                    onPrimary: Colors.white,
                                    onSurface: Colors.grey,
                                    padding: EdgeInsets.only(right:50.0,left: 50, top:10.0, bottom: 10.0),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(10.0),
                                    ),

                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      dynamic result = _auth.updatePassword(_newpass);

                                      if (result != null) {
                                        print('password changed');
                                        // display toast message
                                        displayToast('Password change successful');
                                      }

                                      else {
                                        displayToast('Password change unsuccessful');
                                      }
                                    }
                                  },
                                  child: Text('Change Password',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color:Colors.white,
                                    ),
                                  ),

                                ),
                              ]
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Center(
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        // Padding(
                        // padding: EdgeInsets.only(bottom:20.0),
                        // child:
                        const SizedBox(height: 40),

                        Text(
                          'My Account',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(

                            fontSize: 20,
                            color: _MyHomePageState.primaryColor,
                          ),
                        ),
                        //),
                        //Padding(
                        //padding: EdgeInsets.only(bottom:335.0),
                        // child:
                        const SizedBox(height: 18),
                        Icon(
                          FontAwesomeIcons.solidUserCircle,
                          color: const Color(0xff2D1E40),
                          size: 90,
                        ),
                        // ),
                      ]
                  ),
                ),
              ),

            ],

            ),

          ),

        ],
        ),

      ),
    );
  }
}
