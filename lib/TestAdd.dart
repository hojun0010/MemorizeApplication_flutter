import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestAddPage extends StatelessWidget{
  const TestAddPage({super.key, required this.subjectTitle});

  final String subjectTitle;


  @override
  Widget build(BuildContext context){
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double realWidth = window.physicalSize.width;
    double realHeight = window.physicalSize.height;

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
                      Text("테스트 제목 : "),
                      Expanded(
                        child:TextField(
                          decoration: InputDecoration(labelText: "프로젝트 명"),
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
                      Text("테스트 제목 : "),
                      Expanded(
                        child:TextField(
                          decoration: InputDecoration(labelText: "프로젝트 명"),
                        ),
                      ),
                    ]
                ),
              ),
            ],
          )
        ),
      );
  }

}