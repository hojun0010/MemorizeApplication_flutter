
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget{
  final String testTitle;
  final int problemLength = 50;
  const TestPage({Key? key, required this.testTitle}) : super(key : key);

  @override
  State<StatefulWidget> createState() => TestPageState();
}
class TestPageState extends State<TestPage>{
  int allProblemCnt = 0;
  int solvingCnt = 0;
  List<int> repeatIndex = List<int>.empty(growable: true);
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
        solvingCnt++;
      });
    }
    void RepeatState(int index){
      setState(() {
        repeatIndex.add(index);
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
                child: Text('$solvingCnt/$allProblemCnt')
            ),
            const Center(
              child: Text('14분 30초'),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 3),
              child: Text("1번 옵션",style : TextStyle(fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
              child: Text("문제",style: TextStyle(fontSize: 35),),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
              child : Text("2번 옵션",style: TextStyle(fontSize: 20),),
            ),
            Expanded(
              child: Container(
                color: Colors.amberAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                            onPressed: (){},
                            style: ButtonStyle()

                            child: Text('1번옵션',style : TextStyle(fontSize: 15))),
                        OutlinedButton(
                            onPressed: (){},
                            child: Text('모르겠음',style : TextStyle(fontSize: 15))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                            onPressed: (){},
                            child: Text('2번옵션',style : TextStyle(fontSize: 15))),
                        OutlinedButton(
                            onPressed: (){},
                            child: Text('통과',style : TextStyle(fontSize: 15))),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}