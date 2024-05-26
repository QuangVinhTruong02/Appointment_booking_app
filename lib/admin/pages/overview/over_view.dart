import 'package:booking_doctor/admin/common/widgets/text_style_for_web.dart';
import 'package:flutter/material.dart';

class OverView extends StatelessWidget {
  const OverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tổng quan",
                style: TextStyleWeb(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: MyTextFieldWeb(hint: "Search", controller: , fontSize: fontSize))
              //   ],
              // )
            ],
          )
        ],
      ),
    );
  }
}
