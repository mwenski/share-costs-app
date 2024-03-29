import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

import 'package:share_cost_app/models/balance_model.dart';
import 'package:share_cost_app/models/user_model.dart';

class BalanceChart extends StatelessWidget {
  const BalanceChart({Key? key,
                      required this.membersBalance,
                      required this.members})
                      : super(key: key);

  final List<Balance> membersBalance;
  final List<User> members;

  @override
  Widget build(BuildContext context) {
    String getName(String id){
      String name = members.firstWhere((element) => element.id == id, orElse: () => User(name: "N.N.")).name;
      return name;
    }

    List<charts.Series<Balance, String>> data = [
      charts.Series(
          id: "Balance Chart",
          data: membersBalance,
          domainFn: (Balance data, _) => getName(data.name),
          measureFn: (Balance data, _) => data.amount,
          colorFn: (Balance data, _) => data.amount<0 ? charts.ColorUtil.fromDartColor(Colors.red) : charts.ColorUtil.fromDartColor(Colors.green),
          labelAccessorFn: (Balance data, _) => '${getName(data.name)} | ${data.amount.toStringAsFixed(2).replaceAll(".",",")}')
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Flexible(
                  child: charts.BarChart(
                data,
                animate: true,
                vertical: false,
                barRendererDecorator: new charts.BarLabelDecorator<String>(),
                domainAxis: new charts.OrdinalAxisSpec(
                    renderSpec: new charts.NoneRenderSpec()),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
