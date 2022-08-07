import 'package:flutter/material.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/ui/chat.dart';
import 'package:socialpolice/src/ui/components/search_bar.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.colorBackground,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Message',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            const SearchBar(),
            const SizedBox(height: 30),
            ListView.separated(
              itemCount: 6,
              shrinkWrap: true,
              itemBuilder: (BuildContext ctx, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Chat(),
                    ),
                  ),
                  child: item(),
                );
              },
              separatorBuilder: (BuildContext ctx, index) {
                return const Divider(
                  thickness: 0.8,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Container item() {
    return Container(
      height: 80,
      // color: Colors.white,
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Alex Marchal'),
              Text(
                'I have some questions',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textColor1,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}
