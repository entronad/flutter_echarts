[English](https://github.com/entronad/flutter_echarts/blob/master/README.md) 

<p align="center">
<img src="https://raw.githubusercontent.com/entronad/flutter_echarts/master/doc/logo.png" />
</p>

[![pub](https://img.shields.io/pub/v/flutter_echarts.svg)](https://pub.dev/packages/flutter_echarts)

*响应式 [Echarts](https://echarts.apache.org/zh/index.html) Flutter 组件。* 

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

# 特点

**响应式更新**

Flutter 和 React 组件最方便的一点是可以根据数据的变化响应式的更新视图。基于 Echarts 数据驱动式的架构，flutter_echarts 为图表和数据建立了一种响应式的联系。当`option` 参数中的数据变化时，图表可以自动重新渲染。

**双向通信**

通过 `onMessage` 和 `extraScript` 这两个参数，可以设置 JavaScript 和 Flutter 之间的事件双向通信。

**配置扩展**

Echarts 有很多 [扩展](https://echarts.apache.org/zh/download-extension.html) 。你可以通过`extensions` 参数插入这些扩展的文本字符串，以便在源码中管理这些扩展脚本，而不需要操心繁琐的 asset 目录。

# 安装

在 pbuspec.yaml 文件中添加：

```
dependencies:
  flutter_echarts: #最新版本
```

在需要使用的文件中：

```
import 'package:flutter_echarts/flutter_echarts.dart';  
```

详见 [pub.dev](https://pub.dev/packages/flutter_echarts#-installing-tab-) .

# 使用

flutter_echarts 使用起来很简单，就像在使用普通的 statelessWidget ：

> option 的具体设置请见 [Echarts 文档](https://echarts.apache.org/zh/option.html#title) 或 [Echarts 示例](https://echarts.apache.org/examples/zh/index.html) 。

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

在 ios 应用中，你需要在  Info.plist 的 `<dic>` 标签加入：

```
<key>io.flutter.embedded_views_preview</key>
<string>YES</string>
```

完整使用示例请见： [flutter_echarts_example](https://github.com/entronad/flutter_echarts/tree/master/example) 。

# 组件参数

**option**

*String*

*( 必需 )*

字符串形式的 JavaScript Echarts Option。Echarts 图表主要就是通过这个参数配置的。你可以通过 dart:convert 中的 `jsonEncode()` 来转换 Dart 对象类型的数据：

```
source: ${jsonEncode(_data1)},
```

由于 JavaScript 没有`'''` 符号，你可以使用它来包裹字符串，以省掉一些引号的转义：

```
Echarts(
  option: '''
  
    // option string
    
  ''',
),
```

- 如果需要在 option 中使用图片，我们建议使用 Base64 [Data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) :

```
image: 'data:image/png;base64,iVBORw0KG...',
```

**extraScript**

*String*

在  `Echarts.init()` 和任意 `chart.setOption()` 之间执行的 JavaScript 脚本。在组件中我们已经内置了一个  名为 `Messager` 的 JavascriptChennel，所以你可以使用这个标识符来进行 JavaScript 向 Flutter 的通信：

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

处理 `extraScript` 中  `Messager.postMessage()` 发送的消息的函数。

**extensions**

*List\<String\>*

从 Echarts 扩展中拷贝的脚本字符串组成的数组，比如各种主题、组件、WebGl、语言等。可以从 [这里](https://echarts.apache.org/zh/download-extension.html) 下载。将它们作为原始字符串（raw string）引入：

```
const liquidPlugin = r'''

  // copy from liquid.min.js

''';
```

**theme**

*String*

从 [这里](https://echarts.apache.org/zh/download-theme.html) 可以下载主题，或者用 [这个工具](https://echarts.baidu.com/theme-builder/) 定制自己的主题。将主题的脚本拷贝到 `extension` 参数中，并在此参数中注册主题的名称。

**captureAllGestures**

*bool*

*( 默认: false )*

图表是否捕获所有的手势。将其设为 ture 在处理 3D 旋转或数据缩放条时很有用。注意这将阻止容器（比如 ListView ）获取图表上的手势。

# 博客

[响应式 Echarts Flutter 组件](https://zhuanlan.zhihu.com/p/99034738) 

[一次 Flutter WebView 性能优化](https://zhuanlan.zhihu.com/p/103012116) 



---

如果有建议或要求，请发起 [issue](https://github.com/entronad/flutter_echarts/issues) 。

*示例 GIF 来自 [chenjiandongx](https://github.com/chenjiandongx)*