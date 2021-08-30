import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_app/database/auth.dart';
import 'package:mobile_app/utilities/globals.dart';
import 'package:mobile_app/utilities/helpful_methods.dart';
import '../screens/student_view/syllabus.dart';
import '../screens/home_page.dart';
import 'package:mobile_app/screens/student_view/past_papers.dart';
import 'package:mobile_app/screens/student_view/quiz.dart';
import 'package:mobile_app/screens/student_view/syllabus.dart';
import 'package:mobile_app/screens/student_view/video_lectures.dart';
import 'package:mobile_app/screens/student_view/worksheets.dart';

Future navigateToHomePage(context) async {
  Navigator.push(context,
      MaterialPageRoute(builder:(context) =>
          MyHomePage(
              title: 'Main Skeleton'
          ),
      )
  );
}

Future navigateToResourceView(context, String selectedResource, String selectedCourse) async {
  switch (selectedResource) {
    case 'Syllabus':
      print('navigating to syllabus');

      /*Navigator.push(context,
        MaterialPageRoute(builder:(context)=>
            Syllabus()
        ),
      );*/

      await GlobalSyllabusData.loadData(selectedCourse);
      launchURLWithoutCheck(GlobalSyllabusData.syllabusURL);

      break;

    case 'Past Papers' :
      print('navigating to past papers');

      await GlobalPastPaperData.loadData(selectedCourse);

      Navigator.push(context,
        MaterialPageRoute(builder:(context)=>
            PastPapersStudentsView()
        ),
      );

      break;

    case 'Worksheets' :
      print('navigating to worksheets');

      await GlobalWorksheetData.loadData(selectedCourse);

      Navigator.push(context,
        MaterialPageRoute(builder:(context)=>
            WorksheetStudentsView()
        ),
      );

      break;

    case 'Video Lectures' :
      print('navigating to video lectures');

      Navigator.push(context,
        MaterialPageRoute(builder:(context)=>
            VideoLecturesStudentsView()
        ),
      );

      break;

    case 'Quizzes' :
      print('navigating to quizzes');

      await GlobalQuizData.loadData(selectedCourse);

      Navigator.push(context,
        MaterialPageRoute(builder:(context)=>
            QuizStudentsView()
        ),
      );

      break;

    default:
      print('error: no valid resource selected');
      break;
  }
}

Future navigateBack(context) async {
  Navigator.pop(context);
}

Future navigateToStartPage(context) async {

  // get currently logged in user
  final AuthService _auth = AuthService();
  User user = _auth.currentUser;
  GoogleSignIn googleSignIn = _auth.googleSignIn;

  // google sign in or email sign in?
  String loginType = user.providerData[0].providerId;

  // email sign out
  if (loginType == 'password') {
    print('signing out with email');
    _auth.signOut();
  }

  // google sign out
  else if (loginType == 'google.com') {
    print('signing out with google');
    googleSignIn.signOut();
  }

  // go back to first screen
  Navigator.popUntil(context, ModalRoute.withName('/'));

}