import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultPage extends StatefulWidget {
  final String result;

  const ResultPage({super.key, required this.result});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late TextEditingController textController;
  @override
  void initState() {
    textController = TextEditingController(text: widget.result);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("RESULTS"),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Stack(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 1.3,
                        child: TextFormField(
                            maxLines: 1000,
                            maxLength: 5000,
                            keyboardType: TextInputType.multiline,
                            controller: textController,
                            validator: (val) {
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 20, 20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ))),
                    Positioned(
                      bottom: 25,
                      right: 6,
                      child: InkWell(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: textController.text));
                            const snackBar = SnackBar(
                              content: Text('Copied to Clipboard'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: const Icon(
                            Icons.copy,
                            size: 22,
                            color: Colors.teal,
                          )),
                    ),
                  ],
                )
              ]))),
    );
  }
}
