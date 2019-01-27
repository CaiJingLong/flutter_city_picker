import 'dart:convert';

import 'package:flutter/services.dart';

Map<String, dynamic> _datas = {};

bool _isInit = false;

Future<Map<String, dynamic>> loadCityData() async {
  if (_isInit) {
    return _datas;
  }
  var s =
      await rootBundle.loadString("packages/city_picker/assets/city_json.json");
  var params = json.decode(s);
  _datas.addAll(params);
  _isInit = true;
  return _datas;
}

void releaseCityData() {
  _datas.clear();
  _isInit = false;
}
