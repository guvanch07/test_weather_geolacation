import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

import 'package:test_simple_weather_app/core/utils/ratio.dart';
import 'package:test_simple_weather_app/fetures/bloc/get_weather_bloc.dart';
import 'package:test_simple_weather_app/fetures/data/datasource/remote_datasource.dart';
import 'package:test_simple_weather_app/fetures/data/models/forcast.dart';
import 'package:test_simple_weather_app/fetures/data/models/location.dart';
import 'package:test_simple_weather_app/fetures/presentation/pages/home_page.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/app_bar.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/date_helper.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/image_helper.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/string_extension.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherBloc(
        dataSourceImpl: RepositoryProvider.of<WeatherDataSourceImpl>(context),
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

class _ListOfForecast extends StatefulWidget {
  const _ListOfForecast({
    Key? key,
    required this.forecast,
  }) : super(key: key);
  final Forecast forecast;

  @override
  State<_ListOfForecast> createState() => _ListOfForecastState();
}

class _ListOfForecastState extends State<_ListOfForecast> {
  int isSelected = 1;

  String _whichIsDay(int ind) {
    if (widget.forecast.daily[ind].dt == DateTime.now().day) {
      return 'TODAY'; //! Hmm dosnt work, how to fix
    } else {
      return getDateFromTimestamp(widget.forecast.daily[ind].dt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.forecast.daily.length,
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
                  height: 500,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.forecast.hourly.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected = index + 1;
                            });
                          },
                          child: _ItemOfForecast(
                            index: index,
                            isSelected: isSelected,
                            forecast: widget.forecast,
                          ),
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
    required this.isSelected,
    required this.forecast,
  }) : super(key: key);
  final int index;
  final int isSelected;
  final Forecast forecast;

  //int isSelected = 1;

  @override
  Widget build(BuildContext context) {
    final heightRatio = getHeightRatio(context);
    final widthRatio = getWidthRatio(context);
    return Container(
      height: heightRatio * 70,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
              color: index + 1 == isSelected
                  ? Colors.blueAccent
                  : Colors.transparent,
              width: 3)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
