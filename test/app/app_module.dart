import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_bloc.dart';
import 'app_widget.dart';
import 'guard/guard.dart';
import 'modules/forbidden/forbidden_widget.dart';
import 'modules/home/home_module.dart';
import 'shared/ILocalRepository.dart';
import 'shared/local_storage_shared.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
        Bind<ILocalStorage>((i) => LocalStorageSharePreference()),
      ];

  @override
  List<Router> get routers => [
        Router(
          "/forbidden",
          child: (_, args) => ForbiddenWidget(),
          guards: [MyGuard()],
          transition: TransitionType.fadeIn,
        ),
        Router(
          "/",
          module: HomeModule(),
          transition: TransitionType.fadeIn,
        ),
        Router("/home", module: HomeModule()),
        Router("/homeTwo", module: HomeModule(), guards: [MyGuard()]),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
