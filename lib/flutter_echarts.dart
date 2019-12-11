library flutter_echarts;

import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import './echarts_script.dart' show echartsScript;

String _getHtml(List<String> scripts) => '''
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
    ${scripts.reduce((value, element) => value + element)}
    const chart = echarts.init(document.getElementById('chart'), null);
    document.addEventListener('message', (e) => {
      chart.setOption(parse(e.data), true);
    });
  </script>
</head>
<body>
  <div id="chart" />
</body>
</html>
''';

class Echarts extends StatefulWidget {
  Echarts({
    Key key,
    this.option,
    this.exScript,
    this.onMessage,
  }) : super(key: key);

  final String option;

  final String exScript;

  final Function onMessage;

  @override
  _EchartsState createState() => _EchartsState();
}

class _EchartsState extends State<Echarts> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: _getHtml([echartsScript]),
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
