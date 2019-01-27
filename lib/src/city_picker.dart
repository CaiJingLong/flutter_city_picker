import 'package:city_picker/src/result.dart';
import 'package:flutter/material.dart';

import 'datas.dart';

Future<CityResult> showCityPicker() async {
  await loadCityData();
  return null;
}

class CityPicker extends StatefulWidget {
  @override
  _CityPickerState createState() => _CityPickerState();
}

class _CityPickerState extends State<CityPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}