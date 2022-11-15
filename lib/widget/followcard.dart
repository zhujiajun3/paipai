import 'package:flutter/material.dart';
import 'package:fluttertest/icon/camera.dart';



class followcard extends StatefulWidget {
  @override
  _followcardState createState() => _followcardState();
}


class _followcardState extends State<followcard> {
  int _counter = 0;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('../../images/head.png'),
        title: Text('老六'),
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Myicon.camera)),
          IconButton(onPressed: (){

          }, icon: Icon(Myicon.camera))
        ],
      ),
      body: Expanded(
        child:
        Image.asset('../../images/head.png'),

      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[

            Text("一小时前"),
            IconButton(onPressed: (){},
              icon: Icon(Icons.home),
            ),
            IconButton(onPressed: (){},
              icon: Icon(Icons.people),
            )
          ],
        ),
      ),

    );
  }


}
