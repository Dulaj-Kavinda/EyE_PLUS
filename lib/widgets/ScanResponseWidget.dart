// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:eye_plus/Utils.dart';

class ScanResponseWidget extends StatelessWidget {
  final int codeFormat;
  final int resultType;
  final String result;
  final bool isMulti;

  ScanResponseWidget({required this.codeFormat, required this.result, required this.resultType, required this.isMulti});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color.fromRGBO(247, 242, 241, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
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
                      "Code Format",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Text(formatConverter(codeFormat)),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 4.0),
                    child: Text("Result Type",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
              Text(resultTypeConverter(resultType)),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 4.0),
                    child: Text("Result",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
              SelectableText(
                  result,
                  toolbarOptions: const ToolbarOptions(
                    copy: true,
                    selectAll: true,
                  ),
                  showCursor: true,
                  cursorWidth: 2,
                  cursorColor: Colors.grey,
                  cursorRadius: const Radius.circular(5)
              ),
              isMulti != false
                  ? const SizedBox(
                height: 16.0,
              )
                  : const SizedBox(
                height: 150.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}