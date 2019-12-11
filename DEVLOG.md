使用官方的 inline webview : webview_flutter

默认会有个echarts，也可通过其他方式引入

插件也是，通过一个数组引入



option

字符形式的option，每次update的时候会比对检查，自动更新

exScript

字符串，额外的脚本

onMessage

消息处理函数

~~renderer~~

~~Renderer.canvas（默认） | Renderer.svg~~ （强制使用canvas，效果更好）

~~echartsSrc~~

~~文件地址，默认会有一个最新版的，定期更新~~   (为保证性能？echarts先统一embed在html中)

plugins

资源数组，插件文件地址，包括gl



出于性能考虑，初始加载不用await rootBundle.loadString('assets/help.html');加载html文件，而是直接以字符串注入