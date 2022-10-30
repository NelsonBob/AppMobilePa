import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/helpers/helpers.dart';
import 'package:flutter_application_1/ui/screens/profile/setting_profile_page.dart';
import 'package:flutter_application_1/ui/themes/colors_frave.dart';
import 'package:flutter_application_1/ui/widgets/widgets.dart';

modalProfileSetting(BuildContext context, Size size) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadiusDirectional.vertical(top: Radius.circular(20.0))),
    backgroundColor: Colors.white,
    builder: (context) => Container(
      height: size.height * .36,
      width: size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 4,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
            const SizedBox(height: 10.0),
            Item(
              icon: Icons.settings,
              text: 'Setting',
              size: size,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context, routeSlide(page: const SettingProfilePage()));
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class Item extends StatelessWidget {
  final IconData icon;
  final String text;
  final Size size;
  final VoidCallback onPressed;

  const Item(
      {Key? key,
      required this.icon,
      required this.text,
      required this.size,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: size.width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(primary: ColorsFrave.secundary),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(icon, color: Colors.black87),
                const SizedBox(width: 10.0),
                TextCustom(text: text, fontSize: 17)
              ],
            )),
      ),
    );
  }
}
