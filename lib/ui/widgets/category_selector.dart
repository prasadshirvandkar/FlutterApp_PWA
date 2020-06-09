import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final List<String> categories;
  CategorySelector({@required this.categories});
  _CategorySelector createState() => _CategorySelector();
}

class _CategorySelector extends State<CategorySelector>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isSelected;

  List<Widget> _buildCategories() {
    return widget.categories.map((category) {
      int index = widget.categories.indexOf(category);
      _isSelected = _currentIndex == index;
      return Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: GestureDetector(
              onTap: () => {
                    setState(() {
                      _currentIndex = index;
                    })
                  },
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  child: AnimatedSize(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear,
                      vsync: this,
                      child: Text(category,
                          style: TextStyle(
                              color: _isSelected ? Colors.orange : Colors.grey,
                              fontSize: _isSelected ? 24.0 : 20.0,
                              fontWeight: _isSelected
                                  ? FontWeight.w800
                                  : FontWeight.bold))))));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildCategories());
  }
}
