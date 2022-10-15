
import 'package:gestion_maintenance_mobile/blocs/authentication/types.dart';
import 'package:gestion_maintenance_mobile/blocs/settings/types.dart';

abstract class AppBlock{

  void dispose();
  void init();

  SettingsBloc get settingsBloc;
  AuthBlock get authBloc;

}