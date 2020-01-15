library flutter_echarts;

import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import './echarts_script.dart' show echartsScript;

const htmlUtf8 = 'data:text/html;UTF-8,<!DOCTYPE html><html><head><meta charset="utf-8"><style type="text/css">body,html,%23chart{height: 100%;width: 100%;margin: 0px;}div {-webkit-tap-highlight-color:rgba(255,255,255,0);}</style></head><body><div id="chart" /></body></html>';

typedef OnMessage = void Function(String);

class Echarts extends StatefulWidget {
  Echarts({
    Key key,
    this.option,
    this.extraScript = '',
    this.onMessage,
    this.extensions = const [],
  }) : super(key: key);

  final String option;

  final String extraScript;

  final OnMessage onMessage;

  final List<String> extensions;

  @override
  _EchartsState createState() => _EchartsState();
}

class _EchartsState extends State<Echarts> {
  WebViewController _controller;

  String _currentOption;

  @override
  void initState() {
    super.initState();
    _currentOption = widget.option;
  }

  void init() async {
    final extensionsStr = this.widget.extensions.length > 0
    ? this.widget.extensions.reduce(
        (value, element) => (value ?? '') + '\n' + (element ?? '')
      )
    : '';
    await _controller?.evaluateJavascript('''
      $echartsScript
      $extensionsStr
      const chart = echarts.init(document.getElementById('chart'), null);
      ${this.widget.extraScript}
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
      initialUrl: htmlUtf8,
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
