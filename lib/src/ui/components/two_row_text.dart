import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TwoRowText extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;
  const TwoRowText({
    required this.leftTitle,
    required this.rightTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Description',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '600/1200',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
