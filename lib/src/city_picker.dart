import 'dart:async';

import 'package:city_picker/src/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'datas.dart';

Future<CityResult> showCityPicker(BuildContext context) async {
  Completer<CityResult> completer = Completer();
  var cityData = await loadCityData();

  var cityResult;

  var result = showDialog(
    context: context,
    builder: (c) => CityPicker(
          params: cityData,
          forResult: (v) {
            cityResult = v;
          },
        ),
  );

  result.then((v) {
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
  int provinceIndex = 0;
  int city = 0;
  int county = 0;

  var cityResult = CityResult();

  Map<String, dynamic> get datas => widget.params;
  List<dynamic> get provinceList => datas["provinceList"];
  String proviceNameByIndex(int index) => provinceList[index]["name"];

  FixedExtentScrollController provinceScrollController;
  FixedExtentScrollController cityScrollController;
  FixedExtentScrollController countyScrollController;

  @override
  void initState() {
    super.initState();
    provinceScrollController = FixedExtentScrollController();
    cityScrollController = FixedExtentScrollController();
    countyScrollController = FixedExtentScrollController();
  }

  @override
  void dispose() {
    provinceScrollController?.dispose();
    cityScrollController?.dispose();
    countyScrollController?.dispose();
    super.dispose();
  }

  String provinceByIndex(int index) {
    return provinceList[index]["name"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(child: buildProvincePicker()),
            Expanded(child: buildCityPicker()),
            // Expanded(child: buildProvincePicker()),
          ],
        ),
      ),
    );
  }

  Widget buildProvincePicker() {
    return CupertinoPicker.builder(
      itemExtent: 40,
      scrollController: provinceScrollController,
      backgroundColor: Colors.white,
      onSelectedItemChanged: onProvinceChanged,
      itemBuilder: _buildProvinceItem,
      childCount: provinceList.length,
    );
  }

  Widget _buildProvinceItem(BuildContext context, int index) {
    var name = provinceList[index]["name"];
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        name,
        style: const TextStyle(fontSize: 14.0),
      ),
    );
  }

  Widget buildCityPicker() {
    return CupertinoPicker.builder(
      itemExtent: 40,
      scrollController: cityScrollController,
      backgroundColor: Colors.white,
      onSelectedItemChanged: onCityChanged,
      itemBuilder: _buildCityItem,
      childCount: provinceList.length,
    );
  }

  Widget _buildCityItem(BuildContext context, int index) {
    var name = provinceList[index]["name"];
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        name,
        style: const TextStyle(fontSize: 14.0),
      ),
    );
  }

  Widget buildCountyPicker() {
    return CupertinoPicker.builder(
      itemExtent: 40,
      scrollController: provinceScrollController,
      backgroundColor: Colors.white,
      onSelectedItemChanged: onCountyChanged,
      itemBuilder: _buildCountyItem,
      childCount: provinceList.length,
    );
  }

  Widget _buildCountyItem(BuildContext context, int index) {
    var name = provinceList[index]["name"];
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        name,
        style: const TextStyle(fontSize: 14.0),
      ),
    );
  }

  void onProvinceChanged(int value) {
    cityResult.province = proviceNameByIndex(value);
    widget.forResult?.call(cityResult);
  }

  void onCityChanged(int value) {
    cityResult.city = proviceNameByIndex(value);
    widget.forResult?.call(cityResult);
  }

  void onCountyChanged(int value) {}
}
