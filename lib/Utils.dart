// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:huawei_scan/HmsScanLibrary.dart';

//Color Lists
List<Color> colorList = [
  Colors.white,
  Colors.yellow,
  Colors.red,
  Colors.green,
  Colors.grey,
  Colors.blue,
  Colors.black,
];

List<String> colorStringList = [
  "White",
  "Yellow",
  "Red",
  "Green",
  "Gray",
  "Blue",
  "Black",
];

//Scan Types
List<int> scanTypeList = [
  HmsScanTypes.AllScanType,
  HmsScanTypes.Aztec,
  HmsScanTypes.Code128,
  HmsScanTypes.Code39,
  HmsScanTypes.Code93,
  HmsScanTypes.Codabar,
  HmsScanTypes.DataMatrix,
  HmsScanTypes.EAN13,
  HmsScanTypes.EAN8,
  HmsScanTypes.ITF14,
  HmsScanTypes.QRCode,
  HmsScanTypes.UPCCodeA,
  HmsScanTypes.UPCCodeE,
  HmsScanTypes.Pdf417,
];

List<String> scanTypeStringList = [
  "All Scan Types",
  "Aztec",
  "Code128",
  "Code39",
  "Code93",
  "Codabar",
  "DataMatrix",
  "EAN13",
  "EAN8",
  "ITF14",
  "QRCode",
  "UPCCodeA",
  "UPCCodeE",
  "Pdf417",
];

//Dropdown Controllers
dropdownController(String value) {
  int result = scanTypeStringList.indexOf(value);
  return scanTypeList[result];
}

dropdownColorController(String value) {
  int result = colorStringList.indexOf(value);
  return colorList[result];
}

dropdownControllerBitmap(String value) {
  int result = scanTypeStringList.indexOf(value);
  return scanTypeList[result];
}

//Scan Types for Build Bitmap
List<int> scanTypeListBitmap = [
  HmsScanTypes.Aztec,
  HmsScanTypes.Code128,
  HmsScanTypes.Code39,
  HmsScanTypes.Code93,
  HmsScanTypes.Codabar,
  HmsScanTypes.DataMatrix,
  HmsScanTypes.EAN13,
  HmsScanTypes.EAN8,
  HmsScanTypes.ITF14,
  HmsScanTypes.QRCode,
  HmsScanTypes.UPCCodeA,
  HmsScanTypes.UPCCodeE,
  HmsScanTypes.Pdf417,
];

List<String> scanTypeStringListBitmap = [
  "Aztec",
  "Code128",
  "Code39",
  "Code93",
  "Codabar",
  "DataMatrix",
  "EAN13",
  "EAN8",
  "ITF14",
  "QRCode",
  "UPCCodeA",
  "UPCCodeE",
  "Pdf417",
];

//Scan Type Converter
formatConverter(int format) {
  switch (format) {
    case HmsScanTypes.Code128:
      return "Code128 Code";
    case HmsScanTypes.Code39:
      return "Code39 Code";
    case HmsScanTypes.Code93:
      return "Code93 Code";
    case HmsScanTypes.Codabar:
      return "Codabar Code";
    case HmsScanTypes.DataMatrix:
      return "Data Matrix Code";
    case HmsScanTypes.EAN13:
      return "EAN13 Code";
    case HmsScanTypes.EAN8:
      return "EAN8 Code";
    case HmsScanTypes.ITF14:
      return "ITF14 Code";
    case HmsScanTypes.QRCode:
      return "QR Code";
    case HmsScanTypes.UPCCodeA:
      return "UPC Code - A";
    case HmsScanTypes.UPCCodeE:
      return "UPC Code - E";
    case HmsScanTypes.Pdf417:
      return "Pdf417 Code";
    case HmsScanTypes.Aztec:
      return "Aztec Code";
  }
}

//Result Type Converter
resultTypeConverter(int type) {
  switch (type) {
    case HmsScanForm.ContactDetailForm:
      return "Contact";
    case HmsScanForm.EmailContentForm:
      return "Email";
    case HmsScanForm.ISBNNumberForm:
      return "ISBN";
    case HmsScanForm.TelPhoneNumberForm:
      return "Tel";
    case HmsScanForm.ArticleNumberForm:
      return "Product";
    case HmsScanForm.SMSForm:
      return "SMS";
    case HmsScanForm.PureTextForm:
      return "Text";
    case HmsScanForm.UrlForm:
      return "Website";
    case HmsScanForm.WIFIConnectInfoForm:
      return "WIFI";
    case HmsScanForm.LocationCoordinateForm:
      return "Location";
    case HmsScanForm.EventInfoForm:
      return "Event";
    case HmsScanForm.DriverInfoForm:
      return "License";
  }
}