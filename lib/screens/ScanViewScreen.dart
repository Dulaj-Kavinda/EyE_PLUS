// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_scan/hmsScanUtils/DefaultViewRequest.dart';
import 'package:huawei_scan/hmsScanUtils/HmsScanUtils.dart';
import 'package:huawei_scan/model/ScanResponse.dart';
import 'package:huawei_scan/utils/HmsScanErrors.dart';
import 'package:huawei_scan/utils/HmsScanTypes.dart';
import 'package:eye_plus/widgets/ScanResponseWidget.dart';

class ScanViewScreen extends StatefulWidget {

  @override
  _ScanViewScreenState createState() => _ScanViewScreenState();
}

class _ScanViewScreenState extends State<ScanViewScreen> {
  late String resultScan;
  late int codeFormatScan;
  late int resultTypeScan;

  @override
  void initState() {
    super.initState();
    defaultView();
  }

  defaultView() async{
    try {
      DefaultViewRequest request = DefaultViewRequest(scanType: HmsScanTypes.AllScanType);

      ScanResponse response = await HmsScanUtils.startDefaultView(request); //.timeout(const Duration(seconds: 3))

      setState(() {
        resultScan = response.originalValue!;
        codeFormatScan = response.scanType!;
        resultTypeScan = response.scanTypeForm!;
      });

    } on PlatformException catch (err) {
      if (err.code == HmsScanErrors.scanUtilNoCameraPermission.errorCode) {
        debugPrint(HmsScanErrors.scanUtilNoCameraPermission.errorMessage);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanned Results"),
      ),
      body: resultScan == null
          ? AlertDialog(
        content: const Text("Please scan a valid barcode."),
        actions: [
          ElevatedButton(
              child: const Text("Back"),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      )
          : SingleChildScrollView(
          child: ScanResponseWidget(
            isMulti: false,
            codeFormat: codeFormatScan,
            result: resultScan,
            resultType: resultTypeScan,
          )
      ),
    );
  }
}