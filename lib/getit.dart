import 'package:get_it/get_it.dart';
import 'package:langame/providers/interest_provider.dart';
import 'package:langame/providers/setting_provider.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<InterestProvider>(InterestProvider());
  getIt.registerSingleton<SettingProvider>(SettingProvider());
}
