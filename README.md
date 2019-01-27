# city_picker

A chinese city picker, 中国城市选择器

## use

pubspec.yaml

```yaml
city_picker: ^0.1.0
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

