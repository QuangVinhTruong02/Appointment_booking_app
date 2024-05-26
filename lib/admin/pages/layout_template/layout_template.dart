import 'package:booking_doctor/admin/common/store/user.dart';
import 'package:booking_doctor/admin/common/values/colors_value_web.dart';
import 'package:booking_doctor/admin/common/widgets/text_style_for_web.dart';
import 'package:booking_doctor/admin/media_query.dart';
import 'package:booking_doctor/admin/pages/layout_template/layout_template_controller.dart';
import 'package:booking_doctor/admin/pages/slide_bar/slide_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class LayoutTemplate extends StatefulWidget {
  @override
  State<LayoutTemplate> createState() => _LayoutTemplateState();
}

class _LayoutTemplateState extends State<LayoutTemplate> {
  @override
  void initState() {
    super.initState();

    Provider.of<UserConfigWeb>(context, listen: false).getUser();
  }

  // final Widget child;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: SlideBar(),
      body: SafeArea(
        child: Row(
          children: [
            if (!Responsive.isMobile(context))
              Expanded(
                flex: 1,
                child: SlideBar(),
              ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (Responsive.isMobile(context))
                              IconButton(
                                onPressed: () =>
                                    _scaffoldKey.currentState!.openDrawer(),
                                icon: Icon(Icons.menu),
                              ),
                            Consumer<LayoutTemplateController>(
                              builder:
                                  (context, layoutTemplateController, child) {
                                return Text(
                                  layoutTemplateController.state.title,
                                  style: TextStyleWeb(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: ColorsValueWeb.thirdColor, width: 0.5),
                          ),
                          child: Consumer<UserConfigWeb>(builder:
                              (context, userConfigController, snapshot) {
                            return Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(userConfigController
                                          .userLoginResponse.photoUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  userConfigController
                                      .userLoginResponse.userName!,
                                  style: TextStyleWeb(),
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.keyboard_arrow_down_outlined),
                              ],
                            );
                          }),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 5),
                    Flexible(
                      child: RouterOutlet(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: child,
    // );
  }
}
