import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestSelectionPage extends StatefulWidget{
  final String testTitle;
  const TestSelectionPage({Key? key, required this.testTitle}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _TestSelectionPageState();
}

class _TestSelectionPageState extends State<TestSelectionPage>{
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.testTitle),
        ),
        body: Container(
          color: Colors.lightGreenAccent,
          margin: EdgeInsets.all(10),
          child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount : _counter+1,
                    itemBuilder: (BuildContext context, int index){
                      return _listViewTestWidget(index);
                    },
                  ),
                ),
                Align(
                  alignment : Alignment.bottomRight,
                  child : Container(
                    color : Colors.black12,
                    padding: EdgeInsets.all(8),
                    child: FloatingActionButton(
                      onPressed: () {
                        _incrementCounter();
                      },
                    ),
                  ),
                )
              ]
          ),
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class _listViewTestWidget extends StatelessWidget{
  const _listViewTestWidget(this.counter, {super.key});

  final int counter;

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
              // Navigator.push(context, MaterialPageRoute(builder: (context) =>TestSelectionPage(testTitle: counter.toString(),)));
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
                        Text('테스트명 : $counter',
                            style : const TextStyle(fontSize : 25),
                            textAlign: TextAlign.start),
                        Expanded(
                          child: Text('회차 : $counter',
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
                  child: const Text('프로젝트 설명 : ',
                      style : TextStyle(fontSize: 15),
                      textAlign : TextAlign.start),
                ),
              ],
            )
        ),
      ),
    );
  }
}