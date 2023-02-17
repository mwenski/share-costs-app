import 'package:share_cost_app/views/home_view.dart';
import 'package:share_cost_app/views/login_view.dart';
import 'package:share_cost_app/views/register_view.dart';
import 'package:share_cost_app/views/new_expense_view.dart';

class Routes {
  static const String login = "/login";
  static const String register = "/register";
  static const String home = "/";
  static const String newExpense = "/new_expense";

  static final routes = {
    login: (context) => const LoginView(),
    register: (context) => const RegisterView(),
    home: (context) => const HomeView(),
    newExpense: (context) => const NewExpenseView(),
  };
}
