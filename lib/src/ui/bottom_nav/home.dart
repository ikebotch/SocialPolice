import 'package:flutter/material.dart';
import 'package:socialpolice/src/res/colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.colorBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 48,
                    width: 48,
                    child: CircleAvatar(
                      radius: 50,
                      child: Image.asset('assets/images/avatar.png'),
                    ),
                  ),
                  const Text(
                    'Fransica Sika',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: const Icon(Icons.camera_alt, size: 41),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                choose('Police', context),
                choose('Ambulance', context),
              ],
            ),
            const SizedBox(height: 20),
            choose('Fire', context),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Latest News'),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 77,
              width: double.infinity,
              color: AppColors.colorRed1,
              child: const Center(
                child: Text(
                  'News Alert',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container choose(String name, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      height: 100,
      width: (MediaQuery.of(context).size.width - 30) / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: AppColors.colorBorderGrey1,
            blurRadius: 10,
            offset: Offset(0.1, 0.5),
          )
        ],
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
