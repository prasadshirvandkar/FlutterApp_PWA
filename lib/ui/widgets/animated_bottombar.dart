import 'package:flutter/material.dart';

class AnimatedBottomBar extends StatefulWidget {
  final Function onBarTap;
  AnimatedBottomBar({this.onBarTap});

  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> with TickerProviderStateMixin {
  final Duration animationDuration = Duration(milliseconds: 100);
  int _selectedBarIndex = 0;
  List<BarItem> barItems = [
    BarItem("Home", Icons.home, Colors.orange),
    BarItem("Favorites", Icons.favorite, Colors.pink),
    BarItem("Extra", Icons.account_circle, Colors.blue.shade800)
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row( 
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildNavBarItem(0, barItems[0]),
            buildNavBarItem(1, barItems[1]),
            buildNavBarItem(2, barItems[2])
          ]
        )
      )
    );
  }

  Widget buildNavBarItem(int index, BarItem item) {
    bool isSelected = _selectedBarIndex == index;
    return InkWell(
      onTap: () {
        setState(() => _selectedBarIndex = index);
        widget.onBarTap(_selectedBarIndex);
      },
      child: AnimatedContainer(
        duration: animationDuration,
        decoration: isSelected ? BoxDecoration(
            color: item.color.withOpacity(0.15),
            borderRadius: BorderRadius.all(Radius.circular(30))
        ): BoxDecoration(),
        child: Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0),
          child: Row(
            children: <Widget>[
              Icon(item.icon, color: item.color),
              SizedBox(width: 10.0),
              AnimatedSize(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOutCirc,
                vsync: this,
                child: Text(
                  isSelected ? item.text : "", 
                  style: TextStyle(color: item.color, fontWeight: FontWeight.w600)
                )
              )
            ],
          )
        )
      )
    );
  }
}

class BarItem {
  String text;
  IconData icon;
  Color color;

  BarItem(this.text, this.icon, this.color);
}