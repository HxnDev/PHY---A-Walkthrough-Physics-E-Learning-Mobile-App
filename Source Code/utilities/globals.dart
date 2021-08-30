import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile_app/database/storage.dart';

class Constants{

  static const String SignOut = 'Sign out';
  static const List<String> choices = <String>[
    SignOut
  ];

}

class GlobalVars {
  static int selectedCourseIndex = 0;

  static List<String> courses = <String>['GCSE O Levels','GCSE A Levels','IGCSE O Levels','IGCSE A Levels','Edexcel','IB MYP', 'IB DP'];
  static List<String> resources = ['Syllabus','Past Papers','Worksheets','Video Lectures','Quizzes'];
  static List<String> pastPaperYears = ['2018','2017','2016', '2015','2014','2013','2012','2011', '2010'];
  static List<String> chapters = ['Units and Measurements','Force','Magnetism','Gravitation','Work, Energy and Power', 'Thermodynamics','Matter','Kinetic Theory','Oscillations','Waves'];


}

class GlobalPastPaperData {

  static Map<String, List<List<String>>> yearValuesMap = Map();
  static List<int> pastPaperCounts = [];

  static Future<void> loadData(String selectedCourse) async {
      final FileStorage _storage = FileStorage();
      yearValuesMap = await _storage.getPastPaperURLsAndNames(selectedCourse);

      for (int i = 0; i < GlobalVars.pastPaperYears.length; i++) {
        String year = GlobalVars.pastPaperYears[i];
        dynamic value = yearValuesMap[year];
        List<String> names = value[1];
        pastPaperCounts.add(names.length);
      }
  }
}

class GlobalQuizData {

  static Map<String, List<List<String>>> chapterValuesMap = Map();
  static List<int> quizCounts = [];

  static Future<void> loadData(String selectedCourse) async {
    final FileStorage _storage = FileStorage();
    chapterValuesMap = await _storage.getQuizzesURLsAndNames(selectedCourse);

    for (int i = 0; i < GlobalVars.chapters.length; i++) {
      String chapter = GlobalVars.chapters[i];
      dynamic value = chapterValuesMap[chapter];
      List<String> names = value[1];
      quizCounts.add(names.length);
    }
  }
}

class GlobalWorksheetData {

  static Map<String, List<List<String>>> chapterValuesMap = Map();
  static List<int> worksheetCounts = [];

  static Future<void> loadData(String selectedCourse) async {
    final FileStorage _storage = FileStorage();
    chapterValuesMap = await _storage.getWorksheetsURLsAndNames(selectedCourse);

    for (int i = 0; i < GlobalVars.chapters.length; i++) {
      String chapter = GlobalVars.chapters[i];
      dynamic value = chapterValuesMap[chapter];
      List<String> names = value[1];
      worksheetCounts.add(names.length);
    }
  }
}

class GlobalSyllabusData {

  static String syllabusURL;

  static Future<void> loadData(String selectedCourse) async {
      final FileStorage _storage = FileStorage();
      syllabusURL = await _storage.getSyllabusURL(selectedCourse);
  }
}

class ConstantsforSearch{

  static const String Save = 'Save';
  static const List<String> choices = <String>[
    Save
  ];
}

class Post {

  final String title;
  final String links;
  final String types;

  Post(this.title , this.types, this.links);
}