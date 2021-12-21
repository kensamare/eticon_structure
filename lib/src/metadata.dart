class SgMetadata {
  SgMetadata._();

  static SgMetadata instance = SgMetadata._();

  static String _pack = '';
  static bool _git = false;

  void setPackName(String pack){
    _pack = pack;
  }

  String get packName => _pack;

  void setGit(bool git){
    _git = git;
  }

  bool get git => _git;
}