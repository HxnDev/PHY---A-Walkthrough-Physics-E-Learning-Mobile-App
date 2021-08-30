import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/material/theme.dart';
import 'package:mobile_app/utilities/globals.dart';
import 'package:mobile_app/utilities/navigation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

//================================================================================================================================
//===============================================VIDEO LECTURE====================================================================
//================================================================================================================================
class VideoLecturesStudentsView extends StatelessWidget {

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
          title: Text("Lecture Videos ",style: TextStyle(color: primaryColor),
          ),
        ),
        body: Center(


          child: MyStatefulWidgetVLSW(),
        ),
      ),
    );
  }
}
// stores ExpansionPanel state information
class ItemVLSV {
  ItemVLSV({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  int expandedValue;
  String headerValue;
  bool isExpanded;
}

List<ItemVLSV> generateItemVLSV(int numberOfItems) //VLSV = video lecture student view
{

  List<int> lectures =[3,4,2,3,4,5,3,4,3,5];
  List<String> Chapters = GlobalVars.chapters;
  return List<ItemVLSV>.generate(numberOfItems, (int index) {
    return ItemVLSV(

      headerValue: Chapters[index],
      expandedValue: lectures[index],
    );
  });
}
class MyStatefulWidgetVLSW extends StatefulWidget {
  MyStatefulWidgetVLSW({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetStateVLSW createState() => _MyStatefulWidgetStateVLSW();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetStateVLSW extends State<MyStatefulWidgetVLSW>
{
  static const Color primaryColor = const Color(0xff2D1E40);
  var LectNum = 0;
  final List<ItemVLSV> _data = generateItemVLSV(10);
  List<bool> selected = List<bool>.generate(10, (int index) => false);
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
      children: _data.map<ExpansionPanel>((ItemVLSV item)
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


          body: ListViewTilesVLSV('https://www.youtube.com/watch?v=OOMxU9f1FBU',item.expandedValue),



          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

}

//for list view
class ListViewTilesVLSV extends StatelessWidget{
  void _launchURL(_url) async {

    if (await canLaunch(_url)){
      await launch(_url);

    }
    else {
      throw 'Could not launch $_url';}
    //_launchURL(text);

  }
  String text;
  int numLect;
  ListViewTilesVLSV(this.text,this.numLect);
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
          title: Text("lecture $index",style: TextStyle(
            fontSize: 18.0,
          ),),
          onTap: () {

            _launchURL(text);

          } ,
        );
      },

    );

  }
}
//================================================================================================================================
//===============================================VIDEO LECTURE END================================================================
//================================================================================================================================
