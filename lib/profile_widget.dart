import 'dart:developer' as dev;
import 'dart:math';

import 'package:flexbox_layout/flexbox_layout.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'components.dart';

typedef AppBarCollapsePercentageCallback = void Function(double);

BoxDecoration commonBoxDecor = BoxDecoration(
  color: Colors.white,
  border: BoxBorder.all(color: Colors.grey, width: 1),
  boxShadow: [BoxShadow(
    color: Colors.grey,
    blurRadius: 1,
    spreadRadius: 1,
    offset: Offset(0, 0)
  )],
  borderRadius: BorderRadius.all(Radius.circular(16))
);

class _ProfileWidgetState extends State<ProfileWidget> with SingleTickerProviderStateMixin {
  List<Tab> profileTabs = [
    Tab(text: "Profile",),
    Tab(text: "Posts",),
    Tab(text: "Comments",),
  ];
  List<Widget> profileTabContents = [];

  late TabController _tabController;

  final ScrollController _scrollController = ScrollController();
  var totalScrollDelta = 0.0;
  var appBarShouldCollapsePercentage = 0.0;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    profileTabContents = [
      ProfileDetailsWidget(profileDetails: widget.profileObject?.profileDetails),
      PostsWidget(),
      CommentsWidget()
    ];
    super.initState();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(Object context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context as BuildContext).colorScheme.surface),
      child: NotificationListener(
        onNotification: (t) {
          if (t is ScrollUpdateNotification) {
            totalScrollDelta += (t.scrollDelta ?? 0.0);
            appBarShouldCollapsePercentage = min(totalScrollDelta, 56.0) * 100/56.0;
            widget.onAppBarCollapsePercentageChanged?.call(appBarShouldCollapsePercentage);
          }
          return false;
        },
        child: ListView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              width: double.infinity,
              height: 16
            ),
            AspectRatio(
              aspectRatio: 9/12,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: commonBoxDecor,
                child: Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Column(
                    children: [
                      Align(
                        alignment: .centerRight,
                        child: Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: (widget.profileObject?.profileTags ?? []).map((element) {
                            return TextTag(text: element);
                          }).toList(),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.profileObject?.name ?? "", style: Theme.of(context).textTheme.titleLarge),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.profileObject?.location ?? ""),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          spacing: 8,
                          children: (widget.profileObject?.personalityTags ?? []).map((element) {
                            return TextTag(text: element);
                          }).toList()
                        ),
                      )
                    ],
                  ),
                )
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 16
            ),
            TabBar(
              controller: _tabController,
              tabs: profileTabs
            ),
            SizedBox(
              width: double.infinity,
              height: 16
            ),
            profileTabContents[_tabController.index],
            SizedBox(
              width: double.infinity,
              height: 16
            ),
            Align(alignment: .center, child: Wrap(children: [FilledButton(onPressed: widget.onShareClicked, child: Text("Share Profile"))])),
            Align(alignment: .center, child: Wrap(children: [TextButton(onPressed: widget.onReportClicked, child: Text("Report"))])),
            SizedBox(width: double.infinity, height: 56,)
          ],
        )
      ),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  final VoidCallback? onShareClicked;
  final VoidCallback? onReportClicked;
  final AppBarCollapsePercentageCallback? onAppBarCollapsePercentageChanged;
  final Profile? profileObject;

  const ProfileWidget({super.key, this.onShareClicked, this.onReportClicked, this.onAppBarCollapsePercentageChanged, this.profileObject});

  @override
  State<StatefulWidget> createState() => _ProfileWidgetState();
}

class ProfileDetailsWidget extends StatelessWidget {
  final ProfileDetails? profileDetails;
  final List<Widget> _photosAndPrompts = [];

  ProfileDetailsWidget({super.key, this.profileDetails});

