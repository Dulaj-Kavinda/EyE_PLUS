// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:huawei_ml/langdetection/ml_lang_detector.dart';
import 'package:huawei_ml/langdetection/ml_lang_detector_setting.dart';
import 'package:huawei_ml/translate/ml_local_translator.dart';
import 'package:huawei_ml/translate/ml_translate_setting.dart';
import 'package:eye_plus/Services.dart';

class TranslateScreen extends StatefulWidget {
  @override
  _TranslateScreenState createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();
  late String sourceLanguageCode;
  String _translateResult = "Translation result will be here";
  String _detectedResult = "Detected language will be here";
  String _detectedLanCode = "Detected language Code will be here";

  @override
  void initState() {
    super.initState();
    setApiKey();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Translate"),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(.6)),
                    color: Colors.white),
                child: TextField(
                  autofocus: false,
                  controller: controller,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      labelText: "Source text goes here",
                      border: InputBorder.none),
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ElevatedButton(
                  child: const Text("Start Translation"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => {onClickDetect(), onClickTranslate()},
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Text("Detected Language : "),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(.6)),
                  color: Colors.white),
              child: Text(_detectedResult),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Text("Translated Text : "),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(.6)),
                  color: Colors.white),
              child: Text(_translateResult),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> onClickDetect() async {
    MLLangDetector detector = MLLangDetector();
    MLLangDetectorSetting setting = MLLangDetectorSetting();
    setting.sourceText = controller.text;
    setting.isRemote = true;
    String lgResult = await detector.firstBestDetect(setting: setting);
    setState(() {
      _detectedResult = setting.sourceText + " : " + lgResult;
      _detectedLanCode = lgResult;
    });
  }

  Future<void> onClickTranslate() async {
    MLLocalTranslator translator = MLLocalTranslator();
    MLTranslateSetting settingTranslate = MLTranslateSetting();
    settingTranslate.sourceLangCode = "en";
    settingTranslate.targetLangCode = "hi";
    final isPrepared = await translator.prepareModel(setting: settingTranslate);
    if (isPrepared) {
      String result =
          await translator.asyncTranslate(sourceText: controller.text);
      setState(() {
        _translateResult = result.toString();
      });
    }
    bool result = await translator.stopTranslate();
  }
}
