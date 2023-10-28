import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/app_layout.dart';
import 'package:movies_app/ui/cubit/app_cubit.dart';
import 'package:movies_app/utils/theme.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AppLayoutViewModel>(create: (context) => AppLayoutViewModel()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: app_layout(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
