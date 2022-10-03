// ignore_for_file: file_names

import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_ml/classification/ml_classification_analyzer.dart';
import 'package:huawei_ml/classification/ml_classification_analyzer_setting.dart';
import 'package:huawei_ml/landmark/ml_landmark_analyzer.dart';
import 'package:huawei_ml/landmark/ml_landmark_analyzer_setting.dart';
import 'package:huawei_ml/models/ml_image_classification.dart';
import 'package:huawei_ml/models/ml_landmark.dart';
import 'package:huawei_ml/models/ml_text.dart';
import 'package:huawei_ml/text/ml_text_analyzer.dart';
import 'package:huawei_ml/text/ml_text_analyzer_setting.dart';
import 'package:huawei_scan/hmsScanPermissions/HmsScanPermissions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eye_plus/screens/ImageClassificationResultScreen.dart';
import 'package:eye_plus/screens/ScanViewScreen.dart';
import 'package:eye_plus/screens/TranslateScreen.dart';
import 'package:eye_plus/widgets/ReusableOptionButton.dart';
import 'package:eye_plus/screens/TextResultScreen.dart';
import 'package:eye_plus/screens/LandmarkResultScreen.dart';
import 'package:eye_plus/Services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .3,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/header.png'),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  Container(
                    height: 62,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const <Widget>[
                              Text(
                                '꓄ꂦꂦ꒒ꌗ +',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 3,
                                    fontSize: 40
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 15,
                      crossAxisCount: 2,
                      children: <Widget>[
                        //Text Recognition
                        CupertinoButton(
                          onPressed: () {
                            MLTextAnalyzer analyzer=MLTextAnalyzer();
                            MLTextAnalyzerSetting setting= MLTextAnalyzerSetting();
                            String _recognitionResult = "Result will be shown here.";

                            _startRecognition(String path) async {
                              setting.path = path;
                              setting.isRemote = true;
                              setting.language = "en";
                              setting.languageList = ["en"];
                              try {
                                MLText text = await analyzer.asyncAnalyzeFrame(setting);
                                setState(() {
                                  _recognitionResult = text.stringValue;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TextResultScreen(recognitionResult: _recognitionResult),
                                    ),
                                  );
                                });
                              } on Exception catch (e) {
                                print(e.toString());
                              }
                            }

                            checkPermission();
                            setApiKey();

                            showCupertinoDialog(
                              context: context,
                              builder: (BuildContext context) => BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: CupertinoAlertDialog(
                                  insetAnimationCurve: Curves.easeInCubic,
                                  actions: <Widget>[
                                    ReusableOptionButton(
                                      action_text: "USE CAMERA",
                                      button_color: Colors.brown,
                                      icon: Icons.camera_alt,
                                      onPressed: () async {
                                        final String path = await getImage(ImageSource.camera);
                                        _startRecognition(path);
                                      },
                                    ),
                                    ReusableOptionButton(
                                      action_text: "PICK FROM GALLERY",
                                      button_color: Colors.orangeAccent.shade400,
                                      icon: Icons.add_photo_alternate_sharp,
                                      onPressed: () async {
                                        final String path = await getImage(ImageSource.gallery);
                                        _startRecognition(path);
                                      },
                                    ),
                                    ReusableOptionButton(
                                      action_text: "",
                                      button_color: Colors.black26,
                                      icon: Icons.cancel_outlined,
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/text_recognition.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 125, 0, 0),
                              child: const Text(
                                "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ),
                        //Language Translation
                        CupertinoButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TranslateScreen(),
                                ),
                              );
                            });
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/language_translator.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                              child: const Text(
                                "Translate",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        //Landmark Recognition
                        CupertinoButton(
                          onPressed: () async {
                            MLLandmarkAnalyzerSetting settings = MLLandmarkAnalyzerSetting();
                            setApiKey();
                            checkPermission();

                            _startLandmarkRecognition(String path) async {
                              try {
                                settings.patternType = MLLandmarkAnalyzerSetting.STEADY_PATTERN;
                                settings.largestNumberOfReturns = 8;
                                settings.path=path;

                                MLLandmarkAnalyzer analyzer = MLLandmarkAnalyzer();
                                List<MLLandmark> landmarks= await analyzer.asyncAnalyzeFrame(settings);

                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LandmarkResultScreen(landmarks: landmarks),
                                    ),
                                  );
                                });

                                bool result = await analyzer.stopLandmarkDetection();

                              } on Exception catch (e) {
                                print(e.toString());
                              }

                            }

                            showCupertinoDialog(
                              context: context,
                              builder: (BuildContext context) => BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: CupertinoAlertDialog(
                                  insetAnimationCurve: Curves.easeInCubic,
                                  actions: <Widget>[
                                    ReusableOptionButton(
                                      action_text: "USE CAMERA",
                                      button_color: Colors.brown,
                                      icon: Icons.camera_alt,
                                      onPressed: () async {
                                        final String path = await getImage(ImageSource.camera);
                                        _startLandmarkRecognition(path);
                                      },
                                    ),
                                    ReusableOptionButton(
                                      action_text: "PICK FROM GALLERY",
                                      button_color: Colors.orangeAccent.shade400,
                                      icon: Icons.add_photo_alternate_sharp,
                                      onPressed: () async {
                                        final String path = await getImage(ImageSource.gallery);
                                        _startLandmarkRecognition(path);
                                      },
                                    ),
                                    ReusableOptionButton(
                                      action_text: "",
                                      button_color: Colors.black26,
                                      icon: Icons.cancel_outlined,
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/landmark.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                              child: const Text(
                                "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ),
                        //Barcode/QR Code Scanner
                        CupertinoButton(
                          onPressed: () async {
                            String permissionState = "Permissions Are Not Granted.";
                            bool hmsLoggerStatus = true;

                            bool? permissionResult = await HmsScanPermissions.hasCameraAndStoragePermission();
                            if (permissionResult == false) {
                              await HmsScanPermissions.requestCameraAndStoragePermissions();
                            } else {
                              permissionState = "All Permissions Are Granted";
                            }

                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScanViewScreen(),
                                ),
                              );
                            });


                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/barcode_qr.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                              child: const Text(
                                "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ),
                        //Image Classifier
                        CupertinoButton(
                          onPressed: () {
                            String _name = " ";
                            File _imageFile;

                            MLClassificationAnalyzer mlClassificationAnalyzer=MLClassificationAnalyzer();
                            MLClassificationAnalyzerSetting mlClassificationAnalyzerSetting= MLClassificationAnalyzerSetting();

                            _startClassification(String path) async {
                              mlClassificationAnalyzerSetting.path = path;
                              mlClassificationAnalyzerSetting.isRemote = true;
                              mlClassificationAnalyzerSetting.largestNumberOfReturns = 6;
                              mlClassificationAnalyzerSetting.minAcceptablePossibility = 0.5;
                              try {
                                List<MLImageClassification> list = await mlClassificationAnalyzer
                                    .asyncAnalyzeFrame(mlClassificationAnalyzerSetting);
                                if (list.isNotEmpty) {
                                  setState(() {
                                    _name = list.first.name;
                                    _imageFile = File(path);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ImageClassificationResultScreen(name: _name, imageFile: _imageFile),
                                      ),
                                    );
                                  });
                                }
                              } on Exception catch (er) {
                                print(er.toString());
                              }
                            }

                            checkPermission();
                            setApiKey();

                            showCupertinoDialog(
                              context: context,
                              builder: (BuildContext context) => BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: CupertinoAlertDialog(
                                  insetAnimationCurve: Curves.easeInCubic,
                                  actions: <Widget>[
                                    ReusableOptionButton(
                                      action_text: "USE CAMERA",
                                      button_color: Colors.brown,
                                      icon: Icons.camera_alt,
                                      onPressed: () async {
                                        final String path = await getImage(ImageSource.camera);
                                        setState(() {
                                          _imageFile = File(path);
                                        });
                                        _startClassification(path);
                                      },
                                    ),
                                    ReusableOptionButton(
                                      action_text: "PICK FROM GALLERY",
                                      button_color: Colors.orangeAccent.shade400,
                                      icon: Icons.add_photo_alternate_sharp,
                                      onPressed: () async {
                                        final String path = await getImage(ImageSource.gallery);
                                        setState(() {
                                          _imageFile = File(path);
                                        });
                                        _startClassification(path);
                                      },
                                    ),
                                    ReusableOptionButton(
                                      action_text: "",
                                      button_color: Colors.black26,
                                      icon: Icons.cancel_outlined,
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/classification.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 65, 0, 0),
                              child: const Text(
                                "ᴄʟᴀssɪғʏ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        //Exit
                        CupertinoButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/exit.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                              child: const Text(
                                "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: size.height * .125,
          decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                image: AssetImage('assets/footer.png'),
              )
          ),
        ),
      ),
    );
  }
}