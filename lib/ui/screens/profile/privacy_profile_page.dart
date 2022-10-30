import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/blocs/blocs.dart';
import 'package:flutter_application_1/ui/helpers/helpers.dart';
import 'package:flutter_application_1/ui/screens/profile/widgets/item_profile.dart';
import 'package:flutter_application_1/ui/themes/colors_frave.dart';
import 'package:flutter_application_1/ui/widgets/widgets.dart';

class PrivacyProgilePage extends StatelessWidget {
  const PrivacyProgilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingChangeAccount) {
          modalLoading(context, 'changing privacy...');
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(context, 'privacy changed',
              onPressed: () => Navigator.pop(context));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(
              text: 'Privacy', fontSize: 19, fontWeight: FontWeight.w500),
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black)),
        ),
        body: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            physics: const BouncingScrollPhysics(),
            children: [
              const TextCustom(
                  text: 'account privacy',
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: InkWell(
                  child: BlocBuilder<UserBloc, UserState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (_, state) => Row(
                      children: [
                        const Icon(Icons.lock_outlined),
                        const SizedBox(width: 10),
                        const TextCustom(text: 'private account', fontSize: 17),
                        const Spacer(),
                        (state.user != null && state.user!.isPrivate == 1)
                            ? const Icon(Icons.radio_button_checked_rounded,
                                color: ColorsFrave.primary)
                            : const Icon(Icons.radio_button_unchecked_rounded),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  onTap: () => modalPrivacyProfile(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
