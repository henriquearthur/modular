import 'package:flutter/material.dart';

import '../../flutter_modular.dart';

void initModule(ChildModule module, {List<Bind> changeBinds}) {
  final list = module.binds;
  for (var item in list ?? []) {
    var dep = (changeBinds ?? []).firstWhere((dep) {
      return item.runtimeType == dep.runtimeType;
    }, orElse: () => null);
    if (dep != null) {
      list.remove(item);
      list.add(dep);
      module.changeBinds(list);
    }
  }

  Modular.addCoreInit(module);
}

void initModules(List<ChildModule> modules, {List<Bind> changeBinds}) {
  for (var module in modules) {
    initModule(module, changeBinds: changeBinds);
  }
}

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}
