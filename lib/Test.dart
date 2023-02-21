import 'package:flutter/material.dart';
import 'package:myapp/SubjectSelect.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:excel/excel.dart';

class TestPage extends StatefulWidget{
  final String testTitle;
  final int queAmount;
  const TestPage({Key? key, required this.testTitle, required this.queAmount}) : super(key : key);

  @override
  State<StatefulWidget> createState() => TestPageState();
}
class TestPageState extends State<TestPage>{

  int solvingCnt = 0;
  int idx = 0;
  bool firstOptionVisibility = false;
  bool secondOptionVisibility = false;
  List<int> repeatIndex = List<int>.empty(growable: true);
  List<List<String>> problemData = List<List<String>>.empty(growable: true);

  @override
  void initState(){
    super.initState();
    _initExcelData();
  }
  //웹에서는 작동안함
  //모바일에서는 과목 생성시 과목명과 같은 xlsx 파일을 생성
  //그 파일을 읽고 테스트 데이터를 생성한다.
  void _initExcelData() async {
    final testTitle = widget.testTitle;
    debugPrint(testTitle);
    ByteData data = await rootBundle.load("assets/$testTitle.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) { //엑셀파일을 한줄씩 읽어서
        List<String> testData2StringList = List<String>.empty(growable: true);
        for(int i = 0; i < 5; i++){
          final value = row[i]?.value.toString();
          debugPrint(value);
          testData2StringList.add(value!);
        }
        // for(var cell in row){
        //   subjectInfoData2StringList.add(cell..toString());
        //   debugPrint(cell?.value);
        // }
        problemData.add(testData2StringList);
      }
    }
  }

  @override
  Widget build(BuildContext context){
    String allProblemNumString = widget.queAmount.toString();
    int allProblemNum = int.parse(allProblemNumString);

    void PassState(){
      setState(() {
        //이전페이지로 시간, 등을 전달
        solvingCnt++;
        if(solvingCnt == allProblemNum){
          Navigator.pop(context,);
        }
        firstOptionVisibility = false;
        secondOptionVisibility = false;
        if(idx >= allProblemNum-solvingCnt){
          idx = 0;
          problemData.shuffle();
        }else{
          problemData.removeAt(idx);
          idx++;
        }
      });
    }
    void RepeatState(int index){
      setState(() {
        repeatIndex.add(index);
        idx++;
        firstOptionVisibility = false;
        secondOptionVisibility = false;
        if(idx >= allProblemNum-solvingCnt){
          idx = 0;
          problemData.shuffle();
        }
      });
    }
    void firstOptionVisibleChange(){
      setState(() {
        if(firstOptionVisibility) {
          firstOptionVisibility = false;
        }
        else{
          firstOptionVisibility = true;
        }
      });
    }
    void secondOptionVisibleChange(){
      setState(() {
        if(secondOptionVisibility){
          secondOptionVisibility = false;
        }else{
          secondOptionVisibility = true;
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        title : Text(widget.testTitle)
      ),
      body: Container(
        child: Column(
          children: <Widget> [
            Center(
                child: Text('$solvingCnt/$allProblemNum')
            ),
            const Center(
              child: Text('14분 30초'),
            ),
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: firstOptionVisibility  ,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 3),
                child: Text(problemData[idx][1],style : TextStyle(fontSize: 25)),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
              child: Text(problemData[idx][0],style: TextStyle(fontSize: 55),),
            ),
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible : secondOptionVisibility,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                margin: EdgeInsets.all(15),
                child : Text(problemData[idx][2],style: TextStyle(fontSize: 35),),
              ),
            ),
            Container(
              color: Colors.amberAccent,
              margin: EdgeInsets.only(bottom:10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                            onPressed: firstOptionVisibleChange,
                            style:ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(30)),
                            ),
                            child: const Text('1번옵션',style : TextStyle(fontSize: 15))),
                        OutlinedButton(
                            onPressed: secondOptionVisibleChange,
                            style:ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(30)),
                            ),
                            child: const Text('2번옵션',style : TextStyle(fontSize: 15))),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                            onPressed: (){RepeatState(idx);},
                            style:ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(30)),
                            ),
                            child: const Text('모르겠음',style : TextStyle(fontSize: 15))),
                        OutlinedButton(
                            onPressed: PassState,
                            style:ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(30)),
                            ),
                            child: const Text('통과  ',style : TextStyle(fontSize: 15))),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}