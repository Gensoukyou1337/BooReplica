import 'dart:developer';
import 'dart:math';

import 'package:flexbox_layout/flexbox_layout.dart';
import 'package:flutter/material.dart';
import 'profile.dart';

class _ProfileWidgetState extends State<ProfileWidget> with SingleTickerProviderStateMixin {
  List<Tab> profileTabs = [
    Tab(text: "Profile",),
    Tab(text: "Posts",),
    Tab(text: "Comments",),
  ];
  List<Widget> profileTabContents = [];

  late TabController _tabController;

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
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            width: double.infinity,
            height: 16
          ),
          AspectRatio(
            aspectRatio: 9/12,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: BoxBorder.all(color: Colors.grey, width: 1),
                boxShadow: [BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(1, 1)
                )],
                borderRadius: BorderRadius.all(Radius.circular(16))
              ),
              child: Column(
                children: [
                  Align(
                    alignment: .centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: (widget.profileObject?.profileTags ?? []).map((element) {
                        return Text(element) as Widget;
                      }).toList(),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.profileObject?.name ?? ""),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.profileObject?.location ?? ""),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: (widget.profileObject?.personalityTags ?? []).map((element) {
                        return Text(element) as Widget;
                      }).toList()
                    ),
                  )
                ],
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
          FilledButton(onPressed: widget.onShareClicked, child: Text("Share Profile")),
          TextButton(onPressed: widget.onReportClicked, child: Text("Report")),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  final VoidCallback? onShareClicked;
  final VoidCallback? onReportClicked;
  final Profile? profileObject;

  const ProfileWidget({super.key, this.onShareClicked, this.onReportClicked, this.profileObject});

  @override
  State<StatefulWidget> createState() => _ProfileWidgetState();
}

class ProfileDetailsWidget extends StatelessWidget {
  final ProfileDetails? profileDetails;
  final List<Widget> _photosAndPrompts = [];

  ProfileDetailsWidget({super.key, this.profileDetails}) {
    List<String> photoUrlsSnapshot = profileDetails?.photoUrls ?? [];
    List<String> promptsSnapshot = profileDetails?.prompts ?? [];
    int maximumIndex = max(profileDetails?.photoUrls?.length ?? 0, profileDetails?.prompts?.length ?? 0);
    
    for (var i = 0; i < maximumIndex; i++) {
      if (i < photoUrlsSnapshot.length) {
        _photosAndPrompts.add(
          AspectRatio(
            aspectRatio: 9/12,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: BoxBorder.all(color: Colors.grey, width: 1),
                boxShadow: [BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(1, 1)
                )],
                borderRadius: BorderRadius.all(Radius.circular(16))
              ),
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
            decoration: BoxDecoration(
              color: Colors.white,
              border: BoxBorder.all(color: Colors.grey, width: 1),
              boxShadow: [BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(1, 1)
              )],
              borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: Column(
              children: [
                Text(promptsSnapshot[i])
              ],
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
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: BoxBorder.all(color: Colors.grey, width: 1),
            boxShadow: [BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(1, 1)
            )],
            borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Looking for ${profileDetails?.lookingFor ?? "Friends"}"),
              Text(profileDetails?.profileSummary ?? ""),
              Flexbox(
                flexDirection: .row,
                flexWrap: .wrap,
                justifyContent: .flexStart,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: (profileDetails?.maritalStatusTags ?? []).map( (text) => Text(text) ).toList()
              ),
            ]
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 16
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: BoxBorder.all(color: Colors.grey, width: 1),
            boxShadow: [BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(1, 1)
            )],
            borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          child: Column(
            children:[
              Text("Interests"),
              Flexbox(
                flexDirection: .row,
                flexWrap: .wrap,
                justifyContent: .flexStart,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: (profileDetails?.interestsTags ?? []).map( (text) => Text(text) ).toList()
              ),
            ]
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 16
        ),
        ..._photosAndPrompts,
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: BoxBorder.all(color: Colors.grey, width: 1),
            boxShadow: [BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(1, 1)
            )],
            borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          height: 64,
        ),
      ],
    );
  }
}

class PostsWidget extends StatelessWidget {
  const PostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, height: 240, decoration: BoxDecoration(color: Colors.red));
  }
}

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, height: 160, decoration: BoxDecoration(color: Colors.green));
  }
}
