import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/ui/components/header.dart';
import 'package:socialpolice/src/ui/components/two_row_text.dart';
import 'package:socialpolice/src/ui/preview_report_crime.dart';

class ReportCrime extends StatefulWidget {
  const ReportCrime({Key? key}) : super(key: key);

  @override
  State<ReportCrime> createState() => _ReportCrimeState();
}

class _ReportCrimeState extends State<ReportCrime> {
  final TextEditingController _controller = TextEditingController(
      text:
          'This is a long string of text that will eventually wrap—good thing we have an input that is able to support it!');
  List<String> items = ['Theft', 'Arson', 'Burglary', 'Cybercrime'];
  var selectedItem = 'Theft';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(top: 70),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                title: 'Report Crime',
                actionTitle: 'Next',
                action: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreviewReportCrime(
                      incidentType: selectedItem,
                      desc: _controller.text,
                      img: 'assets/images/pexels_cop.png',
                    ),
                  ),
                ),
              ),
              const Divider(thickness: 1),
              Container(
                height: 180,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 1, color: AppColors.colorPrimary),
                    ),
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
      ),
    );
  }
}
