import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:share_cost_app/models/balance_model.dart';

class BalanceChart extends StatelessWidget {
  const BalanceChart({Key? key, required this.membersBalance})
      : super(key: key);

  final List<Balance> membersBalance;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Balance, String>> data = [
      charts.Series(
          id: "Balance Chart",
          data: membersBalance,
          domainFn: (Balance data, _) => data.name,
          measureFn: (Balance data, _) => data.amount,
          colorFn: (Balance data, _) => data.barColor,
          labelAccessorFn: (Balance data, _) => '${data.name} | ${data.amount}')
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
