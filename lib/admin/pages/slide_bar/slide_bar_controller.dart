import 'package:booking_doctor/admin/common/services/reload_page.dart';
import 'package:booking_doctor/admin/common/store/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class SlideBarController extends ChangeNotifier {
  int _index = 0;
  // @override
  // void onInit() {
  //   super.onInit();
  //   _generateIndex();
  // }

  set index(int value) {
    _index = value;
    notifyListeners();
  }

  Future generateIndex(BuildContext context) async {
    index = await Provider.of<RouteStorage>(context, listen: false)
        .getCurrentIndex();
    notifyListeners();
  }

  void navigateToPage(String navigationPath, int value, BuildContext context) {
    if (value == 3) {
      FirebaseAuth.instance.signOut();
      Provider.of<UserConfigWeb>(context, listen: false).remove();
      Modular.to.pushReplacementNamed(navigationPath);
    }
    // locator<NavigationService>().navigateTo(navigationPath);
    Modular.to.pushNamed(navigationPath);
    Provider.of<RouteStorage>(context, listen: false).setCurrentIndex(value);
    // RouteStorage.to.setCurrentIndex(value);
    index = value;
  }

  int get index => _index;
}
