import 'package:boo_replica/components.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 56,
        width: 320,
        child: Column(
          children:[
            ClipRect(
              child: BackdropFilter(
                filter: commonBlurFilter,
                child: Row(
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
              ),
            )
          ]
        ),
      );
  }
}

