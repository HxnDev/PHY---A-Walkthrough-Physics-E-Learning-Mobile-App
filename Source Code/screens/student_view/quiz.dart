
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/material/theme.dart';
import 'package:mobile_app/utilities/globals.dart';
import 'package:mobile_app/utilities/helpful_methods.dart';
import 'package:mobile_app/utilities/navigation.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

//================================================================================================================================
//===============================================QUIZ=============================================================================
//================================================================================================================================

class QuizStudentsView extends StatelessWidget
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
          title: Text("Quizzes ",style: TextStyle(color: primaryColor),
          ),
        ),
        body: Center(


          child: MyStatefulWidgetQSW(),
        ),
      ),
    );
  }
}
// stores ExpansionPanel state information
class ItemQSV {
  ItemQSV({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  int expandedValue;
  String headerValue;
  bool isExpanded;
}

List<ItemQSV> generateItemQSV(int numberOfItems) //VLSV = video lecture student view
{
  List<int> lectures =[3,4,2,3,4,5,3,4,3,5];
  List<String> Chapters = GlobalVars.chapters;
  List<int> noQuizzes = GlobalQuizData.quizCounts;

  return List<ItemQSV>.generate(numberOfItems, (int index) {
    return ItemQSV(

      headerValue: Chapters[index],
      expandedValue: noQuizzes[index],
    );
  });
}
class MyStatefulWidgetQSW extends StatefulWidget {
  MyStatefulWidgetQSW({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetStateQSW createState() => _MyStatefulWidgetStateQSW();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetStateQSW extends State<MyStatefulWidgetQSW>
{
  static const Color primaryColor = const Color(0xff2D1E40);
  var LectNum = 0;
  final List<ItemQSV> _data = generateItemQSV(GlobalVars.chapters.length);
  List<bool> selected = List<bool>.generate(GlobalVars.chapters.length, (int index) => false);
  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel()
  {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded)
      {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((ItemQSV item)
      {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded)
          {

            return Container(
              margin: EdgeInsets.all(16),
              child: Stack(
                children: <Widget>[
                  Card(
                    shadowColor: Colors.blueGrey[600],
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: primaryColor,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          SizedBox(
                            width: 16,
                            height: 30,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(item.headerValue,
                                    style: TextStyle(color: Colors.white)),

                              ],
                            ),

                          ),
                        ],

                      ),
                    ),
                  ),
                ],
              ),
            );

          },


          body: ListViewTilesQSV('https://www.youtube.com/watch?v=OOMxU9f1FBU',item.expandedValue, item.headerValue),



          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

}

//for list view
class ListViewTilesQSV extends StatelessWidget
{

  String text;
  int numLect;
  String chapter;

  ListViewTilesQSV(this.text,this.numLect, this.chapter);

  Map<String, List<List<String>>> chapterValuesMap = GlobalQuizData.chapterValuesMap;

  String getName(int index) {
    dynamic value = chapterValuesMap[chapter];
    List<String> names = value[1];
    return names[index];
  }

  String getURL(int index) {
    dynamic value = chapterValuesMap[chapter];
    List<String> urls = value[0];
    return urls[index];
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: numLect,
      itemBuilder: (context,index){
        return ListTile(
          //tileColor: Colors.lightBlueAccent[700],
          selectedTileColor: Colors.grey[400],
          leading: Icon(Icons.arrow_right_outlined),
          title: Text(getName(index),
            style: TextStyle(
            fontSize: 18.0,
          ),),
          onTap: ()
          {
            launchURLWithoutCheck(getURL(index));
          } ,
        );
      },

    );

  }
}
//================================================================================================================================
//===============================================QUIZ END=========================================================================
//================================================================================================================================
