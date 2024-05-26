import 'package:booking_doctor/users/common/values/asset_value.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyAppointment extends StatelessWidget {
  const EmptyAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetImgValue.empty_list,
            width: 200.w,
            height: 200.w,
          ),
          SizedBox(height: 10.w),
          Text(
            "Không có phiếu khám nào",
            style: getMyTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
