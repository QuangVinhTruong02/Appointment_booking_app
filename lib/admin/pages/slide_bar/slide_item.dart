import 'package:booking_doctor/admin/common/values/colors_value_web.dart';
import 'package:booking_doctor/admin/common/widgets/text_style_for_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SlideItem extends StatelessWidget {
  final String title;
  final String svgSrc;

  final bool isSelected;
  final VoidCallback press;
  const SlideItem({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.isSelected,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius? borderRadius = isSelected ? BorderRadius.circular(8) : null;
    Color? selectedColor = isSelected ? ColorsValueWeb.secondColor : null;
    Widget? titleWidget = Text(
      title,
      style: TextStyleWeb(color: Colors.white),
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: selectedColor,
      ),
      child: ListTile(
        onTap: press,
        leading: SvgPicture.asset(
          svgSrc,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          height: 20,
        ),
        title: titleWidget,
      ),
    );
  }
}
