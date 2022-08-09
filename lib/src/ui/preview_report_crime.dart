import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/ui/components/header.dart';
import 'package:socialpolice/src/ui/components/two_row_text.dart';

class PreviewReportCrime extends StatefulWidget {
  String incidentType;
  String desc;
  String img;
  PreviewReportCrime({
    Key? key,
    required this.incidentType,
    required this.desc,
    required this.img,
  }) : super(key: key);

  @override
  State<PreviewReportCrime> createState() => _PreviewReportCrimeState();
}

class _PreviewReportCrimeState extends State<PreviewReportCrime> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.desc);
  }

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
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Header(
              title: 'Report Crime',
              actionTitle: 'Post',
              action: () {},
            ),
            const Divider(thickness: 1),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/images/pexels_cop.png',
                        fit: BoxFit.cover,
                      ),
                    ),
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
                      height: 40,
                      color: AppColors.colorBorderGrey4,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(widget.incidentType),
                        ),
                      ),
                    ),
                    const TwoRowText(
                      leftTitle: 'Description',
                      rightTitle: '600/1200',
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text('Location'),
                    ),
                    Container(
                      height: 194,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        'assets/images/map.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
