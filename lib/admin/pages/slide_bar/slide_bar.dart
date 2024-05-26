import 'package:booking_doctor/admin/common/routes/route_name.dart';
import 'package:booking_doctor/admin/common/values/asset_value_web.dart';
import 'package:booking_doctor/admin/common/values/colors_value_web.dart';
import 'package:booking_doctor/admin/pages/slide_bar/slide_bar_controller.dart';
import 'package:booking_doctor/admin/pages/slide_bar/slide_header.dart';
import 'package:booking_doctor/admin/pages/slide_bar/slide_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SlideBar extends StatefulWidget {
  const SlideBar({super.key});

  @override
  State<SlideBar> createState() => _SlideBarState();
}

class _SlideBarState extends State<SlideBar> {
  @override
  void initState() {
    super.initState();
    Provider.of<SlideBarController>(context, listen: false)
        .generateIndex(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsValueWeb.secondColor.withOpacity(0.8),
      child: Consumer<SlideBarController>(
        builder: (context, controller, child) => ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SlideHeader(),
            ),
            Divider(thickness: 0.2),
            SlideItem(
              title: "Tổng quan",
              svgSrc: AssetSvgWebValue.logo,
              isSelected: controller.index == 0,
              press: () =>
                  controller.navigateToPage(RouteName.OVER_VIEW, 0, context),
            ),
            SlideItem(
              title: "Bệnh viện",
              svgSrc: AssetSvgWebValue.hospital,
              isSelected: controller.index == 1,
              press: () =>
                  controller.navigateToPage(RouteName.HOPITALS, 1, context),
            ),

            SlideItem(
              title: "Bác sĩ",
              svgSrc: AssetSvgWebValue.doctor,
              isSelected: controller.index == 2,
              press: () =>
                  controller.navigateToPage(RouteName.DOCTORS, 2, context),
            ),
            Divider(
              thickness: 0.4,
              color: Colors.white,
            ),
            SlideItem(
              title: "Đăng xuất",
              svgSrc: AssetSvgWebValue.sign_out,
              isSelected: controller.index == 3,
              press: () =>
                  controller.navigateToPage(RouteName.LOGIN, 3, context),
            ),
            // SlideItem(
            //   title: "Quản lý tài khoản",
            //   svgSrc: AssetSvgWebValue.logo,
            //   isSelected: controller.index.value == 0,
            //   press: () => controller.navigateToPage(WebRoute.OVER_VIEW, 0),
            // ),
          ],
        ),
      ),
    );
  }
}
