import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_selector/controller.dart';

void main() {
  runApp(const MainApp());
}

Color getRandomColor() {
  return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
      .withOpacity(1.0);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Controller(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getRandomColor(),
      body: Center(
        child: Wrap(
          children: List.generate(
            20,
            (index) => CounterWidget(index: index),
          ),
        ),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final int index;
  const CounterWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final count =
        context.select((Controller controller) => controller.counters[index]);
    return Container(
      width: 100,
      height: 100,
      color: getRandomColor(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(count.toString()),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => context.read<Controller>().incrementCounter(index),
                child: Icon(Icons.add),
              ),
              InkWell(
                onTap: () => context.read<Controller>().decrementCounter(index),
                child: Builder(builder: (context) {
                  if (index == 0) {
                    context.watch<Controller>();
                  }
                  return Icon(
                    Icons.remove,
                    color: getRandomColor(),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
