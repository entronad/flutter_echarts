使用官方的 inline webview : webview_flutter

默认会有个echarts，也可通过其他方式引入

插件也是，通过一个数组引入



option

字符形式的option，每次update的时候会比对检查，自动更新

exScript

字符串，额外的脚本

onMessage

消息处理函数

renderer

Renderer.canvas（默认） | Renderer.svg

echartsSrc

文件地址，默认会有一个最新版的，定期更新

pluginSrcs

数组，插件文件地址