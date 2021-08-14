import 'package:flutter/material.dart';
import 'package:zam_built_in_clipboard/zam_built_in_clipboard.dart';
import 'package:zam_clipboard/zam_clipboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clipboard Example',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Clipboard Example'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _textEditingController;
  late final BuiltInClipboard _clipboard;
  String _pastedText = '';

  void _copy() async {
    final data = ClipboardData(_textEditingController.value.text);
    await _clipboard.setData(data);
    _pastedText = 'Text Copied';
    setState(() {});
  }

  void _paste() async {
    _pastedText = await _clipboard.getData().then((data) => data.text);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _clipboard = BuiltInClipboard();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      labelText: 'Enter text to be copied',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      backgroundColor: Colors.white10,
                      textStyle: Theme.of(context).textTheme.bodyText2,
                    ),
                    onPressed: () => _copy(),
                    child: const Text('Copy'),
                  ),
                  const SizedBox(width: 40),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      backgroundColor: Colors.white10,
                      textStyle: Theme.of(context).textTheme.bodyText2,
                    ),
                    onPressed: () => _paste(),
                    child: const Text('Paste'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                _pastedText,
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
