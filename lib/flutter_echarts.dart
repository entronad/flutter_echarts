library flutter_echarts;

// --- FIX_BLINK ---
import 'dart:io' show Platform;
// --- FIX_BLINK ---

import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

import 'package:webviewx/webviewx.dart';

import 'echarts_script.dart' show echartsScript;

// <script type="text/javascript" charset="utf-8" src="https://cdn.jsdelivr.net/npm/echarts@5.2.2/dist/echarts.min.js"></script>
String get html => '''
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0, target-densitydpi=device-dpi" />
        <style type="text/css">
            body,
            html,
            #chart {
                height: 100%;
                width: 100%;
                margin: 0px;
                // background: red;
            }
            div {
                -webkit-tap-highlight-color: rgba(255, 255, 255, 0);
            }
        </style>
    </head>
    <body>
        <div id="chart" />
    </body>
</html>
''';
// final htmlBase64 = 'data:text/html;base64,${base64Encode(html.codeUnits)}';

class Echarts extends StatefulWidget {
  Echarts({
    Key? key,
    required this.option,
    this.height,
    this.width,
    this.extraScript = '',
    this.onMessage,
    this.extensions = const [],
    this.theme,
    this.captureAllGestures = false,
    this.captureHorizontalGestures = false,
    this.captureVerticalGestures = false,
    this.onLoad,
    this.onWebResourceError,
    this.reloadAfterInit = false
  }) : super(key: key);

  final double? height;
  final double? width;

  final String option;

  final String extraScript;

  final void Function(String message)? onMessage;

  final List<String> extensions;

  final String? theme;

  final bool captureAllGestures;

  final bool captureHorizontalGestures;

  final bool captureVerticalGestures;

  final void Function(WebViewXController)? onLoad;

  final void Function(WebViewXController, Exception)? onWebResourceError;

  final bool reloadAfterInit;

  @override
  _EchartsState createState() => _EchartsState();
}

class _EchartsState extends State<Echarts> {
  WebViewXController? _controller;

  String? _currentOption;

  // fix white screen of mobile.
  bool _fixWhiteScreen = !kIsWeb;

  // --- FIX_BLINK ---
  double _opacity = !kIsWeb && Platform.isAndroid ? 0.01 : 1.0;
  // --- FIX_BLINK ---

  @override
  void initState() {
    super.initState();
    _currentOption = widget.option;

    if (widget.reloadAfterInit) {
      new Future.delayed(const Duration(milliseconds: 100), () {
        _controller?.reload();
      });
    }
  }

  void init() async {
    if (_fixWhiteScreen) {
      setState(() => _fixWhiteScreen = false);
      return;
    }

    final extensionsStr = this.widget.extensions.length > 0
    ? this.widget.extensions.reduce(
        (value, element) => value + '\n' + element
      )
    : '';
    final themeStr = this.widget.theme != null ? '\'${this.widget.theme}\'' : 'null';
    await _controller?.evalRawJavascript('''
      $echartsScript
      $extensionsStr
      var chart = echarts.init(document.getElementById('chart'), $themeStr);
      ${this.widget.extraScript}
      chart.setOption($_currentOption, true);
    ''');
    if (widget.onLoad != null) {
      widget.onLoad!(_controller!);
    }

    // --- FIX_BLINK ---
    if (_opacity < 1.0) {
      setState(() { _opacity = 1.0; });
    }
    // --- FIX_BLINK ---
  }

  Set<Factory<OneSequenceGestureRecognizer>> getGestureRecognizers() {
    Set<Factory<OneSequenceGestureRecognizer>> set = Set();
    if(this.widget.captureAllGestures || this.widget.captureHorizontalGestures) {
      set.add(Factory<HorizontalDragGestureRecognizer>(() {
        return HorizontalDragGestureRecognizer()
          ..onStart = (DragStartDetails details) {}
          ..onUpdate = (DragUpdateDetails details) {}
          ..onDown = (DragDownDetails details) {}
          ..onCancel = () {}
          ..onEnd = (DragEndDetails details) {};
      }));
    }
    if(this.widget.captureAllGestures || this.widget.captureVerticalGestures) {
      set.add(Factory<VerticalDragGestureRecognizer>(() {
        return VerticalDragGestureRecognizer()
          ..onStart = (DragStartDetails details) {}
          ..onUpdate = (DragUpdateDetails details) {}
          ..onDown = (DragDownDetails details) {}
          ..onCancel = () {}
          ..onEnd = (DragEndDetails details) {};
      }));
    }
    return set;
  }

  void update(String preOption) async {
    _currentOption = widget.option;
    if (_currentOption != preOption) {
      await _controller?.evalRawJavascript('''
        try {
          chart.setOption($_currentOption, true);
        } catch(e) {
        }
      ''');
    }
  }

  @override
  void didUpdateWidget(Echarts oldWidget) {
    super.didUpdateWidget(oldWidget);
    update(oldWidget.option);
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  void disposeController() {
    // --- FIX_IOS_LEAK ---
    if (!kIsWeb && Platform.isIOS) {
      _controller?.clearCache();
    }
    // --- FIX_IOS_LEAK ---

    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- FIX_BLINK ---
    return Opacity(
      opacity: _opacity,
    // --- FIX_BLINK ---
      child: WebViewX(
        // fix white screen for mobile.
        key: kIsWeb ? null : ValueKey(_fixWhiteScreen),

        initialContent: html,
        initialSourceType: SourceType.html,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewXController webViewController) {
          // dispose old when key changed.
          disposeController();
          _controller = webViewController;
        },
        onPageFinished: (String url) {
          init();
        },
        onWebResourceError: (e) {
          if (widget.onWebResourceError != null) {
            widget.onWebResourceError!(_controller!, Exception(e));
          }
        },
        dartCallBacks: <DartCallback>[
          DartCallback(
            name: 'Messager',
            callBack: (dynamic javascriptMessage) {
              if (widget.onMessage != null) {
                widget.onMessage!(javascriptMessage is String ? javascriptMessage : "$javascriptMessage");
              }
            }
          ),
        ].toSet(),
        mobileSpecificParams: MobileSpecificParams(mobileGestureRecognizers: getGestureRecognizers()),

        width: widget.width ?? double.maxFinite,
        height: widget.height ?? double.maxFinite,
      )
    );
  }
}
