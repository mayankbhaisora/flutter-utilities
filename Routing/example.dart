import 'package:flutter/material.dart';
import 'package:project_name/utilities/router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    // Creating a very basic Splash Screen
    return Scaffold(
      body: Text("Flutter Routing Example"),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  // This async function usages Timer which calls loadNextScreen function after 3 seconds
  startTime() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, loadNextScreen);
  }
  
  // BOC: Routing
  // This function is using routing to load the loaing screen
  void loadNextScreen() {
    // Here we are loading the login screen
    Navigator.pushNamed(context, routeLogin);

    // Simillerly we can load the order details screen as given below. orderId is any string here like "1"
    // Navigator.pushNamed(context, routeOrderDetails, arguments: orderId);
  }
  // EOC: Routing
}
