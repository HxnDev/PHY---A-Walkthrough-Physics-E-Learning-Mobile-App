//==================================================================================================
//=================================FOR THE STUDENT VIEW=============================================
//==================================================================================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/material/theme.dart';
import 'package:mobile_app/utilities/navigation.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';


//================================================================================================================================
//===============================================SYLLABUS BEGIN===========================================================
//================================================================================================================================

class Syllabus extends StatelessWidget
{
  static const Color primaryColor = const Color(0xff2D1E40);
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Colors.white,

          //leading: IconButton(icon: Icon(Icons.menu_outlined ,color: Colors.deepPurple,), onPressed: () {},),

          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp, color: primaryColor,),
            onPressed: (){
              navigateBack(context);
              },
          ),
          title: Text("Syllabus ",style: TextStyle(color: primaryColor),
          ),
        ),
        body: Center(
          child: syllabusPage(),
        ),
      ),
    );
  }
}
class syllabusPage extends StatefulWidget
{
  @override
  syllabusPageState createState() => syllabusPageState();
}

class syllabusPageState extends State<syllabusPage>
{
  @override
  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,

      ),
    );
  }
}
//================================================================================================================================
//===============================================SYLLABUS BEGIN END===========================================================
//================================================================================================================================