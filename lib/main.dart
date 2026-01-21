import 'dart:developer' as dev;

import 'package:boo_replica/bottom_bar.dart';
import 'package:boo_replica/components.dart';
import 'package:boo_replica/profile_widget.dart';
import 'package:flutter/material.dart';
import 'mock_profile.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boo Replica',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        textTheme: .new(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          bodySmall: TextStyle(fontSize: 11, fontWeight: FontWeight.normal)
        )
      ),
      home: const MyHomePage(title: 'Boo Replica'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  double appBarCollapsePercent = 0.0;

  void _setAppBarCollapsePercent(double percent) {
    setState(() {
      appBarCollapsePercent = percent;
    });
  }

  List<Widget> pages = [];
  List<ProfileWidget> profileCards = [];
  CardSwiperController swiperController = CardSwiperController();
  late PageController pageViewController;
  late TabController pageViewTopTabsController;

  void _handleTabSelection() {
    if (pageViewTopTabsController.indexIsChanging) {
      setState(() {
        pageViewController.animateToPage(pageViewTopTabsController.index, duration: Durations.short4, curve: Curves.linear);
      });
    }
  }

  @override
  void initState() {
    pageViewTopTabsController = TabController(length: 2, vsync: this);
    pageViewTopTabsController.addListener(_handleTabSelection);
    profileCards = [
      ProfileWidget(
        profileObject: getMockProfile(),
        onAppBarCollapsePercentageChanged: _setAppBarCollapsePercent,
      ),
      ProfileWidget(
        profileObject: getMockProfile(),
        onAppBarCollapsePercentageChanged: _setAppBarCollapsePercent,
      )
    ];
    pageViewController = PageController();
    pages = [
      Stack(
        alignment: .bottomCenter,
        children: [
          Center(
            child: CardSwiper(
              padding: EdgeInsetsGeometry.all(0),
              isDisabled: true,
              controller: swiperController,
              allowedSwipeDirection: AllowedSwipeDirection.symmetric(horizontal: true),
              cardsCount: 2,
              cardBuilder: (context, index, percentThresholdX, percentThresholdY) => profileCards[index],
            )
          ),
          Container(
            height: 56.0,
            alignment: .bottomCenter,
            margin: EdgeInsets.only(bottom: 56.0),
            child: Row(
              children: [
                BottomBarCircularContainer(child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.rocket, color: Colors.blueAccent),
                )),
                BottomBarCircularContainer(child: IconButton(
                  onPressed: () {swiperController.swipe(.left);},
                  icon: Icon(Icons.cancel, color: Colors.redAccent),
                )),
                BottomBarCircularContainer(child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.heart_broken, color: Colors.redAccent),
                )),
                BottomBarCircularContainer(child: IconButton(
                  onPressed: () {swiperController.swipe(.right);},
                  icon: Icon(Icons.heart_broken, color: Colors.blueAccent),
                )),
                BottomBarCircularContainer(child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                )),
              ]
            ),
          )
        ],
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Center(child: Text("SECTION UNDER DEVELOPMENT"))
      )
    ];
    super.initState();
  }

  @override
  void dispose() {
    pageViewTopTabsController.dispose();
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        /*
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 112),
          child: ClipRect(
            child: BackdropFilter(
              filter: commonBlurFilter,
              child: AppBar(
                toolbarHeight: 56.0,
                backgroundColor: Colors.orange.withAlpha(256),
                elevation: 0.0,
                centerTitle: true,
                title: Text(widget.title),
                leading: Row(children: [Icon(Icons.menu), Icon(Icons.battery_6_bar)]),
                actions: [
                  Icon(Icons.transcribe),
                  Icon(Icons.menu_book)
                ],
                flexibleSpace: Container(
                  height: 56.0 * (100.0-appBarCollapsePercent)/100.0,
                  color: Colors.orange.withAlpha(256),
                ),
              ),
            )
          )
        ),
        */
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 112),
          child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                flexibleSpace: Column (
                  children: [
                    ClipRect(
                      child: BackdropFilter(
                        filter: commonBlurFilter,
                        child: Padding(
                          padding: .symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Row(children: [Icon(Icons.menu), SizedBox(width: 16, height: 56), Icon(Icons.battery_6_bar)]),
                              Expanded(child: Text(widget.title, textAlign: .center, style: Theme.of(context).textTheme.titleLarge)),
                              Row(children: [Icon(Icons.transcribe), SizedBox(width: 16, height: 56), Icon(Icons.menu_book)]),
                            ]
                          )
                        )
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 56.0 * (100.0-appBarCollapsePercent)/100.0,
                      child: TabBar(tabs: [Tab(text: "New Soul"), Tab(text: "Discover")], controller: pageViewTopTabsController),
                    )
                  ],
                ),
              )
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageViewController,
          children: pages,
        ),
        bottomNavigationBar: BottomBar(),
      )
    );
  }
}
