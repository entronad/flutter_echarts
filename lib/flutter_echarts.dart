library flutter_echarts;

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

import 'package:webview_flutter/webview_flutter.dart';

import './echarts_script.dart' show echartsScript;

String _getHtml(
  String echartsScript,
  List<String> extensions,
  String extraScript,
) {
  final extensionsStr = extensions.length > 0
    ? extensions.reduce(
        (value, element) => (value ?? '') + '\n' + (element ?? '')
      )
    : '';
  
  return '''
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0, target-densitydpi=device-dpi" />
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
          $echartsScript
          $extensionsStr
          var chart = echarts.init(document.getElementById('chart'), null);
          $extraScript
        </script>
      </body>
    </html>
  ''';
}

typedef OnMessage = void Function(String);

class Echarts extends StatefulWidget {
  Echarts({
    Key key,
    @required this.option,
    this.extraScript,
    this.onMessage,
    this.extensions,
    this.captureAllGestures = false,
  }) : super(key: key);

  final String option;

  final String extraScript;

  final OnMessage onMessage;

  final List<String> extensions;

  final bool captureAllGestures;

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
    _htmlBase64 = 'data:text/html;base64,' + base64Encode(
      const Utf8Encoder().convert(_getHtml(
        echartsScript,
        widget.extensions ?? [],
        widget.extraScript ?? '',
      ))
    );
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
      gestureRecognizers: widget.captureAllGestures
        ? (Set()
          ..add(Factory<VerticalDragGestureRecognizer>(() {
            return VerticalDragGestureRecognizer()
              ..onStart = (DragStartDetails details) {}
              ..onUpdate = (DragUpdateDetails details) {}
              ..onDown = (DragDownDetails details) {}
              ..onCancel = () {}
              ..onEnd = (DragEndDetails details) {};
          }))
          ..add(Factory<HorizontalDragGestureRecognizer>(() {
            return HorizontalDragGestureRecognizer()
              ..onStart = (DragStartDetails details) {}
              ..onUpdate = (DragUpdateDetails details) {}
              ..onDown = (DragDownDetails details) {}
              ..onCancel = () {}
              ..onEnd = (DragEndDetails details) {};
          })))
        : null,
    );
  }
}
