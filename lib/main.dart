import 'package:cubit_code_lab/presentation/ui/routes/route_names.dart';
import 'package:cubit_code_lab/presentation/ui/routes/router.dart';
import 'package:flutter/material.dart';

void main() {
  /**
      final res = await GetAllUseCase(RepositoryImp(ApiService())).invoke((message) => {
      print('DATA : main:  $message')});
      print('DATA : main:  $res');
   **/

  runApp(BaseApp(appRouter: AppRouter()));
}

class BaseApp extends StatelessWidget {
  AppRouter appRouter;
  BaseApp({super.key,required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesNames.charactersRoute,
      routes: appRouter.getRoutes(),
    );
  }
}
