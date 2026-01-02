import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/quiz_controller.dart';
import 'ui/screens/home_screen.dart';

void main() {
  runApp(const BilGecApp());
}

class BilGecApp extends StatelessWidget {
  const BilGecApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuizController(), 
        ),
      ],
      child: MaterialApp(
        title: 'BilGeç MVP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          fontFamily: 'Roboto', 
        ),
        home: HomeScreen(),
      ),
    );
  }
}