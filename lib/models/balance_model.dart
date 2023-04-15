import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

class Balance{
  String name;
  double amount;
  charts.Color barColor;

  Balance({
    required this.name,
    required this.amount,
    charts.Color? barColor
  }): barColor = (amount < 0) ? charts.ColorUtil.fromDartColor(Colors.red) : charts.ColorUtil.fromDartColor(Colors.green);

}