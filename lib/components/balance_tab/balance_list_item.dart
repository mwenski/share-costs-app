import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

import 'package:share_cost_app/style.dart';
import 'package:share_cost_app/models/user_model.dart';

class BalanceListItem extends StatelessWidget {
  const BalanceListItem(
      {super.key,
      required this.balanceElement,
      required this.members});

  final Map<String, dynamic> balanceElement;
  final List<User> members;

  @override
  Widget build(BuildContext context) {
    String getName(String id){
      User? named = members.firstWhere((element) => element.id == id);
      return named.name;
    }

    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: TextScroll(getName(balanceElement["paidFor"]),
                style: Style.headerStyle,
                intervalSpaces: 10,
                velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                pauseBetween: Duration(seconds: 1),
                ),
              ),
              const Text(" should send ",
                  style: Style.subheaderStyle),
              SizedBox(width: MediaQuery.of(context).size.width/2,),
              Text(
                balanceElement["amount"].toString(),
                style: Style.headerStyle,
              )
            ],
          ),
          Row(
            children: [
              const Text("to ",
                  style: Style.subheaderStyle),
              Flexible(
                child: TextScroll(getName(balanceElement["paidBy"]),
                  style: Style.headerStyle,
                  intervalSpaces: 10,
                  velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                  pauseBetween: Duration(seconds: 1),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
