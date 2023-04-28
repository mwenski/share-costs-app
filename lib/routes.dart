import 'package:share_cost_app/views/dashboard.dart';
import 'package:share_cost_app/views/login_view.dart';
import 'package:share_cost_app/views/group_form.dart';
import 'package:share_cost_app/views/register_view.dart';
import 'package:share_cost_app/views/expense_form.dart';
import 'package:share_cost_app/views/group_list_view.dart';
import 'package:share_cost_app/views/start_app.dart';

class Routes {
  static const String start = "/start";
  static const String login = "/login";
  static const String register = "/register";
  static const String dashboard = "/dashboard";
  static const String expenseForm = "/expense_form";
  static const String groupForm ="/group_form";
  static const String group = "/group";

  static final routes = {
    start: (context) => const StartApp(),
    login: (context) => const LoginView(),
    register: (context) => const RegisterView(),
    dashboard: (context) => const GroupDashboard(),
    expenseForm: (context) => const ExpenseForm(),
    groupForm: (context) => const GroupForm(),
    group: (context) => const GroupListView(),
  };
}
