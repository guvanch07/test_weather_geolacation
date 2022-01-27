import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_simple_weather_app/core/utils/ratio.dart';
import 'package:test_simple_weather_app/fetures/bloc/get_weather_bloc.dart';
import 'package:test_simple_weather_app/fetures/data/datasource/remote_datasource.dart';
import 'package:test_simple_weather_app/fetures/data/models/forcast.dart';
import 'package:test_simple_weather_app/fetures/presentation/pages/home_page.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/app_bar.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/date_helper.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/image_helper.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/string_extension.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({
    Key? key,
    // required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherBloc(
        RepositoryProvider.of<WeatherDataSourceImpl>(context),
      )..add(GetApiWeather()),
      child: Scaffold(
        appBar: MyAppBar(
          title: city,
          context: context,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: BlocBuilder<GetWeatherBloc, GetWeatherState>(
                buildWhen: (prev, curr) => prev != curr,
                builder: (context, state) {
                  if (state is GetWeatherLoading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }
                  if (state is GetWeatherError) {
                    return Text(state.error);
                  }
                  if (state is GetWeatherLoaded) {
                    return _ListOfForecast(
                      forecast: state.forecast,
                    );
                  } else {
                    return const Text('smth is wrong');
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListOfForecast extends StatelessWidget {
  const _ListOfForecast({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  final Forecast forecast;

  String _whichIsDay(int ind) {
    if (forecast.daily[ind].dt == DateTime.now().day) {
      return 'TODAY'; //! Hmm dosnt work, must to fix
    } else {
      return getDateFromTimestamp(forecast.daily[ind].dt);
    }
  }

  @override
  Widget build(BuildContext context) {
    final heightRatio = getHeightRatio(context);
    final widthRatio = getWidthRatio(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: forecast.daily.length,
      itemBuilder: (context, ind) {
        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  _whichIsDay(ind),
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              SizedBox(
                  height: heightRatio * 280,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: forecast.hourly.length,
                      itemBuilder: (context, index) {
                        return _ItemOfForecast(
                          index: index,
                          forecast: forecast,
                          heightRatio: heightRatio,
                          widthRatio: widthRatio,
                        );
                      })),
            ],
          ),
        );
      },
    );
  }
}

class _ItemOfForecast extends StatelessWidget {
  const _ItemOfForecast({
    Key? key,
    required this.index,
    required this.heightRatio,
    required this.forecast,
    required this.widthRatio,
  }) : super(key: key);
  final int index;
  final double heightRatio;
  final Forecast forecast;
  final double widthRatio;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightRatio * 70,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            getWeatherIcon(
                icon: forecast.hourly[index].icon,
                height: heightRatio * 80,
                width: widthRatio * 80),
            SizedBox(
              width: widthRatio * 30,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getTimeFromTimestamp(DateTime.now().hour.round() -
                      forecast.hourly[index].dt.round())),
                  SizedBox(
                    height: heightRatio * 8,
                  ),
                  Text(forecast.hourly[index].description.capitalizeFirstOfEach)
                ],
              ),
            ),
            Text(
              "${forecast.hourly[index].temp.toInt()}°",
              style: Theme.of(context).textTheme.headline1,
            )
          ],
        ),
      ),
    );
  }
}

final Decoration selected =
    BoxDecoration(border: Border.all(color: Colors.blueAccent, width: 3));

final Decoration unselected =
    BoxDecoration(border: Border.all(color: Colors.transparent));
