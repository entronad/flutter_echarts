import 'package:flutter/material.dart';

class Package {
  Package({
    this.name,
    this.endPoint,
    this.version,
  });

  final String name;
  final String endPoint;
  final String version;
}

final packages = <Package>[
  Package(
    name: 'Test init view',
    endPoint: 'home_page',
    version: '1.0.6',
  ),
  Package(
    name: 'Reset test',
    endPoint: 'reset_page',
    version: '0.5.0',
  ),
  // Package(
  //   name: 'flutter_circular_chart',
  //   github: 'xqwzts/flutter_circular_chart',
  //   version: '0.1.0',
  // ),
  // Package(
  //   name: 'flutter_charts',
  //   github: 'mzimmerm/flutter_charts',
  //   version: '0.1.10',
  // ),
  // Package(
  //   name: 'fcharts',
  //   github: 'thekeenant/fcharts',
  //   version: '0.1.10',
  // )
];

class PackageCard extends StatelessWidget {
  PackageCard({Key key, @required this.package, @required this.onPressed}):super(key: key);

  final Package package;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.title;
    final TextStyle descriptionStyle = theme.textTheme.body1;

    return Container(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          this.onPressed(this.package.endPoint);
        },
        child: Card(
          child: DefaultTextStyle(
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: descriptionStyle,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                    child: Text(this.package.name, style: titleStyle,),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 4.0),
                    child: Text('GitHub:  ${this.package.endPoint}'),
                  ),
                  Text('Version:  ${this.package.version}'),
                ],
              ),
            ),
          )
        ),
      )
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Packages'),
      ),
      body: ListView(
        children: packages.map((package) => (
          PackageCard(
            package: package,
            onPressed: (String endPoint) {
              Navigator.pushNamed(context, '/demos/$endPoint');
            },
          )
        )).toList(),
      )
    );
  }
}
