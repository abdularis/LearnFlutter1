import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen()
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  var _selectedChoice = choices[0];

  _select(choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBodyContent(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Basic App"),
      actions: <Widget>[
        IconButton(
          icon: Icon(choices[0].icon),
          tooltip: choices[0].title,
          onPressed: () {
            _select(choices[0]);
          },
        ),
        IconButton(
          icon: Icon(choices[1].icon),
          tooltip: choices[1].title,
          onPressed: () {
            _select(choices[1]);
          },
        ),
        PopupMenuButton(
          onSelected: _select,
          itemBuilder: (context) {
            return choices.skip(2).map((choice) {
              return PopupMenuItem(
                value: choice,
                child: Text(choice.title),
              );
            })
            .toList();
          },
        )
      ]
    );
  }

  Widget _buildBodyContent() {
//    return Center(child: Text("Hello app bar!"),);
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ChoiceCard(choice: _selectedChoice),
    );
  }
}

class Choice {
  Choice({this.title, this.icon});

  String title;
  IconData icon;
}

List<Choice> choices = [
  Choice(title: "Car", icon: Icons.directions_car),
  Choice(title: "Bicycle", icon: Icons.directions_bike),
  Choice(title: "Boat", icon: Icons.directions_boat),
  Choice(title: "Train", icon: Icons.directions_railway),
  Choice(title: "Walk", icon: Icons.directions_walk)
];

class ChoiceCard extends StatelessWidget {

  ChoiceCard({this.choice});

  final choice;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color,),
            Text(choice.title, style: textStyle,)
          ],
        ),
      ),
    );
  }
}