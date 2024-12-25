import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_app/ui/common/app_colors.dart';
import 'package:to_do_app/ui/views/startup/startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 100,
              color: kcPrimaryColor,
            ),
            const SizedBox(height: 16),
            const Text(
              'Daily Tasks',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(kcPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) =>
      SchedulerBinding.instance.addPostFrameCallback(
        (timeStamp) => viewModel.runStartupLogic(),
      );
}
