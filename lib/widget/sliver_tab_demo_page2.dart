import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 高级版 Sliver Tab
class SliverTabDemoPage2 extends StatefulWidget {
  @override
  _SliverTabDemoPageState createState() => _SliverTabDemoPageState();
}

class _SliverTabDemoPageState extends State<SliverTabDemoPage2>
    with TickerProviderStateMixin {
  TabController? tabController;

  final PageController pageController = new PageController();
  final ScrollController scrollController = new ScrollController();
  final int tabLength = 4;
  final double maxHeight = kToolbarHeight;
  final double minHeight = 30;
  final double tabIconSize = 30;
  final List<List> dataList = [
    List.filled(30, null),
    List.filled(2, null),
    List.filled(8, null),
    List.filled(8, null),
  ];

  final List labelList = [
    '推荐','日常','测评','约单'
  ];
  List<Widget> renderTabs(double shrinkOffset) {
    double offset = (shrinkOffset > tabIconSize) ? tabIconSize : shrinkOffset;
    return List.generate(tabLength, (index) {
      return Column(
        children: <Widget>[
           Expanded(
            child:  Center(
              child:  Text(
                labelList[index],
              ),
            ),
          )
        ],
      );
    });
  }

  renderListByIndex(tabIndex, pageList) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            key: PageStorageKey<String>(tabIndex.toString()),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(0.0),
                sliver: SliverFixedExtentList(
                  itemExtent: 200.0, //item高度或宽度，取决于滑动方向
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Row(
                          children:<Widget>[ Container(
                            height: 150,
                            width: 150,
                            margin:EdgeInsets.all(22),
                            color:Colors.tealAccent,
                            alignment: Alignment.center,
                            child:  Expanded(
                                child:Column(children:[Expanded(
                                  child: Text('item$index'),
                                )])),
                          ),

                            Container(
                                height: 150,
                                width: 150,
                                margin:EdgeInsets.all(22),
                                color:Colors.tealAccent,
                                alignment: Alignment.center,
                                child: Column(children:[Expanded(
                                  child: Text('item$index'),
                                )])
                            ),]
                      );
                    },
                    childCount: pageList.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> renderPages() {
    return List.generate(dataList.length, (index) {
      return renderListByIndex(index, dataList[index]);
    });
  }

  @override
  void initState() {
    tabController = new TabController(length: tabLength, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: GSYSliverHeaderDelegate(
                    maxHeight: maxHeight,
                    minHeight: minHeight,
                    changeSize: true,
                    vSync: this,
                    snapConfig: FloatingHeaderSnapConfiguration(
                      curve: Curves.bounceInOut,
                      duration: const Duration(milliseconds: 10),
                    ),
                    builder: (BuildContext context, double shrinkOffset,
                        bool overlapsContent) {
                      return Container(
                        height: maxHeight,
                        color: Colors.white,
                        child: TabBar(
                          controller: tabController,
                          indicatorColor: Color.fromARGB(100, 24, 24, 24),
                          unselectedLabelColor: Colors.white.withAlpha(100),
                          labelColor: Color.fromARGB(100, 24, 24, 24),
                          tabs: renderTabs(shrinkOffset),
                          onTap: (index) {
                            setState(() {});
                            scrollController.animateTo(0,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.fastOutSlowIn);
                            pageController.jumpToPage(index);
                          },
                        ),
                      );
                    }),
              ),
            )
          ];
        },
        body: PageView(
          onPageChanged: (index) {
            tabController!.animateTo(index);
          },
          controller: pageController,
          children: renderPages(),
        ),
      ),
    );
  }
}

///动态头部处理
class GSYSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  GSYSliverHeaderDelegate(
      {required this.minHeight,
      required this.maxHeight,
      required this.snapConfig,
      this.child,
      this.builder,
      this.vSync,
      this.changeSize = false});

  final double minHeight;
  final double maxHeight;
  final Widget? child;
  final BuilderDelegate? builder;
  final bool changeSize;
  final TickerProvider? vSync;
  final FloatingHeaderSnapConfiguration snapConfig;
  AnimationController? animationController;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (builder != null) {
      return builder!(context, shrinkOffset, overlapsContent);
    }
    return child!;
  }

  @override
  TickerProvider? get vsync => vSync;

  @override
  bool shouldRebuild(GSYSliverHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => snapConfig;
}

typedef Widget BuilderDelegate(
    BuildContext context, double shrinkOffset, bool overlapsContent);
