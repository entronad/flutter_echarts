使用官方的 inline webview : webview_flutter

默认会有个echarts，也可通过其他方式引入

插件也是，通过一个数组引入



特别注意转义，灵活使用原始字符串

option

字符形式的option，每次update的时候会比对检查，自动更新, 其中的数据部分需要json序列化，

extraScript

字符串，额外的脚本, 其中向外发送消息的对象叫“Messager”,紧随chart.init

onMessage

消息处理函数，echarts会发送哪些消息需在exScript中定义，并通过Messager.postMessage发送

~~renderer~~

~~Renderer.canvas（默认） | Renderer.svg~~ （强制使用canvas，效果更好）

~~echartsSrc~~

~~文件地址，默认会有一个最新版的，定期更新~~   (为保证性能？echarts先统一embed在html中)

extensions

资源数组，插件文件地址，包括gl，从github上拷代码的时候要非常小心保证全部拷到，现在GitHub上选中行太长时有bug

提醒目前ios要改配置



出于性能考虑，初始加载不用await rootBundle.loadString('assets/help.html');加载html文件，而是直接以字符串注入

采用uri注入的时候，注意#等特殊符号起到特殊的操作作用，故用base64编码



html初始包括以下内容：

html模板

echarts脚本

plugin脚本们

echarts的基础逻辑

exScript

既要考虑灵活性，也要考虑性能（转换尽量放在编译期）

先全部放在运行期看看效果（目前测试pc端echarts脚本全部转换仅需3ms），不过不能每次都算，仅在构造方法中转换一次

~~url不能过长，所以仅放html，把所有js包括脚本，放到evaluateJavaScript中~~

注意脚本要放body最后



外面的数据请求，和echarts脚本的加载不知道谁先完成，用\_EchartsState.\_currentOption记录最后一次option，以防数据请求在脚本加载之前完成不触发更新，同时update的脚本内加上chart && 防止脚本没加载完没有chart

字符串的传递中，很多地方使用了js中没有'''的技巧



目前webview的背景色为白色，不可更改https://github.com/flutter/flutter/issues/29300



性能优化

~~将回退到1.0加载方式的改动合并到主分支上，今后1.1的改动可到 follow fix-ios 这个commit上去找，删除fix-ios分支~~

注意先将 const chart 改成 var chart 以兼容某些低版本的ios

1.2.2 找到优化在ios上不行的原因了，貌似是转码有些问题，用官方示例中的方式获取的base64编码是可以的，就用这种方式，同时将onUpdate中的脚本用try catch包起来，防止ios报错



尚存在问题

背景白色不可修改

加载时会黑闪一下

手势捕捉可以再细化一下

暴露更多高级参数



2020-03-01

把所有echartsscript提前转成base64放在url中性能还不如放在inject中

inject的await会等所有渲染完成，故后面可跟渲染完成的回调

2020-03-25

目前在 Android 端加载时黑闪的问题暂时用opacity处理一下