
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/ProjectSelection.dart';

class TestPage extends StatefulWidget{
  final String testTitle;
  final int problemLength = 50;
  const TestPage({Key? key, required this.testTitle}) : super(key : key);

  @override
  State<StatefulWidget> createState() => TestPageState();
}
class TestPageState extends State<TestPage>{

  int solvingCnt = 0;
  int idx = 0;
  bool firstOptionVisibility = false;
  bool secondOptionVisibility = false;
  List<int> repeatIndex = List<int>.empty(growable: true);

  int allProblemNum = 3;
  List<List<String>> problemData = [["apple","애플","사과"],
  ["banana","바나나","바나나"],["tomato","토마토","토마토"]];

  // 각 과목에 대한 모든 설정은 '과목명.txt'파일의 첫번째줄에 무조건 저장한다.
  // 옵션명 -> 문제길이 회독수 등등
  // Future<List> makeProblemData(int problemLength) async {
  //   var li = List.empty(growable: true);
  //   for(int i = 0; i < problemLength; i++){
  //     li.add(i);
  //   }
  //   return li;
  // }

  @override
  Widget build(BuildContext context){
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
                            child: Text('1번옵션',style : TextStyle(fontSize: 15))),
                        OutlinedButton(
                            onPressed: secondOptionVisibleChange,
                            style:ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(30)),
                            ),
                            child: Text('2번옵션',style : TextStyle(fontSize: 15))),
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
                            child: Text('모르겠음',style : TextStyle(fontSize: 15))),
                        OutlinedButton(
                            onPressed: PassState,
                            style:ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(30)),
                            ),
                            child: Text('통과  ',style : TextStyle(fontSize: 15))),
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