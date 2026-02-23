import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_application/DashboardPage.dart';

class CartAnimationsPage extends StatefulWidget{
  const CartAnimationsPage({Key? key}) : super(key : key);

  @override
  _CartAnimationState createState() => _CartAnimationState();

}

class _CartAnimationState extends State<CartAnimationsPage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context); 
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Center(
        child: Lottie.asset('assets/Cart.json',
        controller: _controller,
          onLoaded: (composition) {
            _controller.duration = composition.duration;
            _controller.forward();
          },
        ),
      ),
    );
  }
}