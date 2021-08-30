import 'dart:math';
import 'dart:io';
import 'package:mobile_app/utilities/globals.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';

class FileStorage {

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future uploadFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    File file = File(result.files.single.path);

    String filename = basename(file.path);
    String url = this.savePDF(file, filename) as String;
  }

  Future savePDF(File pdfFile, String filename) async {
    try {
      Reference ref = _storage.ref().child('any').child(filename);
      UploadTask uploadTask = ref.putFile(pdfFile, SettableMetadata(contentType: 'application/pdf'));

      TaskSnapshot snapshot = await uploadTask;
      String url = await snapshot.ref.getDownloadURL();

      print("URL of uploaded file is: $url");
      return url;
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<int> getNumberOfItems() async {
    final Reference ref = _storage.ref().child('any');
    dynamic result = await ref.listAll();
    var resultItems = result.items;
    return resultItems.length;
  }

  Future<Map<String, List<List<String>>>> getPastPaperURLsAndNames(String selectedCourse) async {
    final Reference ref = _storage.ref().child(selectedCourse).child('past_papers');

    Map<String, List<List<String>>> yearValuesMap = Map();

    for (int i = 0; i < GlobalVars.pastPaperYears.length; i++) {
      String year = GlobalVars.pastPaperYears[i];

      Reference ref2 = ref.child(year);

      List <String> listOfAllURLs = [];
      List <String> fileNames = [];

      dynamic res = await ref2.listAll().then( (result) async {
          var resultItems = result.items;

          for (int i = 0; i< resultItems.length; i++){
            var item = resultItems[i];

            dynamic downloadUrl = await item.getDownloadURL();
            String url = downloadUrl.toString();

            String name = item.name;

            listOfAllURLs.add(url);
            fileNames.add(name);
            //print('Added $url to list of all urls');
          }

          List<List<String>> results = [];
          results.add(listOfAllURLs);
          results.add(fileNames);

          return results;
        }
      );

      yearValuesMap[year] = res;
    }

    //print(yearValuesMap);
    return yearValuesMap;
  }

  Future<Map<String, List<List<String>>>> getQuizzesURLsAndNames(String selectedCourse) async {
    final Reference ref = _storage.ref().child(selectedCourse).child('quizzes');

    Map<String, List<List<String>>> chapterValuesMap = Map();

    for (int i = 0; i < GlobalVars.chapters.length; i++) {
      String chapter = GlobalVars.chapters[i];

      Reference ref2 = ref.child(chapter);

      List <String> listOfAllURLs = [];
      List <String> fileNames = [];

      dynamic res = await ref2.listAll().then( (result) async {
        var resultItems = result.items;

        for (int i = 0; i< resultItems.length; i++){
          var item = resultItems[i];

          dynamic downloadUrl = await item.getDownloadURL();
          String url = downloadUrl.toString();

          String name = item.name;

          listOfAllURLs.add(url);
          fileNames.add(name);
          //print('Added $url to list of all urls');
        }

        List<List<String>> results = [];
        results.add(listOfAllURLs);
        results.add(fileNames);

        return results;
      }
      );

      chapterValuesMap[chapter] = res;
    }

    //print(yearValuesMap);
    return chapterValuesMap;
  }

  Future<Map<String, List<List<String>>>> getWorksheetsURLsAndNames(String selectedCourse) async {
    final Reference ref = _storage.ref().child(selectedCourse).child('worksheets');

    Map<String, List<List<String>>> chapterValuesMap = Map();

    for (int i = 0; i < GlobalVars.chapters.length; i++) {
      String chapter = GlobalVars.chapters[i];

      Reference ref2 = ref.child(chapter);

      List <String> listOfAllURLs = [];
      List <String> fileNames = [];

      dynamic res = await ref2.listAll().then( (result) async {
        var resultItems = result.items;

        for (int i = 0; i< resultItems.length; i++){
          var item = resultItems[i];

          dynamic downloadUrl = await item.getDownloadURL();
          String url = downloadUrl.toString();

          String name = item.name;

          listOfAllURLs.add(url);
          fileNames.add(name);
          //print('Added $url to list of all urls');
        }

        List<List<String>> results = [];
        results.add(listOfAllURLs);
        results.add(fileNames);

        return results;
      }
      );

      chapterValuesMap[chapter] = res;
    }

    //print(yearValuesMap);
    return chapterValuesMap;
  }

  Future<String> getSyllabusURL(String selectedCourse) async {
    final Reference ref = _storage.ref().child(selectedCourse).child('syllabus');

      dynamic res = await ref.listAll().then( (result) async {
          var resultItems = result.items;
          String url = '';

          for (int i = 0; i < resultItems.length; i++){
            var item = resultItems[i];

            dynamic downloadUrl = await item.getDownloadURL();
            url = downloadUrl.toString();

          }
          return url;
        }
      );

      return res;
  }

  Future<void> getVideoLinks(String selectedCourse) async {
    //DocumentReference docRef = FirebaseFirestore.instance.collection(selectedCourse).document();
  }

}