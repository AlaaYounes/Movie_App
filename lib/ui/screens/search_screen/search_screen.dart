import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/cubit/app_cubit.dart';
import 'package:movies_app/ui/cubit/app_states.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLayoutViewModel, AppStates>(
      builder: (context, state) => Container(
        color: Colors.green,
      ),
    );
  }
}
