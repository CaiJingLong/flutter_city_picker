import 'dart:async';

import 'package:city_picker/src/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'datas.dart';

Future<CityResult> showCityPicker(BuildContext context) async {
  Completer<CityResult> completer = Completer();
  var cityData = await loadCityData();

  var result = showDialog(
    context: context,
    builder: (c) => CityPicker(
          params: cityData,
        ),
  );

  result.then((v) {
    completer.complete(v);
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
  int cityIndex = 0;
  int countyIndex = 0;

  var cityResult = CityResult();

  Map<String, dynamic> get datas => widget.params;

  List<dynamic> get provinceList => datas["provinceList"];
  String proviceNameByIndex(int index) => provinceList[index]["name"];

  List<dynamic> get cityList => provinceList[provinceIndex]["cityList"];

  List<dynamic> get countyList => cityList[cityIndex]["countyList"];

  FixedExtentScrollController provinceScrollController;
  FixedExtentScrollController cityScrollController;
  FixedExtentScrollController countyScrollController;

  @override
  void initState() {
    super.initState();
    provinceScrollController = FixedExtentScrollController();
    cityScrollController = FixedExtentScrollController();
    countyScrollController = FixedExtentScrollController();

    cityResult.province = proviceNameByIndex(0);
    cityResult.city = cityList[0]["name"];
    cityResult.county = countyList[0]["name"];
    widget.forResult?.call(cityResult);
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
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300.0,
            child: Material(
              child: Column(
                children: <Widget>[
                  _buildButtons(),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(child: buildProvincePicker()),
                        Expanded(child: buildCityPicker()),
                        Expanded(child: buildCountyPicker()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
    return _buildTextItem(name);
  }

  Widget buildCityPicker() {
    return CupertinoPicker.builder(
      itemExtent: 40,
      scrollController: cityScrollController,
      backgroundColor: Colors.white,
      onSelectedItemChanged: onCityChanged,
      itemBuilder: _buildCityItem,
      childCount: cityList.length,
    );
  }

  Widget _buildCityItem(BuildContext context, int index) {
    var name = cityList[index]["name"];
    return _buildTextItem(name);
  }

  Widget buildCountyPicker() {
    return CupertinoPicker.builder(
      itemExtent: 40,
      scrollController: countyScrollController,
      backgroundColor: Colors.white,
      onSelectedItemChanged: onCountyChanged,
      itemBuilder: _buildCountyItem,
      childCount: countyList.length,
    );
  }

  Widget _buildCountyItem(BuildContext context, int index) {
    var name = countyList[index]["name"];
    return _buildTextItem(name);
  }

  Widget _buildTextItem(String text) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14.0),
      ),
    );
  }

  void onProvinceChanged(int value) {
    _log("onProvinceChanged value = $value");
    provinceIndex = value;
    cityIndex = 0;
    countyIndex = 0;
    cityResult.province = proviceNameByIndex(value);
    cityResult.city = cityList[0]["name"];
    cityResult.county = countyList[0]["name"];
    widget.forResult?.call(cityResult);
    cityScrollController.jumpTo(0);
    countyScrollController.jumpTo(0);
    setState(() {});
  }

  void onCityChanged(int value) {
    _log("onCityChanged value = $value");
    cityIndex = value;
    countyIndex = 0;
    cityResult.city = cityList[value]["name"];
    cityResult.county = countyList[0]["name"];
    widget.forResult?.call(cityResult);
    countyScrollController.jumpTo(0);
    setState(() {});
  }

  void onCountyChanged(int value) {
    _log("onCountyChanged value = $value");
    countyIndex = value;
    cityResult.county = countyList[value]["name"];
    widget.forResult?.call(cityResult);
    setState(() {});
  }

  Widget _buildButtons() {
    Widget buildButton(String text, Function onTap) {
      return CupertinoButton(
        child: Text(text),
        onPressed: onTap,
      );
    }

    return Container(
      color: Colors.white,
      height: 40.0,
      child: Row(
        children: <Widget>[
          buildButton("取消", () {
            Navigator.pop(context);
          }),
          Expanded(
            child: Container(),
          ),
          buildButton("确定", () {
            cityResult.province = proviceNameByIndex(provinceIndex);
            cityResult.city = cityList[cityIndex]["name"];
            cityResult.county = countyList[countyIndex]["name"];
            Navigator.pop(context, cityResult);
          }),
        ],
      ),
    );
  }
}

void _log(msg) {
  // print(msg);
}
