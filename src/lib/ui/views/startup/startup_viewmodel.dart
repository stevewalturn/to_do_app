import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:to_do_app/app/app.locator.dart';
import 'package:to_do_app/app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 2));
    await _navigationService.replaceWithHomeView();
  }
}
