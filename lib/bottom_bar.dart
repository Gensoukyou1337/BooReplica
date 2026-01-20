import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback? onXClicked;
  final VoidCallback? onHeartClicked;

  const BottomBar({super.key, this.onXClicked, this.onHeartClicked});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      width: 320,
      child: Column(
        children:[
          Row(
            children: [
              Expanded(child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.rocket, color: Colors.blueAccent),
              )),
              Expanded(child: IconButton(
                onPressed: onXClicked,
                icon: Icon(Icons.cancel, color: Colors.redAccent),
              )),
              Expanded(child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.heart_broken, color: Colors.redAccent),
              )),
              Expanded(child: IconButton(
                onPressed: onHeartClicked,
                icon: Icon(Icons.heart_broken, color: Colors.blueAccent),
              )),
              Expanded(child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.send, color: Colors.blueAccent),
              )),
            ]
          ),
          Row(
            children: [
              Expanded(child: Column(
                children: [
                  Icon(Icons.heart_broken),
                  Text("Match")
                ]
              )),
              Expanded(child: Column(
                children: [
                  Icon(Icons.create),
                  Text("Create")
                ]
              )),
              Expanded(child: Column(
                children: [
                  Icon(Icons.network_cell),
                  Text("Universes")
                ]
              )),
              Expanded(child: Column(
                children: [
                  Icon(Icons.message),
                  Text("Messages")
                ]
              )),
            ]
          )
        ]
      ),
    );
  }
}