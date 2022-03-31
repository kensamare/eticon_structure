class SgMeta {
  SgMeta._();

  static SgMeta instance = SgMeta._();

  static bool _getL = true;
  static bool _util = true;
  static bool _api = true;
  static bool _storage = true;

  set getL(bool temp) => _getL = temp;

  bool get getL => _getL;

  set util(bool temp) => _util = temp;

  bool get util => _util;

  set api(bool temp) => _api = temp;

  bool get api => _api;

  set storage(bool temp) => _storage = temp;

  bool get storage => _storage;
}
