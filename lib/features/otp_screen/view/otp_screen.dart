import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/widgets/exports.dart';
import 'package:bongobondhu_app/features/otp_screen/view/widgets/form_widget.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/exports.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final l10n = Localize().l10n;
    const _sizedBoxHeight10 = SizedBox(
      height: 10,
    );
    const _sizedBoxHeight40 = SizedBox(
      height: 40,
    );
    return Consumer<ThemeManagerViewModel>(
      builder: (context, themeVm, _) {
        return Padding(
          padding: commonScaffoldPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _sizedBoxHeight40,
                TextWidget(
                  l10n.otp,
                  style: TextStyles.regular18,
                ),
                _sizedBoxHeight40,
                const OtpFormWidget(),
                const SizedBox(
                  height: 30,
                ),
                _sizedBoxHeight10,
              ],
            ),
          ),
        );
      },
    );
  }
}
