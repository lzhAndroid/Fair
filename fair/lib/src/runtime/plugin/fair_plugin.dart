import 'dart:convert';

abstract class IFairPlugin {
  Future<dynamic> invoke(dynamic par) async {
    var resp =
        await Function.apply(getRegisterMethods()[getMethodName(par)], [par]);
    return Future.value(resp);
  }

  String getMethodName(dynamic par) {
    var a = jsonDecode(par);
    var obj = a['args'];
    var name = obj['className']?.toString();

    if (name.contains('#')) {
      var list = name.split('#');
      if (list.length >= 2) {
        return list[1];
      }
    }

    return '';
  }

  Map<String, Function> getRegisterMethods();
}
