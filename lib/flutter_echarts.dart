library flutter_echarts;

import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import './echarts_script.dart' show echartsScript;

String _getHtml(List<String> scripts, String exScript) => '''
data:text/html;UTF-8,
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
  <script>
    ${scripts.reduce((value, element) => value + '\n' + element)}
    const chart = echarts.init(document.getElementById('chart'), null);
    $exScript
  </script>
</head>
<body>
  <div id="chart" />
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

  void update(String preOption) {
    if (widget.option != preOption) {
      _controller?.evaluateJavascript('''
        chart.setOption(${widget.option}, true);
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
    debugPrint(_getHtml([echartsScript], widget.exScript));
    return WebView(
      initialUrl: _getHtml([echartsScript], widget.exScript),
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
        update(null);
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
