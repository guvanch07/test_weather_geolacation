import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_simple_weather_app/fetures/bloc/get_weather_bloc.dart';
import 'package:test_simple_weather_app/fetures/bloc/location.dart';
import 'package:test_simple_weather_app/fetures/presentation/pages/home_page.dart';
import 'package:test_simple_weather_app/theme.dart';

import 'fetures/data/datasource/remote_datasource.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => WeatherDataSourceImpl())
      ],
      child: ChangeNotifierProvider(
        create: (context) => LocationPoint(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
