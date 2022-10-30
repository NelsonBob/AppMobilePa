import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/screens/login/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_application_1/domain/blocs/blocs.dart';
import 'package:flutter_application_1/ui/helpers/helpers.dart';
import 'package:flutter_application_1/ui/screens/login/verify_email_page.dart';
import 'package:flutter_application_1/ui/themes/colors_frave.dart';
import 'package:flutter_application_1/ui/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController fullNameController;
  late TextEditingController userController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    userController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    userController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'loading...');
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(context, 'successful creation',
              onPressed: () =>
                  Navigator.push(context, routeSlide(page: const LoginPage())));
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: SingleChildScrollView(
              child: Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextCustom(
                        text: 'Welcome!',
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                        color: ColorsFrave.secundary),
                    const SizedBox(height: 10.0),
                    const TextCustom(
                      text: 'Create a new account.',
                      fontSize: 17,
                      letterSpacing: 1.0,
                    ),
                    const SizedBox(height: 40.0),
                    TextFieldCostum(
                      controller: fullNameController,
                      hintText: 'Username',
                      validator:
                          RequiredValidator(errorText: 'username is required'),
                    ),
                    const SizedBox(height: 40.0),
                    TextFieldCostum(
                      controller: userController,
                      hintText: 'Fullname',
                      validator:
                          RequiredValidator(errorText: 'fullname is required'),
                    ),
                    const SizedBox(height: 40.0),
                    TextFieldCostum(
                      controller: emailController,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: validatedEmail,
                    ),
                    const SizedBox(height: 40.0),
                    TextFieldCostum(
                      controller: passwordController,
                      hintText: 'Password',
                      isPassword: true,
                      validator: passwordValidator,
                    ),
                    const SizedBox(height: 60.0),
                    const TextCustom(
                      text:
                          'By signing up, you agree to the terms of service and privacy policy.',
                      fontSize: 15,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 20.0),
                    Btn(
                        text: 'Register',
                        width: size.width,
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            userBloc.add(OnRegisterUserEvent(
                                userController.text.trim(),
                                fullNameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim()));
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
