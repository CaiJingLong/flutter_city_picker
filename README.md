# city_picker

[![pub package](https://img.shields.io/pub/v/city_picker.svg)](https://pub.dartlang.org/packages/city_picker)

A city picker of china, 中国城市选择器

## screenshot

![图片](https://raw.githubusercontent.com/CaiJingLong/asset_for_picgo/master/20190127155034.png)

## use

pubspec.yaml

latest_version: [![pub package](https://img.shields.io/pub/v/city_picker.svg)](https://pub.dartlang.org/packages/city_picker)

```yaml
city_picker: $latest_version
```

import

```dart
import 'package:city_picker/city_picker.dart';
```

use

```dart
    CityResult result = await showCityPicker(context);
    String province = result?.province; // 省
    String city = result?.city; // 市
    String county = result?.county; // 地级市/县
```

init pick city

```dart
    CityResult result = await showCityPicker(context,
     initCity: CityResult()
       ..province = p1 // 省
       ..city = p2 // 市
       ..county = p3); // 地级市/县
```

## 城市数据

使用 json,数据来源为 python 爬虫爬取[python_get_city_datas](https://github.com/CaiJingLong/python_get_city_datas)

真实数据来源[国家统计局城乡划分 2018 版](http://www.stats.gov.cn/tjsj/tjbz/tjyqhdmhcxhfdm/2018/)

## LICENSE

copyright apache 2.0 for caijinglong
