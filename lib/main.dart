import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test/bloc/test/test_bloc.dart';
import 'package:test/widgets/base_loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();

    DefaultCacheManager().emptyCache().then((value) {
      log('Cache cleared');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestBloc, TestState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: SvgPicture.asset('assets/svg/sheep_1.svg'),
              ),
              body: SizedBox.expand(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => _onPressed(context),
                    child: const Text("Get Data"),
                  ),
                ),
              ),
            ),
            BaseLoadingScreen(isLoading: state.isLoading),
          ],
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    context.read<TestBloc>().add(
          TestEvent.fetch(context),
        );
  }
}
