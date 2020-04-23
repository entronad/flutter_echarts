import 'home_page.dart';
import 'chart_page.dart';
import 'reset_page.dart';

final routes = {
  '/': (context) => HomePage(),
  '/demos/home_page': (context) => ChartPage(),
  '/demos/reset_page': (context) => RestPage(),
};
