[中文](https://github.com/entronad/flutter_echarts/blob/master/README_CN.md) 

<p align="center">
<img src="https://raw.githubusercontent.com/entronad/flutter_echarts/master/doc/logo.png" />
</p>

[![pub](https://img.shields.io/pub/v/flutter_echarts.svg)](https://pub.dev/packages/flutter_echarts)

*A Flutter widget to use [Echarts](https://echarts.apache.org/en/index.html) in a reactive way.* 

<div align="center">
<img src="https://user-images.githubusercontent.com/19553554/52197440-843a5200-289a-11e9-8601-3ce8d945b04a.gif" width="33%" height="33%" alt="bar"/>
<img src="https://user-images.githubusercontent.com/19553554/52360729-ad640980-2a77-11e9-84e2-feff7e11aea5.gif" width="33%" height="33%" alt="boxplot"/>
<img src="https://user-images.githubusercontent.com/19553554/52535290-4b611800-2d87-11e9-8bf2-b43a54a3bda8.png" width="33%" height="33%" alt="effectScatter"/>
<img src="https://user-images.githubusercontent.com/19553554/52332816-ac5eb800-2a36-11e9-8227-3538976f447d.gif" width="33%" height="33%" alt="funnel"/>
<img src="https://user-images.githubusercontent.com/19553554/52332988-0b243180-2a37-11e9-9db8-eb6b8c86a0de.png" width="33%" height="33%" alt="gague"/>
<img src="https://user-images.githubusercontent.com/19553554/52344575-133f9980-2a56-11e9-93e0-568e484936ce.gif" width="33%" height="33%" alt="geo"/>
<img src="https://user-images.githubusercontent.com/19553554/52727805-f7f20280-2ff0-11e9-91ab-cd99848e3127.gif" width="33%" height="33%" alt="graph"/>
<img src="https://user-images.githubusercontent.com/19553554/52345115-6534ef00-2a57-11e9-80cd-9cbfed252139.gif" width="33%" height="33%" alt="heatmap"/>
<img src="https://user-images.githubusercontent.com/19553554/52345490-4a16af00-2a58-11e9-9b43-7bbc86aa05b6.gif" width="33%" height="33%" alt="kline"/>
<img src="https://user-images.githubusercontent.com/19553554/52346064-b7770f80-2a59-11e9-9e03-6dae3a8c637d.gif" width="33%" height="33%" alt="line"/>
<img src="https://user-images.githubusercontent.com/19553554/52347117-248ba480-2a5c-11e9-8402-5a94054dca50.gif" width="33%" height="33%" alt="liquid"/>
<img src="https://user-images.githubusercontent.com/19553554/52347915-0a52c600-2a5e-11e9-8039-41268238576c.gif" width="33%" height="33%" alt="map"/>
<img src="https://user-images.githubusercontent.com/19553554/52535013-e48e2f80-2d83-11e9-8886-ac0d2122d6af.png" width="33%" height="33%" alt="parallel"/>
<img src="https://user-images.githubusercontent.com/19553554/52348202-bb596080-2a5e-11e9-84a7-60732be0743a.gif" width="33%" height="33%" alt="pie"/>
<img src="https://user-images.githubusercontent.com/19553554/52533994-932b7380-2d76-11e9-93b4-0de3132eb941.gif" width="33%" height="33%" alt="radar"/>
<img src="https://user-images.githubusercontent.com/19553554/52348431-420e3d80-2a5f-11e9-8cab-7b415592dc77.gif" width="33%" height="33%" alt="scatter"/>
<img src="https://user-images.githubusercontent.com/19553554/52348737-01fb8a80-2a60-11e9-94ac-dacbd7b58811.png" width="33%" height="33%" alt="wordCloud"/>
<img src="https://user-images.githubusercontent.com/19553554/52433989-4f075b80-2b49-11e9-9979-ef32c2d17c96.gif" width="33%" height="33%" alt="bar3D"/>
<img src="https://user-images.githubusercontent.com/19553554/52464826-4baab900-2bb7-11e9-8299-776f5ee43670.gif" width="33%" height="33%" alt="line3D"/>
<img src="https://user-images.githubusercontent.com/19553554/52802261-8d0cfe00-30ba-11e9-8ae7-ae0773770a59.gif" width="33%" height="33%" alt="sankey"/>
<img src="https://user-images.githubusercontent.com/19553554/52464647-aee81b80-2bb6-11e9-864e-c544392e523a.gif" width="33%" height="33%" alt="scatter3D"/>
<img src="https://user-images.githubusercontent.com/19553554/52465183-a55fb300-2bb8-11e9-8c10-4519c4e3f758.gif" width="33%" height="33%" alt="surface3D"/>
<img src="https://user-images.githubusercontent.com/19553554/52798246-7ebae400-30b2-11e9-8489-6c10339c3429.gif" width="33%" height="33%" alt="themeRiver"/>
<img src="https://user-images.githubusercontent.com/19553554/52349544-c2ce3900-2a61-11e9-82af-28aaaaae0d67.gif" width="33%" height="33%" alt="overlap"/>
</div>

# Features

**Reactive Updating**

The most exciting feature of Flutter widgets and React components is that the view could update reactively to the change of data. Thanks to Echarts' data driving architecture, flutter_echarts implemented a reactive way to connect chart with data. The chart will automatically re-render when the data in the `option` property changes.

**Two Way Communication**

The `onMessage` and `extraScript` properties provide a way to set event communication both from flutter to JavaScript or in controversy.

**Configurable Extensions**

Echarts has a lot of [extensions](https://echarts.apache.org/en/download-extension.html) . the `extensions` property allows you to inject the extension scripts as raw strings. In this way, you can copy these scripts to your source code, without concerning about the confusing assets dirs.

# Installing

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  flutter_echarts: #latest version
```

Now in your Dart code, you can use:

```dart
import 'package:flutter_echarts/flutter_echarts.dart';  
```

Details see [pub.dev](https://pub.dev/packages/flutter_echarts#-installing-tab-) .

# Usage

The flutter_echarts itself is very simple to use, just like a common statelessWidget:

> Details about the option is in the [Echarts docs](https://echarts.apache.org/en/option.html#title) or [Echarts examples](https://echarts.apache.org/examples/en/index.html) 

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
    }
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

*( required )*

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

List of strings that coyied from Echarts extensions, such as themes, components, WebGL, languages, etc. You can download them [here](https://echarts.apache.org/en/download-extension.html) . Insert them as raw strings:

```
const liquidPlugin = r'''

  // copy from liquid.min.js

''';
```

**theme**

*String*

You can download built-in themes [here](https://echarts.apache.org/en/download-theme.html) or build own custom themes with [this tool](https://echarts.baidu.com/theme-builder/) . Copy the theme script into the `extensions` param and register the theme name with this param.

**captureAllGestures**

*bool*

*( default: false )*

Whether the chart captures all gestures. Setting it ture is usefull when handling 3D rotation and data zoom bars. Note that will prevent containers like ListViews to act to gestures on the charts.

# Blog

[Reactive Echarts Flutter Widget](https://medium.com/@entronad/reactive-echarts-flutter-widget-fedab7f3c52f) 

[A performance optimization of Flutter WebView](https://levelup.gitconnected.com/a-performance-optimization-of-flutter-webview-6afa1a5b4300?source=your_stories_page---------------------------)



---

If you have any suggestions or demands, please give an [issue](https://github.com/entronad/flutter_echarts/issues) .

*The gallery GIF is from [chenjiandongx](https://github.com/chenjiandongx)*