import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trex_run/screens/home/bloc/home_bloc.dart';
import 'package:trex_run/screens/trex_game/trex_game_screen.dart';
import 'package:trex_run/service_locator.dart';

import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'TRex Run',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/play': (context) => const TRexGameScreen(),
        },
      ),
    );
  }
}
