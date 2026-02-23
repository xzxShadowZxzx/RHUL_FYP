import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_application/DashboardPage.dart';

class PaymentAnimationsPage extends StatefulWidget{
  const PaymentAnimationsPage({Key? key}) : super(key : key);

  @override
  _AnimationState createState() => _AnimationState();

}

class _AnimationState extends State<PaymentAnimationsPage> with TickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboardpage()),
                ); 
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
        child: Lottie.asset('assets/Payment.json', // gets the json file of the animation
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