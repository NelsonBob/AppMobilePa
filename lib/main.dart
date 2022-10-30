import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/domain/blocs/auth/auth_bloc.dart';
import 'package:flutter_application_1/domain/blocs/post/post_bloc.dart';
import 'package:flutter_application_1/domain/blocs/user/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/screens/intro/checking_login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()..add(OnCheckingLoginEvent())),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => PostBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social Media',
        home: CheckingLoginPage(),
      ),
    );
  }
}
