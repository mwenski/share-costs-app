import 'package:share_cost_app/views/home_view.dart';
import 'package:share_cost_app/views/login_view.dart';
import 'package:share_cost_app/views/group_form.dart';
import 'package:share_cost_app/views/register_view.dart';
import 'package:share_cost_app/views/expense_form.dart';
import 'package:share_cost_app/views/group_list_view.dart';

class Routes {
  static const String login = "/login";
  static const String register = "/register";
  static const String home = "/home";
  static const String newExpense = "/new_expense";
  static const String newGroup ="/new_group";
  static const String group = "/group";

  static final routes = {
    login: (context) => const LoginView(),
    register: (context) => const RegisterView(),
    home: (context) => const HomeView(),
    newExpense: (context) => const ExpenseForm(),
    newGroup: (context) => const GroupForm(),
    group: (context) => const GroupListView(),
  };
}
