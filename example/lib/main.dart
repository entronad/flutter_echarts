import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:number_display/number_display.dart';

import './liquid_script.dart' show liquidScript;

final display = createDisplay(decimal: 2);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Map<String, Object>> _data1 = [{ 'name': 'Please wait', 'value': 0 }];

  getData1() async {
    await Future.delayed(Duration(seconds: 4));

    const dataObj = [{
      'name': 'Jan',
      'value': 8726.2453,
    }, {
      'name': 'Feb',
      'value': 2445.2453,
    }, {
      'name': 'Mar',
      'value': 6636.2400,
    }, {
      'name': 'Apr',
      'value': 4774.2453,
    }, {
      'name': 'May',
      'value': 1066.2453,
    }, {
      'name': 'Jun',
      'value': 4576.9932,
    }, {
      'name': 'Jul',
      'value': 8926.9823,
    }];

    this.setState(() { this._data1 = dataObj;});
  }

  @override
  void initState() {
    super.initState();

    this.getData1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Echarts Demon'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                child: Text('Reactive updating and tap event', style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
              ),
              Text('- data will be fetched in a few seconds'),
              Text('- tap the bar and trigger the snack'),
              Container(
                child: Echarts(
                  option: '''
                    {
                      dataset: {
                        dimensions: ['name', 'value'],
                        source: ${jsonEncode(_data1)},
                      },
                      color: ['#3398DB'],
                      legend: {
                        data: ['直接访问', '背景'],
                        show: false,
                      },
                      grid: {
                        left: '0%',
                        right: '0%',
                        bottom: '5%',
                        top: '7%',
                        height: '85%',
                        containLabel: true,
                        z: 22,
                      },
                      xAxis: [{
                        type: 'category',
                        gridIndex: 0,
                        axisTick: {
                          show: false,
                        },
                        axisLine: {
                          lineStyle: {
                            color: '#0c3b71',
                          },
                        },
                        axisLabel: {
                          show: true,
                          color: 'rgb(170,170,170)',
                          formatter: function xFormatter(value, index) {
                            if (index === 6) {
                              return `\${value}\\n*`;
                            }
                            return value;
                          },
                        },
                      }],
                      yAxis: {
                        type: 'value',
                        gridIndex: 0,
                        splitLine: {
                          show: false,
                        },
                        axisTick: {
                            show: false,
                        },
                        axisLine: {
                          lineStyle: {
                            color: '#0c3b71',
                          },
                        },
                        axisLabel: {
                          color: 'rgb(170,170,170)',
                        },
                        splitNumber: 12,
                        splitArea: {
                          show: true,
                          areaStyle: {
                            color: ['rgba(250,250,250,0.0)', 'rgba(250,250,250,0.05)'],
                          },
                        },
                      },
                      series: [{
                        name: '合格率',
                        type: 'bar',
                        barWidth: '50%',
                        xAxisIndex: 0,
                        yAxisIndex: 0,
                        itemStyle: {
                          normal: {
                            barBorderRadius: 5,
                            color: {
                              type: 'linear',
                              x: 0,
                              y: 0,
                              x2: 0,
                              y2: 1,
                              colorStops: [
                                {
                                  offset: 0, color: '#00feff',
                                },
                                {
                                  offset: 1, color: '#027eff',
                                },
                                {
                                  offset: 1, color: '#0286ff',
                                },
                              ],
                            },
                          },
                        },
                        zlevel: 11,
                      }],
                    }
                  ''',
                  extraScript: '''
                    chart.on('click', (params) => {
                      if(params.componentType === 'series') {
                        Messager.postMessage(JSON.stringify({
                          type: 'select',
                          payload: params.dataIndex,
                        }));
                      }
                    });
                  ''',
                  onMessage: (String message) {
                    Map<String, Object> messageAction = jsonDecode(message);
                    print(messageAction);
                    if (messageAction['type'] == 'select') {
                      final item = _data1[messageAction['payload']];
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text(item['name'].toString() + ': ' + display(item['value'])),
                          duration: Duration(seconds: 2),
                        ));
                    }
                  },
                ),
                width: 300,
                height: 250,
              ),
              Padding(
                child: Text('Using extension', style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              ),
              Container(
                child: Echarts(
                  extensions: [liquidScript],
                  option: '''
                    {
                      grid: {
                        left: '0%',
                        right: '0%',
                        bottom: '0%',
                        top: '0%',
                      },
                      series: [{
                        type: 'liquidFill',
                        data: [0.6]
                      }]
                    }
                  ''',
                ),
                width: 300,
                height: 250,
              )
            ],
          ),
        ),
      ),
    );
  }
}
