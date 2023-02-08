import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';


class TestAddPage extends StatefulWidget{
  TestAddPage({super.key, required this.subjectTitle});

  final String subjectTitle;

  @override
  State<StatefulWidget> createState() => TestAddPageState();


}
class TestAddPageState extends State<TestAddPage>{
  late String subjectTitle;
  late Uint8List fileBytes;
  String filePath = "";
  String fileName = "";
  final subjectNameController = TextEditingController();
  final subjectTestAmountPerDay = TextEditingController();
  final subjectPerTestRepeatDay = TextEditingController();

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
    subjectTitle = widget.subjectTitle;
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
          Navigator.pop(context,)
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
                    Expanded(
                        child:TextField(
                          decoration: InputDecoration(labelText: "프로젝트 명"),
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
                      TextField(
                        decoration: InputDecoration(labelText: "단어 개수"),
                        maxLength: 10,
                        controller: subjectTestAmountPerDay,
                      ),
                      Text("복습 횟수: "),
                      Expanded(
                        child:TextField(
                          decoration: InputDecoration(labelText: "3"),
                          controller: subjectPerTestRepeatDay,
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
                              allowedExtensions: ['txt'],
                            );
                            if (result != null && result.files.isNotEmpty) {
                              setState((){
                                fileBytes = result.files.single.bytes!;
                                fileName = result.files.single.name;
                                //filePath = result.files.single.path;
                              });
                            }else{
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