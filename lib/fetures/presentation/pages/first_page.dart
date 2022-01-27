import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import 'package:test_simple_weather_app/core/utils/ratio.dart';
import 'package:test_simple_weather_app/fetures/bloc/get_weather_bloc.dart';
import 'package:test_simple_weather_app/fetures/data/datasource/remote_datasource.dart';
import 'package:test_simple_weather_app/fetures/data/models/weather.dart';
import 'package:test_simple_weather_app/fetures/presentation/pages/home_page.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/app_bar.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/details.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/dotted_line.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/image_helper.dart';
import 'package:test_simple_weather_app/fetures/presentation/widgets/string_extension.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({
    Key? key,
    //required this.location,
  }) : super(key: key);
  //final LocationWB location;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetWeatherBloc(RepositoryProvider.of<WeatherDataSourceImpl>(context))
            ..add(
              GetApiWeather(),
            ),
      child: Scaffold(
        appBar: MyAppBar(
          title: "Today",
          context: context,
        ),
        body: SafeArea(
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
                return Column(
                  children: <Widget>[
                    _CurrentWeater(
                      current: state.current,
                    ),
                    _DetailesWidgets(
                      current: state.current,
                    ),
                    _Share(
                      current: state.current,
                    )
                  ],
                );
              } else {
                return const Text('smth is wrong');
              }
            },
          ),
        ),
      ),
    );
  }
}

class _CurrentWeater extends StatelessWidget {
  const _CurrentWeater({
    Key? key,
    required this.current,
    //required this.location,
  }) : super(key: key);
  final Weather current;
  //final LocationWB location;

  @override
  Widget build(BuildContext context) {
    final heightRatio = getHeightRatio(context);
    final widthRatio = getWidthRatio(context);
    return Column(
      children: [
        DottedLine(
          direction: Axis.horizontal,
          lineLength: double.infinity,
          lineThickness: 2.0,
          dashGradient: const [
            Colors.red,
            Colors.blue,
          ],
        ),
        SizedBox(height: heightRatio * 40),
        getWeatherIcon(
            icon: current.icon,
            height: heightRatio * 150,
            width: widthRatio * 150),
        SizedBox(height: heightRatio * 15),
        Text(
          "${city.capitalizeFirstOfEach}, ${country.capitalizeFirstOfEach}",
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(height: heightRatio * 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${current.temp.toInt()}°C",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 25,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.normal),
            ),
            //Divider(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 25,
              width: 2,
              color: Colors.blueAccent,
            ),
            Text(
              current.description.capitalizeFirstOfEach,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 22,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.normal),
            )
          ],
        )
      ],
    );
  }
}

class _DetailesWidgets extends StatelessWidget {
  const _DetailesWidgets({
    Key? key,
    required this.current,
  }) : super(key: key);
  final Weather current;

  @override
  Widget build(BuildContext context) {
    final widthRatio = getWidthRatio(context);
    final heightRatio = getHeightRatio(context);
    return Column(
      children: [
        SizedBox(
          height: heightRatio * 50,
        ),
        DottedLineHelper(
          widthRatio: widthRatio * 200,
        ),
        SizedBox(
          height: heightRatio * 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DetailsHelper(
                text: "${current.humidity.toInt()} %",
                icon: Icons.cloud_outlined),
            DetailsHelper(
                text: "${current.high.toInt()} mm", icon: CupertinoIcons.drop),
            DetailsHelper(
                text: "${current.pressure}hPa",
                icon: CupertinoIcons.thermometer),
          ],
        ),
        SizedBox(
          height: heightRatio * 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DetailsHelper(
                text: "${current.wind} km/h", icon: CupertinoIcons.wind),
            DetailsHelper(
                text: "${current.feelsLike.toInt()}°",
                icon: CupertinoIcons.slash_circle),
          ],
        ),
        SizedBox(
          height: heightRatio * 30,
        ),
        DottedLineHelper(
          widthRatio: widthRatio * 200,
        ),
        SizedBox(
          height: heightRatio * 60,
        ),
      ],
    );
  }
}

class _Share extends StatelessWidget {
  const _Share({
    Key? key,
    required this.current,
  }) : super(key: key);
  final Weather current;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Share.share(
            "${current.temp.toInt()}°,${city.capitalizeFirstOfEach}, ${country.capitalizeFirstOfEach}");
      },
      child: Text(
        'Share',
        style: Theme.of(context).textTheme.headline2!.copyWith(
            color: Colors.red, fontWeight: FontWeight.normal, fontSize: 22),
      ),
    );
  }
}
