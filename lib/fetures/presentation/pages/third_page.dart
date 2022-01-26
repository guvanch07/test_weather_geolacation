import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_simple_weather_app/fetures/bloc/bloc/geolocation_bloc.dart';
import 'package:test_simple_weather_app/fetures/data/datasource/base.dart';
import 'package:test_simple_weather_app/main.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeolocationBloc(geoRepo: context.read<GeoRepo>())
        ..add(LoadGeolocation()),
      child: Scaffold(
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
            } else {
              return const Text('');
            }
          },
        ),
      ),
    );
  }
}
