import 'package:quiz_app/question.dart';

class QuizBrain{
  int questionNo=0;

  List<Question> questionBank=[
    Question('The Padding widget adds space around its child widget.',true),
    Question('The Center widget aligns its child widget to the top-left corner of the screen.',false),
    Question('The Row widget arranges its children vertically.',false),
    Question('The Flexible widget allows its child to fill the available space in a Row or Column.',true),
    Question('The GridView widget arranges its children in a single horizontal line.',false),
    Question('The AnimatedContainer widget allows you to animate changes in its properties.',true),
    Question('The MaterialApp widget is used to apply material design themes to an entire app.',true),
    Question('The Text widget in Flutter can only display static text.',false),
    Question('The AppBar widget is used to create a navigation drawer in a Flutter app.',false),
    Question('The Drawer widget is used to display a full-screen overlay when tapped.',false),
    Question('The Form widget is used to group multiple TextFormField widgets and manage their validation.',true),
    Question('The ListView widget can be used to create both vertical and horizontal scrolling lists.',true),
    Question('The Text widget in Flutter can display only single-line text.',false),
    Question('The FutureBuilder widget allows you to build widgets based on the result of a Future.',true),
    Question('The ScrollView widget is used to make a widget scrollable in both horizontal and vertical directions.',false),
    Question('The InkWell widget provides a visual reaction when a user taps on a widget, such as a ripple effect.',true),
  ];
  void nextQfunc()
  {
    if(questionNo<questionBank.length-1)
      {
        questionNo++;
      }
  }
  String getQuestext()
  {
    return questionBank[questionNo].QText;
  }
  bool getCorrectAns()
  {
    return questionBank[questionNo].QAns;
  }
  bool isFinished()
  {
    if( questionNo>=questionBank.length-1)
      {
        return true;
      }
    else{
      return false;
    }
  }
  void reset()
  {
    questionNo=0;
  }
  int getTotalQuestions() {
    return questionBank.length;
  }
}