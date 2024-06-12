import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myapp/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  EasyLoading.instance
    ..dismissOnTap = false
    ..backgroundColor = Colors.green.withOpacity(0.5)
    ..maskColor = Colors.green.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.black
    ..indicatorColor = Colors.green
    ..indicatorType = EasyLoadingIndicatorType.pulse;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        builder: EasyLoading.init(),
        home: const Login());
  }
}
