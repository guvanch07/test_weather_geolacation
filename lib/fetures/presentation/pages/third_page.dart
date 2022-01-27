import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_simple_weather_app/fetures/bloc/bloc/geolocation_bloc.dart';
import 'package:test_simple_weather_app/fetures/data/datasource/base.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GeolocationBloc, GeolocationState>(
        builder: (context, state) {
          if (state is GeolocationLoading) {
            return const CircularProgressIndicator.adaptive();
          } else if (state is GeolocationLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(state.position.latitude.toString()),
                  ),
                  Center(
                    child: Text(state.position.longitude.toString()),
                  ),
                ],
              ),
            );
          }
          if (state is GeolocationLoadedCity) {
            return Text(state.city);
          } else {
            return const Text('');
          }
        },
      ),
    );
  }
}
