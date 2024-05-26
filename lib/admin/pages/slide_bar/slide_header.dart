import 'package:booking_doctor/users/common/values/asset_value.dart';
import 'package:flutter/material.dart';

class SlideHeader extends StatelessWidget {
  const SlideHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(AssetIconValue.logo_app),
      title: FittedBox(
        child: Text(
          "BOOKING APP",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
