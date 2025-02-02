import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test/cache/cache_manager.dart';
import 'package:test/model/response_model.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Add your navigation logic here
              },
              child: const Text('Next'),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = mock[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: ResultItem(url: item.file.url),
                );
              },
              itemCount: mock.length,
            ),
          ],
        ),
      ),
    );
  }
}

class ResultItem extends StatefulWidget {
  final String url;

  const ResultItem({
    super.key,
    required this.url,
  });

  @override
  State<ResultItem> createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  late final Future<File> _file;

  @override
  void initState() {
    super.initState();
    _file = CacheManager.getFile(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _file,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!.readAsBytesSync());
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
