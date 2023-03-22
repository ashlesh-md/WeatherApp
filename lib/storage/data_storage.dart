import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: FlutterDemo(storage: CounterStorage()),
    ),
  );
}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;
      // file.delete();

      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return '';
    }
  }

  Future<void> deleteFile() async {
    final file = await _localFile;
    file.delete();
  }

  Future<File> writeCounter(String value) async {
    final file = await _localFile;

    return file.writeAsString(value);
  }
}

class FlutterDemo extends StatefulWidget {
  const FlutterDemo({super.key, required this.storage});

  final CounterStorage storage;

  @override
  State<FlutterDemo> createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  String value = '';
  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        this.value = value;
      });
    });
  }

  Future<File> _incrementCounter() {
    return widget.storage.writeCounter(value);
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading and Writing Files'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Cities : $value',
            ),
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Enter name'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            value = '$value ${controller.text}';
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