  void _buildPhotosAndPrompts(BuildContext context) {
    if (_photosAndPrompts.isNotEmpty) {return;}

    List<String> photoUrlsSnapshot = profileDetails?.photoUrls ?? [];
    List<Prompt> promptsSnapshot = profileDetails?.prompts ?? [];

    int maximumIndex = max(profileDetails?.photoUrls?.length ?? 0, profileDetails?.prompts?.length ?? 0);
    for (var i = 0; i < maximumIndex; i++) {
      if (i < photoUrlsSnapshot.length) {
        _photosAndPrompts.add(
          AspectRatio(
            aspectRatio: 9/12,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: commonBoxDecor,
            ),
          )
        );
        _photosAndPrompts.add(
          SizedBox(
            width: double.infinity,
            height: 16
          )
        );
      }
      if (i < promptsSnapshot.length) {
        _photosAndPrompts.add(
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: commonBoxDecor,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(promptsSnapshot[i].title ?? "", style: Theme.of(context).textTheme.titleSmall),
                  Text(promptsSnapshot[i].content ?? "")
                ],
              ),
            )
          )
        );
        _photosAndPrompts.add(
          SizedBox(
            width: double.infinity,
            height: 16
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _buildPhotosAndPrompts(context);

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: commonBoxDecor,
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Looking for ${profileDetails?.lookingFor ?? "Friends"}", textAlign: .left),
                SizedBox(width: double.infinity, height: 8),
                Text(profileDetails?.profileSummary ?? "", textAlign: .left),
                SizedBox(width: double.infinity, height: 8),
                Flexbox(
                  flexDirection: .row,
                  flexWrap: .wrap,
                  justifyContent: .flexStart,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: (profileDetails?.maritalStatusTags ?? []).map( (text) => TextTag(text: text) ).toList()
                ),
              ]
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 16
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: commonBoxDecor,
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text("Interests", style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(width: double.infinity, height: 8),
                  Flexbox(
                    flexDirection: .row,
                    flexWrap: .wrap,
                    justifyContent: .flexStart,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: (profileDetails?.interestsTags ?? []).map( (text) => TextTag(text: "#$text") ).toList()
                  ),
                  SizedBox(width: double.infinity, height: 16),
                  Text("Languages", style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(width: double.infinity, height: 8),
                  Row(
                    children: (profileDetails?.languages ?? []).map(
                      (lang) => Text(lang, style: TextStyle(color: Colors.blueAccent))
                    ).toList()
                  )
                ]
              ),
            ),
        ),
        SizedBox(
          width: double.infinity,
          height: 16
        ),
        ..._photosAndPrompts,
        PersonalityParamsWidget(
          sixteenType: profileDetails?.sixteenType,
          cognitiveFunctions: profileDetails?.sortedCogFunctions?.join(),
          zodiac: profileDetails?.zodiac,
        ),
      ],
    );
  }
}

class PersonalityParamsWidget extends StatefulWidget {
  final String? sixteenType;
  final String? cognitiveFunctions;
  final String? zodiac;

  const PersonalityParamsWidget({super.key, this.sixteenType, this.cognitiveFunctions, this.zodiac});

  @override
  State<StatefulWidget> createState() => _PersonalityParamsWidgetState();
}

class _PersonalityParamsWidgetState extends State<PersonalityParamsWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  List<Tab> tabs = [
    Tab(text: "16 Type"),
    Tab(text: "Cognitive Functions"),
    Tab(text: "Zodiac"),
  ];

  List<Widget> pages = [];

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _pageController.animateToPage(_tabController.index, duration: Durations.short4, curve: Curves.linear);
      });
    }
  }

  void _buildPages(BuildContext context) {
    if (pages.isNotEmpty) {return;}

    pages = [
      Column(
        children: [
          Text(widget.sixteenType ?? "", style: Theme.of(context).textTheme.titleMedium),
          Text("Long text")
        ],
      ),
      Column(
        children: [
          Text(widget.cognitiveFunctions ?? "", style: Theme.of(context).textTheme.titleMedium),
          Text("Long text")
        ],
      ),
      Column(
        children: [
          Text(widget.zodiac ?? "", style: Theme.of(context).textTheme.titleMedium),
          Text("Longer text")
        ],
      )
    ];
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildPages(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: commonBoxDecor,
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            TabBar(tabs: tabs, controller: _tabController),
            SizedBox(
              width: double.infinity,
              height: 256,
              child: PageView(
                controller: _pageController,
                children: pages,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PostsWidget extends StatelessWidget {
  const PostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: 240, decoration: BoxDecoration(color: Colors.red),
      child: Center(child: Text("SECTION UNDER DEVELOPMENT"))
    );
  }
}

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: 160, decoration: BoxDecoration(color: Colors.green),
      child: Center(child: Text("SECTION UNDER DEVELOPMENT"))
    );
  }
}
