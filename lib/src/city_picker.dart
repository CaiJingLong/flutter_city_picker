import 'dart:async';

import 'package:city_picker/src/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'datas.dart';

Future<CityResult> showCityPicker(BuildContext context) async {
  Completer<CityResult> completer = Completer();
  var cityData = await loadCityData();

  var cityResult;

  var result = showBottomSheet(
    context: context,
    builder: (c) => CityPicker(
          params: cityData,
          forResult: (v) {
            cityResult = v;
          },
        ),
  );

  result.closed.then((v) {
    completer.complete(cityResult);
  });

  return completer.future;
}

class CityPicker extends StatefulWidget {
  final Map<String, dynamic> params;
  final ValueSetter<CityResult> forResult;

  const CityPicker({
    Key key,
    this.params,
    this.forResult,
  }) : super(key: key);

  @override
  _CityPickerState createState() => _CityPickerState();
}

class _CityPickerState extends State<CityPicker> {
  String province;

  Map<String, dynamic> get datas => widget.params;
  List<Map<String, dynamic>> get proviceList => datas["provinceList"];

  @override
  void initState() {
    super.initState();
    province = provinceByIndex(0);
  }

  String provinceByIndex(int index) {
    return proviceList[index]["name"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoPicker.builder(
        itemExtent: 50,
        onSelectedItemChanged: (int value) {},
        itemBuilder: _buildItem,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    var name = proviceList[index]["name"];
    return Text(name);
  }
}
