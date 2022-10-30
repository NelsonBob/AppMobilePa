import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/themes/colors_frave.dart';
import 'package:flutter_application_1/ui/widgets/widgets.dart';

void modalLoading(BuildContext context, String text){

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white54, 
    builder: (context) 
      => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        content: SizedBox(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  TextCustom(text: 'Loading ', color: ColorsFrave.primary, fontWeight: FontWeight.w500 ),
                  TextCustom(text: '...', fontWeight: FontWeight.w500),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10.0),
              Row(
                children:[
                  const CircularProgressIndicator( color: ColorsFrave.primary),
                  const SizedBox(width: 15.0),
                  TextCustom(text: text)
                ],
              ),
            ],
          ),
        ),
      ),
  );

}