import 'package:flutter/material.dart';
import 'package:simple_formatted_text/simple_formatted_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Formatted Text Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Simple Formatted Text Demo'),
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
  final TextEditingController _controller = TextEditingController();
  String _text = "This is an *EXAMPLE* of a [big](addSize:4, color:#FFFF0000) ~[small](subSize:2)~ /_Widget_/";

  @override
  void initState() {
    _controller.text = _text;
    super.initState();
  }

  void _updateText() {
    setState(() {
      _text = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 600,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (value) => _updateText(),
                      decoration: const InputDecoration(label: Text("Insert your test text")),
                    ),
                  ),
                  IconButton(onPressed: _updateText, icon: const Icon(Icons.send)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SimpleFormattedText(_text),
            const SizedBox(height: 20),
            SimpleFormattedText(
              _text,
              linkTextStyle: TextStyle(color: Colors.green),
            ),
            const SizedBox(height: 20),
            SimpleFormattedText(
              _text,
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
