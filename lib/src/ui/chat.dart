import 'package:flutter/material.dart';
import 'package:socialpolice/src/res/colors.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 70),
        child: Column(
          children: [
            Container(
              height: 93,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  Container(
                    height: 24,
                    width: 24,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Alex Marchal',
                    style: TextStyle(fontSize: 25),
                  ),
                  const Spacer(),
                  const Icon(Icons.call, size: 28)
                ],
              ),
            ),
            const Divider(
              thickness: 1.2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                itemCount: 1,
                reverse: true,
                itemBuilder: (BuildContext ctx, int index) {
                  return Container(
                    height: 78,
                    width: 181,
                    margin: const EdgeInsets.only(left: 181, right: 10),
                    decoration: const BoxDecoration(
                      color: AppColors.colorBlue1,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'No problem Dustin, I send you the documents when I arrived at my office!',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 57,
              margin: const EdgeInsets.only(bottom: 20),
              color: AppColors.colorBorderGrey2,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 0.4,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: MediaQuery.of(context).size.width * 0.85,
                    margin: const EdgeInsets.only(left: 15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        border: InputBorder.none,
                        hintText: 'say hi',
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.send),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
