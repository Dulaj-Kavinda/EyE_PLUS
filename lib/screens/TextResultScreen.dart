// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eye_plus/screens/HomeScreen.dart';

class TextResultScreen extends StatelessWidget {
  final String recognitionResult;

  const TextResultScreen({required this.recognitionResult});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Recognized Results"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 15,
            child: Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      width: .5,
                      color: Colors.black.withOpacity(.5),
                      style: BorderStyle.solid)),
              child: SelectableText(
                recognitionResult,
                toolbarOptions: const ToolbarOptions(
                  copy: true,
                  selectAll: true,
                ),
                showCursor: true,
                cursorWidth: 2,
                cursorColor: Colors.grey,
                cursorRadius: const Radius.circular(5)
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "HOME",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18.0),
                          ))
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: recognitionResult));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.content_copy,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "COPY TEXT",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18.0),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    ));
  }
}
