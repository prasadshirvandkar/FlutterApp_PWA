import 'package:flutter/material.dart';
import 'package:flutterapp/ui/views/home_view.dart';

class SuccessfulOrder extends StatefulWidget {
  _SuccessfulOrder createState() => _SuccessfulOrder();
}

class _SuccessfulOrder extends State<SuccessfulOrder>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0.1);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
              child: ScaleTransition(
                  scale: _animation,
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Colors.greenAccent.withOpacity(0.5),
                                      offset: Offset(0, 5.0),
                                      blurRadius: 16)
                                ],
                                shape: BoxShape.circle,
                                color: Colors.greenAccent),
                            child: Center(
                              child: Icon(Icons.check,
                                  color: Colors.white, size: 120),
                            )),
                        SizedBox(height: 50.0),
                        Text(
                          'Order Placed \nSuccessfully',
                          style: TextStyle(fontSize: 32.0),
                          textAlign: TextAlign.center,
                        ),
                      ])))),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: RaisedButton(
            onPressed: () => {
              Navigator.pop(context)
            },
            shape: StadiumBorder(),
            color: Colors.greenAccent,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Go Back', style: TextStyle(fontSize: 20.0)),
            )),
      ),
    );
  }
}
