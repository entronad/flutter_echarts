library flutter_echarts;

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import './echarts_script.dart' show echartsScript;

String _getHtml(List<String> scripts, String exScript) => '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
	<style type="text/css">
    body,html,#chart{
      height: 100%;
      width: 100%;
      margin: 0px;
    }
    div {
      -webkit-tap-highlight-color:rgba(255,255,255,0);
    }
  </style>
</head>
<body>
  <div id="chart" />
  <script>
    ${scripts.reduce((value, element) => value + '\n' + element)}
    const chart = echarts.init(document.getElementById('chart'), null);
    $exScript
  </script>
</body>
</html>
''';

typedef OnMessage = void Function(String);

class Echarts extends StatefulWidget {
  Echarts({
    Key key,
    this.option,
    this.exScript = '',
    this.onMessage,
  }) : super(key: key);

  final String option;

  final String exScript;

  final OnMessage onMessage;

  @override
  _EchartsState createState() => _EchartsState();
}

class _EchartsState extends State<Echarts> {
  WebViewController _controller;

  String _htmlBase64;

  String _currentOption;

  @override
  void initState() {
    super.initState();
    _htmlBase64 = 'data:text/html;base64,' + base64Encode(const Utf8Encoder().convert(_getHtml([echartsScript], widget.exScript)));
    _currentOption = widget.option;
  }

  void init() async {
    await _controller?.evaluateJavascript('''
      chart.setOption($_currentOption, true);
    ''');
  }

  void update(String preOption) async {
    _currentOption = widget.option;
    if (_currentOption != preOption) {
      await _controller?.evaluateJavascript('''
        chart && chart.setOption($_currentOption, true);
      ''');
    }
  }

  @override
  void didUpdateWidget(Echarts oldWidget) {
    super.didUpdateWidget(oldWidget);
    update(oldWidget.option);
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: _htmlBase64,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
      },
      onPageFinished: (String url) {
        init();
      },
      javascriptChannels: <JavascriptChannel>[
        JavascriptChannel(
          name: 'Messager',
          onMessageReceived: (JavascriptMessage javascriptMessage) {
            widget?.onMessage(javascriptMessage.message);
          }
        ),
      ].toSet(),
    );
  }
}
