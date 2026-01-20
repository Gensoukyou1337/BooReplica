import 'package:boo_replica/bottom_bar.dart';
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

class _MyHomePageState extends State<MyHomePage> {
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

  List<ProfileWidget> profileCards = [
    ProfileWidget(profileObject: getMockProfile()),
    ProfileWidget(profileObject: getMockProfile())
  ];

  CardSwiperController swiperController = CardSwiperController();

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
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          leading: Row(children: [Icon(Icons.menu), Icon(Icons.battery_6_bar)]),
          actions: [
            Icon(Icons.transcribe),
            Icon(Icons.menu_book)
          ],
        ),
        body: Center(
          child: CardSwiper(
            isDisabled: true,
            controller: swiperController,
            allowedSwipeDirection: AllowedSwipeDirection.symmetric(horizontal: true),
            cardsCount: 2,
            cardBuilder: (context, index, percentThresholdX, percentThresholdY) => profileCards[index],
          )
        ),
        bottomNavigationBar: BottomBar(
          onXClicked: () => {swiperController.swipe(CardSwiperDirection.left)},
          onHeartClicked: () => {swiperController.swipe(CardSwiperDirection.right)},
        ),
      )
    );
  }
}
