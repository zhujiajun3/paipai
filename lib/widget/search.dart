import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../icon/camera.dart';





class searchPage extends StatefulWidget {
  const searchPage({super.key, required this.title});

  final String title;

  @override
  State<searchPage> createState() => _searchPageState();
}
class Inpt extends StatelessWidget {
  const Inpt({Key? key}) : super(key: key);

  Widget creatwidge(){
    var widgetlist=
    Expanded(
      child:const TextField(
        minLines: null,
        expands: false,
        maxLines: null,
      autofocus: true,
      textAlign: TextAlign.start,

      decoration: InputDecoration(
        contentPadding:EdgeInsets.only(top: 0, bottom: 0),
        fillColor: Colors.black,
        prefixIcon: const Icon(
        Icons.search,
        color: Colors.grey),
          labelText: "search",
          hintText: "search",

      ),
    ));


    return widgetlist;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        creatwidge()
    );
  }
}
class _searchPageState extends State<searchPage> {

  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
              onPressed: () {
                Navigator.pop(context, "home");
              },
              icon: Icon(Icons.arrow_back)),
        ),
        title: Expanded(
            child: Row(
          children: const <Widget>[
            Text(
              '搜索',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.start,
              softWrap: false,
            ),

            Inpt()
          ],
        )),
        actions: [
          //右边的图标按钮
          IconButton(onPressed: () {}, icon: Icon(Myicon.camera)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        ///大小按照最小显示
        mainAxisSize: MainAxisSize.min,

        ///横向也居中
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Expanded(child: Text("")),
        ],
      ),
    );
  }


}
