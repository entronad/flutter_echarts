# flutter_echarts

响应式的 [Echarts]((https://github.com/apache/incubator-echarts))  Flutter 组件.

[English](https://github.com/entronad/flutter_echarts/blob/master/README.md)

[开发博客](https://zhuanlan.zhihu.com/p/99034738)

# 特点

**响应式更新**

Flutter 和 React 组件最方便的一点是可以根据数据的变化响应式的更新视图。基于 Echarts 数据驱动式的架构，flutter_echarts 为图表和数据建立了一种响应式的联系。当`option` 参数中的数据变化时，图表可以自动重新渲染。

**双向通信**

通过 `onMessage` 和 `extraScript` 这两个参数，可以设置 JavaScript 和 Flutter 之间的事件双向通信。

**配置扩展**

Echarts 有很多 [扩展](https://echarts.apache.org/en/download-extension.html) 。你可以通过`extensions` 参数插入这些扩展的文本字符串，以便在源码中管理这些扩展脚本，而不需要操心繁琐的 asset 目录。

# 安装

**1. 设置依赖**

在 pbuspec.yaml 文件中添加：

```
dependencies:
  flutter_echarts: ^1.0.1
```

**2. 安装**

编辑器会自动执行安装，或在命令行中执行

```
$ flutter pub get
```

**3. 引入代码**

在要使用的文件中：

```
import 'package:flutter_echarts/flutter_echarts.dart';  
```

# 使用

*使用 flutter_echarts 之前，确保你已经会使用  [Echarts]((https://github.com/apache/incubator-echarts)) 。*

flutter_echarts 使用起来很简单，就像在使用普通的 statelessWidget ：

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

在 ios 应用中，你需要在  Info.plist 的 `<dic>` 标签加入：

```
<key>io.flutter.embedded_views_preview</key>
<string>YES</string>
```

完整使用示例请见： [flutter_echarts_example](https://github.com/entronad/flutter_echarts/tree/master/example) 。

# 组件参数

**option**

*String*

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

从 Echarts 扩展中拷贝的脚本字符串组成的数组，比如各种组件、WebGl、语言等。可以从 [这里](https://echarts.apache.org/en/download-extension.html) 下载。将它们作为原始字符串（raw string）引入：

```
const liquidPlugin = r'''

  // copy from liquid.min.js

''';
```



---

如果有建议或要求，请发起 [issue](https://github.com/entronad/flutter_echarts/issues) 。