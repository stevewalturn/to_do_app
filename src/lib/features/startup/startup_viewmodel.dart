import 'package:to_do_app/app/app.locator.dart';
import 'package:to_do_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  // ignore: strict_raw_type
  Future runStartupLogic() async {
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 1));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    await _navigationService.replaceWithHomeView();
  }
}
