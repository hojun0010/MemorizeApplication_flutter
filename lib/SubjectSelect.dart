import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Test.dart';
import 'package:myapp/TestAdd.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unicorndial/unicorndial.dart';
import 'dart:ui';
import 'dart:io';


const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Memorize Application',
      theme: ThemeData(
        // Application theme data, you can set the colors for the application as
        // you want
        primarySwatch: Colors.blue,
      ),
      home: const SubjectSelectPage(subjectTitle: '과목 선택'),
    );
  }
}
// class CounterStorage {
//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//
//     return directory.path;
//   }
//
//   Future<File> get _localFile async {
//     final path = await _localPath;
//     return File('$path/subject.txt');
//   }
//
//   Future<List<String>> readContents() async {
//     final file = await _localFile;
//
//     // Read the file
//     final contents = file.readAsLinesSync();
//
//     return contents;
//   }
//   // Future<File> writeContents(String ) async {
//   //   final file = await _localFile;
//   //
//   //   // Write the file
//   //   return file.writeAsString('$');
//   // }
// }
//subject.txt 예시
//8(subject 개수)
//jlpt1급     30(하루 학습량)     3(복습획수)     1000(총문제량)
//jlpt2급     30(하루 학습량)     3(복습획수)     1000(총문제량)
//jlpt3급     30(하루 학습량)     3(복습획수)     1000(총문제량)
//jlpt4급     30(하루 학습량)     3(복습획수)     1000(총문제량)


class SubjectSelectPage extends StatefulWidget {
  final String subjectTitle;
  const SubjectSelectPage({Key? key, required this.subjectTitle}) : super(key: key);


  @override
  SubjectSelectPageState createState() => SubjectSelectPageState();
}
class SubjectSelectPageState extends State<SubjectSelectPage>  {
  late int _counter;
  late String _subjectTitle;
  late List<String> contents = List<String>.empty(growable: true);

  @override
  void initState(){
    super.initState();
    _subjectTitle = widget.subjectTitle;
    listInitState();
  }
  void listInitState() async{
    // contents = (CounterStorage()) as List<String>;
    contents = ["2\n","jlpt4,5급     30      3     1000\n","jlpt3급     30     3     1000\n"];
    _counter = int.parse(contents[0]); //subject.txt 파일 읽어서 첫번째줄의 subject 개수를 갖고와야한다.
  }
  _navigationAddTest(BuildContext context,String subjectTitle) async{
    final result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) =>TestAddPage(subjectTitle: subjectTitle)),
    );
    if(result != null){
      setState(() {
        contents.add(result);
        _counter++;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double realWidth = window.physicalSize.width;
    double realHeight = window.physicalSize.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.



    var childButtons = List<UnicornButton>.empty(growable: true);

    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: "단어장 생성",
      currentButton: FloatingActionButton(
        heroTag: "CreateTest",
        backgroundColor: Colors.redAccent,
        mini: true,
        child: const Icon(Icons.train),
        onPressed: () {
          _navigationAddTest(context, _subjectTitle);
        },
      ),));
    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: "단어장 파일 추가",
      currentButton: FloatingActionButton(
          heroTag: "AddTestFile",
          backgroundColor: Colors.greenAccent,
          mini: true,
          onPressed: () {  },
          child: const Icon(Icons.airplanemode_active)),));

    childButtons.add(UnicornButton(
      currentButton: FloatingActionButton(
          heroTag: "directions",
          backgroundColor: Colors.blueAccent,
          mini: true,
          onPressed: () {  },
          child: Icon(Icons.directions_car)),));
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.subjectTitle),
      ),
      body: Container(
        width: realWidth,
        height: realHeight,
        color: Colors.lightGreenAccent,
        margin: EdgeInsets.all(10),
        child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount : _counter,
                  itemBuilder: (BuildContext context, int index){
                    List<String> contentsLine = contents[index+1].split("     ");
                    String subjectName = contentsLine[0];
                    String perTestAmount = contentsLine[1];
                    String repeatTestDay = contentsLine[2];
                    String allProblemAmount = contentsLine[3];
                    return ListViewSubjectWidget(index+1,
                      subjectName: subjectName,perTestAmount: perTestAmount, repeatTestDay: repeatTestDay,allProblemAmount: allProblemAmount,);
                  },
                ),
              ),
            ]
        ),
      ),
      floatingActionButton : UnicornDialer(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
          parentButtonBackground: Colors.redAccent,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: childButtons
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class ListViewSubjectWidget extends StatelessWidget{
  const ListViewSubjectWidget(this.counter, {
    super.key, required this.subjectName, required this.perTestAmount, required this.repeatTestDay, required this.allProblemAmount});

  final int counter;
  final String subjectName;
  final String perTestAmount;
  final String repeatTestDay;
  final String allProblemAmount;

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color : Colors.green,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Material(
        color:Colors.transparent,
        child : InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>TestPage(testTitle: counter.toString(),)));
            },
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            focusColor : Colors.red,
            child : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children : <Widget> [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                      children:<Widget>[
                        Text('과목명 : $subjectName',
                            style : const TextStyle(fontSize : 25),
                            textAlign: TextAlign.start),
                        Expanded(
                          child: Text('생성 라인 : $counter',
                              style : const TextStyle(fontSize : 18),
                              selectionColor: Colors.red,
                              textAlign: TextAlign.end),
                        ),
                      ]
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  margin : const EdgeInsets.only(left: 5),
                  child: Text('$perTestAmount / $repeatTestDay / $allProblemAmount ',
                      style : const TextStyle(fontSize: 10),
                      textAlign : TextAlign.start),
                ),
              ],
            )
        ),
      ),
    );
  }
}
