import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:excel/excel.dart';


class SubjectAddPage extends StatefulWidget{
  SubjectAddPage({super.key});

  @override
  State<StatefulWidget> createState() => SubjectAddPageState();
}
class SubjectAddPageState extends State<SubjectAddPage>{
  late String subjectTitle;
  String fileName = "";
  int length = 0;
  final subjectNameController = TextEditingController();
  final subjectTestAmountPerDay = TextEditingController();
  final subjectPerTestRepeatDay = TextEditingController();

  //입력 필드 공백 불허
  naviatorPopTestAddPage(BuildContext context) async{
    if(subjectNameController.text == ""){

    } else if(subjectTestAmountPerDay.text == ""){

    } else if(subjectPerTestRepeatDay.text == ""){

    }else{

    }
  }

  @override
  void initState(){
    super.initState();
    subjectTestAmountPerDay.text = "30";
    subjectPerTestRepeatDay.text = "3";
  }
  @override
  void dispose(){
    subjectNameController.dispose();
    subjectTestAmountPerDay.dispose();
    subjectPerTestRepeatDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double realWidth = window.physicalSize.width;
    double realHeight = window.physicalSize.height;

    var childButtons = List<UnicornButton>.empty(growable: true);

    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: "확인",
      currentButton: FloatingActionButton(
        heroTag: "SubmitNewSubject",
        backgroundColor: Colors.redAccent,
        mini: true,
        child: const Icon(Icons.train),
        onPressed: () {
          var list = [(subjectNameController.text),(subjectTestAmountPerDay.text),(subjectPerTestRepeatDay.text),"$length","$length"];
          //문제 파일을 읽고 총 몇개의 줄로 이루어져있는지 알아야한다.
          Navigator.pop(context,list);
        },
      ),));
    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: "취소",
      currentButton: FloatingActionButton(
          heroTag: "CancelAddSubject",
          backgroundColor: Colors.greenAccent,
          mini: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.airplanemode_active)),));

    return Scaffold(
      appBar : AppBar(),
      body: Container(
        width: realWidth,
        height: realHeight,
          child:ListView(
            children: <Widget>[
              //프로젝트 명 입력
              Container(
                width: realWidth,
                margin : EdgeInsets.fromLTRB(15, 20, 15, 20),
                padding : EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border : Border.all(
                    width: 1,
                    color: Colors.blueAccent,
                  ),
                ),
                child: Row(
                  children: [
                    Text("테스트 제목 : "),
                    Container(
                      width: realWidth*0.3,
                      child: TextField(
                        decoration: InputDecoration(labelText: "프로젝트 명", border : OutlineInputBorder()),
                        controller: subjectNameController,
                      ),
                    ),
                  ]
                ),
              ),
              //하루 학습량 + 복습일차
              Container(
                width: realWidth,
                margin : EdgeInsets.fromLTRB(15, 20, 15, 20),
                padding : EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border : Border.all(
                    width: 1,
                    color: Colors.blueAccent,
                  ),
                ),
                child: Row(
                    children: [
                      Text("하루 학습량 : "),
                      Container(
                        width: realWidth*0.12,
                        padding: const EdgeInsets.only(right: 20),
                        child: TextField(
                          decoration: InputDecoration(labelText: "단어 개수", border : OutlineInputBorder()),
                          controller: subjectTestAmountPerDay,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                        ),
                      ),
                      Text("복습 횟수: "),
                      SizedBox(
                        width: realWidth*0.05,
                        child: TextField(
                          decoration: InputDecoration(labelText: "3", border : OutlineInputBorder()),
                          controller: subjectPerTestRepeatDay,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                        ),
                      ),
                    ]
                ),
              ),
              //파일선택?
              Container(
                width: realWidth,
                margin : EdgeInsets.fromLTRB(15, 20, 15, 20),
                padding : EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border : Border.all(
                    width: 1,
                    color: Colors.blueAccent,
                  ),
                ),
                child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles(
                              type:FileType.custom,
                              allowedExtensions: ['xlsx'], //excel 파일 한정 todo - txt 파일도 가능하게?
                              allowMultiple: false,
                            );
                            if (result != null && result.files.isNotEmpty) {
                              setState((){
                                fileName = result.files.single.name;
                                var fileBytes = result.files.single.bytes!;
                                var excel = Excel.decodeBytes(fileBytes);
                                for(var table in excel.tables.keys){
                                  length = excel.tables[table]!.maxRows;
                                }
                                //filePath = result.files.single.path;
                              });
                            }else{
                              length = 0;
                              if(result == null){
                                fileName = "파일없음";
                              }
                              //file picker cancel
                            }
                          },
                          child: const Text('파일 선택')),
                      Expanded(
                        //child:Text(filePath,), -> web에서는 파일 경로는 무조건 null
                        child : Text(fileName,style: const TextStyle(color: Colors.purple,fontSize: 20),),
                      ),
                    ]
                ),
              ),
            ],
          )
        ),
      floatingActionButton : UnicornDialer(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
          parentButtonBackground: Colors.redAccent,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: childButtons
      ),
      );
  }

}