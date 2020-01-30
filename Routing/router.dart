import 'package:flutter/material.dart';
import 'package:project_name/main_screens/order_details.dart';
import 'package:project_name/main_screens/home_screen.dart';
import 'package:project_name/main_screens/login_screen.dart';

// Route Constants: These are the constants which we use in our screens to load the required page
const String routeHome = '/';
const String routeOrderDetails = '/orderDetails';
const String routeLogin = '/login';

// This is the main router class
class Router {
  // This method is called whenever we load new screen using Navigator.pushNamed() method
  // i.e. Navigator.pushNamed(context, routeHome);
  // We will have to above mentioned code to load the home screen
  // If you want to pass a value in next screen, then you can do that as given below
  // i.e. Navigator.pushNamed(context, routeOrderDetails, arguments: orderId);
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
      	// We can even directly use the below mentioned line from where we want to load the new screen in case we don't want to use routing
        return MaterialPageRoute(builder: (_) => Home());
      case routeOrderDetails:
        String orderId = settings.arguments;

        // BOC: This is the optional step. You can skip it
        // This is just to show some message in a new page whenever we try to load the order details screen without providing the order id
        if (orderId == null || orderId.isEmpty) {
          return _buildErrorMessageWidgetRoute("Order Id is missing");
        }
        // EOC: This is the optional step. You can skip it

        return MaterialPageRoute(
          builder: (context) => OrderDetails(orderId)
        );
      case routeLogin:
         return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return _buildErrorMessageWidgetRoute('No route defined for ${settings.name}');
    }
  }

  // The function shown below is not even required for the routing purposes.
  // This method is used to show message on new screen if some route is not found or in case we need to show the message
  // i.e. In routeOrderDetails case written above, we will show the message on new screen when orederId is missing
  static MaterialPageRoute _buildErrorMessageWidgetRoute(String message) {

    // Creating App Bar.
    final appBar = AppBar(
      title: Text("Error"),
    );

    //  You can design the page to show message as per your needs.
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: appBar,
        body: Center(
          child: Text(message)
        ),
      )
    );
  }
}
