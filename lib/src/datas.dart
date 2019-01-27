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

List<int> findIndexs(String provinceName, String cityName, String countyName) {
  var proIndex = 0;
  var cityIndex = 0;
  var countyIndex = 0;

  if (proIndex == null && cityName == null && countyName == null) {
    return [0, 0, 0];
  }

  List<dynamic> pList = _datas["provinceList"];
  out:
  for (var item in pList) {
    if (item["name"] == provinceName) {
      proIndex = pList.indexOf(item);
      List<dynamic> cityList = item["cityList"];
      for (var city in cityList) {
        if (city["name"] == cityName) {
          cityIndex = cityList.indexOf(city);
          List<dynamic> countyList = city["countyList"];
          for (var county in countyList) {
            if (county["name"] == countyName) {
              countyIndex = countyList.indexOf(county);
              break out;
            }
          }
        }
      }
    }
  }

  return [proIndex, cityIndex, countyIndex];
}
