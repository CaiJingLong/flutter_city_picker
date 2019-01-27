import 'dart:convert';

import 'package:flutter/services.dart';

const Map<String, dynamic> _datas = {};

bool _isInit = false;

Future loadCityData() async {
  if (_isInit) {
    return;
  }
  var s =
      await rootBundle.loadString("packages/city_picker/assets/city_json.json");
  var params = json.decode(s);
  _datas.addAll(params);
  _isInit = true;
}

void releaseCityData() {
  _datas.clear();
  _isInit = false;
}
