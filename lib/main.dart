import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_bloc/routes/app_routes.dart';
import 'package:task_bloc/screen.dart/task_screen.dart';
import 'package:task_bloc/services/storage.dart';
import 'blocs/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    appRouter: AppRouter(),
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key, required this.appRouter, required this.sharedPreferences});
  final SharedPreferences sharedPreferences;
  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TasksBloc(storage: Storage(sharedPreferences: sharedPreferences))
            ..add(const StartedTask()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: appRouter.onGenerateRoute,
          home: const TaskScreen()),
    );
  }
}
