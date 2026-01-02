import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 
import 'package:provider/provider.dart'; 

import 'state/quiz_controller.dart'; 
import 'ui/screens/home_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const BilGecApp());
}

class BilGecApp extends StatelessWidget {
  const BilGecApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BilGeç',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          useMaterial3: true,
        ),
        home: HomeScreen(), 
      ),
    );
  }
}