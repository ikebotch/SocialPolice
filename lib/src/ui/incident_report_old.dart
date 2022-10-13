import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialpolice/src/model/account.dart';
import 'package:socialpolice/src/model/service.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/res/enums.dart';
import 'package:socialpolice/src/settings/secured_storage.dart';
import 'package:socialpolice/src/ui/components/header.dart';
import 'package:socialpolice/src/ui/components/two_row_text.dart';
import 'package:socialpolice/src/ui/preview_report_crime.dart';
import 'package:socialpolice/src/utils/utils_upload.dart';

class IncidentReportOld extends StatefulWidget {
  final Account? account;
  final String serviceType;
  final SecuredStorage? securedStorage;
  const IncidentReportOld({
    Key? key,
    this.account,
    required this.serviceType,
    this.securedStorage,
  }) : super(key: key);

  @override
  State<IncidentReportOld> createState() => _IncidentReportOldState();
}

class _IncidentReportOldState extends State<IncidentReportOld> {
  final TextEditingController _controller = TextEditingController();
  List<String> items = [];
  File? _selectedFile;

  init() {
    for (var sub in widget.account!.subService) {
      if (widget.serviceType == sub.servicename) {
        SubService subServices = sub;
        items.add(subServices.subservicename);
      }
    }
    selectedItem = items[0];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  var selectedItem = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              title: 'Incident Report',
              actionTitle: 'Next',
              action: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviewReportCrime(
                    incidentType: selectedItem,
                    desc: _controller.text,
                    img: _selectedFile!,
                    account: widget.account,
                    serviceType: widget.serviceType,
                    securedStorage: widget.securedStorage,
                  ),
                ),
              ),
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Incident Details',
                style: GoogleFonts.redHatDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            _media(),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Incident Type',
                style: GoogleFonts.redHatDisplay(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: dropBoxOutlineInputBorder(),
                  focusedBorder: dropBoxOutlineInputBorder(),
                ),
                value: selectedItem,
                items: items
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    )
                    .toList(),
                onChanged: (itemm) {
                  setState(() {
                    selectedItem = itemm!;
                  });
                },
              ),
            ),
            const TwoRowText(
              leftTitle: 'Description',
              rightTitle: '600/1200',
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                color: AppColors.colorBorderGrey4,
              ),
              child: TextFormField(
                controller: _controller,
                maxLines: null,
                minLines: 6,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DottedBorder dropFile() {
    return DottedBorder(
      color: AppColors.colorPrimary,
      dashPattern: const [8, 4],
      child: Container(
        height: 121,
        width: double.infinity,
        color: AppColors.colorBlue2,
        child: Center(
          child: Text(
            'Drop files here to upload…',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder dropBoxOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 1, color: AppColors.colorPrimary),
    );
  }

  Widget _media() {
    return Container(
      child: _selectedFile != null
          ? Stack(
              // fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _selectedFile!,
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () async {
                  _selectedFile = await UtilsUpload.pickImage(
                    source: CameraType.GALLERY,
                  );
                  setState(() {});
                },
                child: dropFile(),
              ),
            ),
    );
  }
}
