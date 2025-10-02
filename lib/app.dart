import 'package:flutter/material.dart';
import 'package:learning_bloc_1/app_router.dart';
import 'package:learning_bloc_1/features/home/view/home_page.dart';

class App extends StatelessWidget {
  final AppRouter appRouter;
  const App({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(),
      onGenerateRoute: (settings) => appRouter.onGenerateRoute(settings),
    );
  }
}
