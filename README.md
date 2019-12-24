# flutter_echarts
A Flutter widget to use [Echarts]((https://github.com/apache/incubator-echarts)) in a reactive way.

[中文](https://github.com/entronad/flutter_echarts/blob/master/README_CN.md)

[Developing blog](https://medium.com/@entronad/reactive-echarts-flutter-widget-fedab7f3c52f)

# Features

**Reactive Updating**

The most exciting feature of Flutter widgets and React components is that the view could update reactively to the change of data. Thanks to Echarts' data driving architecture, flutter_echarts implemented a reactive way to connect chart with data. The chart will automatically re-render when the data in the `option` property changes.

**Two Way Communication**

The `onMessage` and `extraScript` properties provide a way to set event communication both from flutter to JavaScript or in controversy.

**Configurable Extensions**

Echarts has a lot of [extensions](https://echarts.apache.org/en/download-extension.html) . the `extensions` property allows you to inject the extension scripts as raw strings. In this way, you can copy these scripts to your source code, without concerning about the confusing assets dirs.

# Installing

**1. Depend on it**

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  flutter_echarts: ^1.0.1
```

**2. Install it**

You can install packages from the command line:

with Flutter:

```shell
$ flutter pub get
```

Alternatively, your editor might support `flutter pub get`. Check the docs for your editor to learn more.

**3. Import it**

Now in your Dart code, you can use:

```dart
import 'package:flutter_echarts/flutter_echarts.dart';  
```

# Usage

*Before using flutter_echarts, make sure you know how to use  [Echarts]((https://github.com/apache/incubator-echarts)) .*

The flutter_echarts itself is very simple to use, just like a common statelessWidget:

```
Container(
  child: Echarts(
  option: '''
    {
      xAxis: {
        type: 'category',
        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      },
      yAxis: {
        type: 'value'
      },
      series: [{
        data: [820, 932, 901, 934, 1290, 1330, 1320],
        type: 'line'
      }]
    };
  ''',
  ),
  width: 300,
  height: 250,
)
```

For an ios app, you need to add this entry to your Info.plist' `<dic>` tag:

```
<key>io.flutter.embedded_views_preview</key>
<string>YES</string>
```

A full example is here: [flutter_echarts_example](https://github.com/entronad/flutter_echarts/tree/master/example) .

# Widget Properties

**option**

*String*

The JavaScript Echarts Option for the chart as a string. The echarts is mainly configured by this property. You could use `jsonEncode()` function in dart:convert to convert data in Dart object form:

```
source: ${jsonEncode(_data1)},
```

Because JavaScript don't have `'''` , you can use this operator to reduce some escape operators for quotas:

```
Echarts(
  option: '''
  
    // option string
    
  ''',
),
```

**extraScript**

*String*

The JavaScript which will execute after the `Echarts.init()` and before any `chart.setOption()` . The widget has build a javascriptChennel named `Messager`, so you could use this identifier to send message from JavaScript to Flutter:

```
extraScript: '''
  chart.on('click', (params) => {
  if(params.componentType === 'series') {
  	Messager.postMessage('anything');
  }
  });
''',
```

**onMessage**

*void Function(String)*

Function to handle the message sent by `Messager.postMessage()` in `extraScript` .

**extensions**

*List\<String\>*

List of strings that coyied from Echarts extensions, such as components, WebGL, languages, etc. You can download them [here](https://echarts.apache.org/en/download-extension.html) . Insert them as raw strings:

```
const liquidPlugin = r'''

  // copy from liquid.min.js

''';
```



---

If you have any suggestions or demands, please give an [issue](https://github.com/entronad/flutter_echarts/issues) .