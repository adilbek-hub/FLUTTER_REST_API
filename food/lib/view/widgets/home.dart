import 'package:flutter/material.dart';
import 'package:food/view/widgets/resipe_card.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.restaurant_menu),
            const SizedBox(width: 10),
            Text(widget.text),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ResipeCard(),
        ],
      ),
    );
  }
}
