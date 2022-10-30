import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/ui/helpers/helpers.dart';
import 'package:flutter_application_1/ui/screens/login/login_page.dart';
import 'package:flutter_application_1/ui/screens/login/register_page.dart';
import 'package:flutter_application_1/ui/themes/colors_frave.dart';
import 'package:flutter_application_1/ui/widgets/widgets.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 55,
              width: size.width,
              child: Row(
                children: [
                  Image.asset('assets/img/logo.png', height: 30),
                  const TextCustom(
                      text: 'Annual ',
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(12, 108, 242, 1)),
                  const TextCustom(text: ' Project', fontSize: 17)
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(30.0),
                width: size.width,
                child: SvgPicture.asset('assets/svg/human-2099157.svg'),
              ),
            ),
            const TextCustom(
              text: 'Welcome !',
              letterSpacing: 2.0,
              color: ColorsFrave.secundary,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextCustom(
                text: 'The best social API to run your code',
                textAlign: TextAlign.center,
                maxLines: 2,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SizedBox(
                height: 50,
                width: size.width,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: ColorsFrave.secundary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                  child: const TextCustom(
                      text: 'Login', color: Colors.white, fontSize: 20),
                  onPressed: () => Navigator.push(
                      context, routeSlide(page: const LoginPage())),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                height: 50,
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border:
                        Border.all(color: ColorsFrave.secundary, width: 1.5)),
                child: TextButton(
                  child: const TextCustom(
                      text: 'Register',
                      color: ColorsFrave.secundary,
                      fontSize: 20),
                  onPressed: () => Navigator.push(
                      context, routeSlide(page: const RegisterPage())),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
