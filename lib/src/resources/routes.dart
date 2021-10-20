import 'package:flutter/widgets.dart';
import 'package:bugbusters/application.dart';

class Routes {
  Routes._();

  static const wrapper = '/';
  static const welcome = '/welcome';
  static const tnc = '/terms';

  static const dashboard = '/dashboard';

  static Map<String, WidgetBuilder> routes = {
    wrapper: (_) => Wrapper(),
    welcome: (_) => const WelcomeScreen(),

    dashboard: (_) => const DashboardScreen(),

    tnc: (_) => TnCScreen(),
  };
}
