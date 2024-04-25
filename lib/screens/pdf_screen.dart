import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';
import 'package:internet_file/internet_file.dart';

import '../services/user_profile.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({Key? key}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late PdfControllerPinch _pdfControllerPinch;
  final UserProfileController userProfileController = Get.find();

  @override
  void initState() {
     userProfileController.fetchPdf();
    _pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openData(
        InternetFile.get(
         userProfileController.pdfModel.value.data?.first.file ?? "",
        ),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _pdfControllerPinch.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("pdf viewer called..");

    return Scaffold(
     
      body: Container(
          // width: SCREEN_WIDTH(context),
          // height: SCREEN_HEIGHT(context),
         
          child: PdfViewPinch(
              builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
                options: const DefaultBuilderOptions(),
                documentLoaderBuilder: (_) => Center(
                    child: CircularProgressIndicator(
                        color: Colors.white)),
                pageLoaderBuilder: (_) => Center(
                    child: CircularProgressIndicator(
                        color: Colors.white)),
                errorBuilder: (_, error) =>
                    Center(child: Text(error.toString())),
              ),
              controller: _pdfControllerPinch,
              padding: 0),
      ),
    );
  }
}
