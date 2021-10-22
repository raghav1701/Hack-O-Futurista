import 'package:flutter/widgets.dart';
import 'package:bugbusters/application.dart';

class Routes {
  Routes._();

  static const wrapper = '/';
  static const welcome = '/welcome';
  static const signin = '/signin';
  static const signup = '/signup';
  static const dashboard = '/dashboard';
  static const vehicleRegister = '/vehicleRegister';
  static const bookslot = '/bookslot';
  static const tnc = '/terms';


  static Map<String, WidgetBuilder> routes = {
    wrapper: (_) => const Wrapper(),

    welcome: (_) => const WelcomeScreen(),
    signin: (_) => const SigninScreen(),
    signup: (_) => const SignupScreen(),

    dashboard: (_) => const DashboardScreen(),
    vehicleRegister: (_) => VehicleRegistraionForm(),

    bookslot: (_) => const BookSlot(),

    tnc: (_) => TnCScreen(),
  };
}
