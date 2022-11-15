import 'package:flutter/material.dart';
import '../widget/followPage.dart';
import '../widget/sliver_tab_demo_page2.dart';
import '../widget/search.dart';
void main() {
  runApp(const MyApp());
}
// 全局配置


class Config {
  /// 主题颜色
  static const int _primaryColorValue = 0xFFFFFFFF;
  static const Color primaryColor = Color(_primaryColorValue);
  static const MaterialColor primarySwatchColor = MaterialColor(
    _primaryColorValue,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFA7C9ED),
      200: Color(0xFF7EB0E4),
      300: Color(0xFF5999DB),
      400: Color(0xFF3683D2),
      500: Color(_primaryColorValue),
      600: Color(0xFF1258A1),
      700: Color(0xFF0d4279),
      800: Color(0xFF092C50),
      900: Color(0xFF041628),
    },
  );
  /// 其他全局配置
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        "/search":(context)=>searchPage(title: 'search')
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

      primarySwatch: Config.primarySwatchColor,
      ),
      home: const MyHomePage(title: '拍拍'),

    );
  }
}


// class Inpt extends StatelessWidget {
//   const Inpt({Key? key}) : super(key: key);
//
//   Widget creatwidge(){
//     var widgetlist=
//     const TextField(
//       autofocus: true,
//       decoration: InputDecoration(
//
//           labelText: "search",
//           hintText: "search",
//           prefixIcon: Icon(Icons.person)
//       ),
//     );
//
//     return widgetlist;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child:
//       creatwidge()
//     );
//   }
// }





class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  dynamic curHomePage=SliverTabDemoPage2();

  var choice=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Text(
            '拍拍',
            style: TextStyle(
                fontFamily: 'douyu',
                fontSize: 30,
                color: Color.fromARGB(100, 135, 158, 179)),
            textAlign: TextAlign.center,
            softWrap: false,
          ),
        ),
        leadingWidth: 125,
        title: Center(
            child: Row(
          children: <Widget>[
            TextButton(
                onPressed: () {
                  setState(() {
                    curHomePage = ScrollToIndexDemoPage2();
                  });
                },
                child: const Text(
                  '关注',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromARGB(100, 100, 100, 100)),
                  textAlign: TextAlign.center,
                  softWrap: false,
                )),
            TextButton(
                onPressed: () {
                  setState(() {
                    curHomePage = SliverTabDemoPage2();
                  });
                },
                child: const Text(
                  '发现',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromARGB(100, 100, 100, 100)),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ))
          ],
        )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/search");
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        ///大小按照最小显示
        mainAxisSize: MainAxisSize.min,

        ///横向也居中
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Expanded(child: curHomePage),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '推荐',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '发布',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '消息',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '我的',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }


}
