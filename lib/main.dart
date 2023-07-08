import 'package:cubit_code_lab/presentation/ui/routes/route_names.dart';
import 'package:cubit_code_lab/presentation/ui/routes/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BaseApp());
}

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesNames.charactersRoute,
      routes: routes,
    );
  }
}
