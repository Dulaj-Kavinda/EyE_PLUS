// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huawei_ml/models/ml_landmark.dart';
import 'package:eye_plus/screens/HomeScreen.dart';

class LandmarkResultScreen extends StatelessWidget {
  final List<MLLandmark> landmarks;

  const LandmarkResultScreen({required this.landmarks});

  @override
  Widget build(BuildContext context) {
    MLLandmark landmark=landmarks.first;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Recognized Landmark"),
      ),
      body:
      landmarks.isEmpty
          ? AlertDialog(
              content: const Text("Landmark is Invalid, Try a Different View."),
              actions: [
                ElevatedButton(
                    child: const Text("Back"),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: const Color.fromRGBO(247, 242, 241, 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 4.0),
                            child: Text(
                              "Landmark",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Text(landmark.landmark),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 4.0),
                            child: Text("Possibility",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ],
                      ),
                      Text(landmark.possibility.toString()),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 4.0),
                            child: Text("Bottom Corner",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ],
                      ),
                      Text(landmark.border.bottom.toString()),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 4.0),
                            child: Text("Top Corner",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ],
                      ),
                      Text(landmark.border.top.toString()),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 4.0),
                            child: Text("Left Corner",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ],
                      ),
                      Text(landmark.border.left.toString()),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 4.0),
                            child: Text("Right Corner",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ],
                      ),
                      Text(landmark.border.right.toString()),
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                                Navigator.pop(context, 'OK');
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
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "BACK",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500, fontSize: 18.0),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                  ),
                ),
              ),
            ),
    ));
  }
}
