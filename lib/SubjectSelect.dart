import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Test.dart';
import 'package:myapp/SubjectAdd.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unicorndial/unicorndial.dart';
import 'dart:ui';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;


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
      home: const SubjectSelectPage(),
    );
  }
}
//subject.excel 예시
//8(subject 개수)
//jlpt1급     30(하루 학습량)     3(복습획수)     1000(총문제량)
//jlpt2급     30(하루 학습량)     3(복습획수)     1000(총문제량)
//jlpt3급     30(하루 학습량)     3(복습획수)     1000(총문제량)
//jlpt4급     30(하루 학습량)     3(복습획수)     1000(총문제량)


class SubjectSelectPage extends StatefulWidget {
  const SubjectSelectPage({Key? key}) : super(key: key);

  @override
  SubjectSelectPageState createState() => SubjectSelectPageState();
}

class SubjectSelectPageState extends State<SubjectSelectPage>  {
  late int _counter = 0;
  late List<List<String>> contents = List<List<String>>.empty(growable: true);

  @override
  void initState(){
    super.initState();
    _initExcelData();
  }
  //flutter to read xlsx file in asset folder
  void _initExcelData() async {
    ByteData data = await rootBundle.load("assets/Subject.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      _counter = excel.tables[table]!.maxRows;
      for (var row in excel.tables[table]!.rows) { //엑셀파일을 한줄씩 읽어서
        List<String> subjectInfoData2StringList = List<String>.empty(growable: true);
        for(var cell in row){
          subjectInfoData2StringList.add(cell.toString());
        }
        contents.add(subjectInfoData2StringList);
      }
    }
  }
  //subject 추가에 따라 excel 파일 업데이트
  void updataExcelData(List<String> list) async {
    ByteData data = await rootBundle.load("assets/subject.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var defaultSheet = excel.getDefaultSheet();
    Sheet sheetObject = excel['$defaultSheet'];
    sheetObject.appendRow(list);
  }
  //SubjectSelection page는 SubjectAdd page가 pop 되는것을 기다린다.
  _navigationSubjectAdd(BuildContext context) async{
    final result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) =>SubjectAddPage()),
    );
    if(result != null){
      setState(() {
        contents.add(result);
        _counter++;
      });
      updataExcelData(result);
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
          _navigationSubjectAdd(context);
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
        title: Text("과목 선택"),
      ),
      body: Container(
        width: realWidth,
        height: realHeight,
        color: Colors.white70,
        margin: EdgeInsets.all(10),
        child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount : _counter,
                      itemBuilder: (BuildContext context, int index){
                        List<String> contentsLine = contents[index]; //subject.xlsx의 row당 데이터 리스트
                        String subjectName = contentsLine[0]; //과목명
                        int todayQueAmount = int.parse(contentsLine[1]); //한번 학습때 새롭게 배울 문제 량
                        int reviewQueAmount = int.parse(contentsLine[2]); //오늘 학습한 내용을 며칠동안 반복할것인가 -> todo sm2알고리즘을 이용해 학습자의 체감 난이도 별로의 복습 횟수를 결정
                        int remainQueAmount =int.parse(contentsLine[3]);
                        int allQueAmount = int.parse(contentsLine[4]); //총 문제량
                        return ListViewSubjectWidget(index+1,
                          subjectName: subjectName,todayQueAmount: todayQueAmount, reviewQueAmount: reviewQueAmount,remainQueAmount: remainQueAmount, allQueAmount : allQueAmount,);
                      },
                    );
                  }
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
    super.key, required this.subjectName, required this.todayQueAmount, required this.reviewQueAmount, required this.remainQueAmount, required this.allQueAmount});

  final int counter;
  final String subjectName; //과목명
  final int todayQueAmount; //하루에 테스트할 개수
  final int reviewQueAmount; //오늘 학습한 내용을 며칠동안 복습할것인가
  final int remainQueAmount; //남은 문제 개수
  final int allQueAmount; //현재 과목에 저장된 총 문제 개수

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color : Colors.white38,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Material(
        color:Colors.transparent,
        child : InkWell(
            onTap: (){
              int queAmount = todayQueAmount > remainQueAmount ? remainQueAmount : todayQueAmount;
              Navigator.push(context, MaterialPageRoute(builder: (context) =>TestPage(testTitle: counter.toString(), queAmount: queAmount,)));
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
                  child: Row(
                    children: [
                      Text('$todayQueAmount / ',
                          style : const TextStyle(fontSize: 15, color: Colors.redAccent),
                          textAlign : TextAlign.start, ),
                      Text('$remainQueAmount / ',
                          style : const TextStyle(fontSize: 15, color : Colors.greenAccent),
                          textAlign : TextAlign.start),
                      Text('$allQueAmount',
                          style : const TextStyle(fontSize: 15, color:  Colors.blue,),
                          textAlign : TextAlign.start),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
