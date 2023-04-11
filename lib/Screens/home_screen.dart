// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:summize/ApiServices/api_services.dart';
import 'package:summize/Screens/result_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Summize"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 1.4,
                        child: TextFormField(
                            maxLines: 1000,
                            maxLength: 5000,
                            keyboardType: TextInputType.multiline,
                            controller: textController,
                            validator: (val) {
                              if (val!.length < 10) {
                                return "Please write more words!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: "write here",
                            ))),
                    Positioned(
                      top: 15,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          textController.clear();
                        },
                        child: Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal,
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              size: 15,
                              color: Colors.white,
                            )),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {

                      String data = await ApiServices.getSummarize(
                          text: textController.text);
                      
                      
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResultPage(result: data),
                        ));
                      
                     
                    }
                  },
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 57,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        "Summarize",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0),
                      )),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
