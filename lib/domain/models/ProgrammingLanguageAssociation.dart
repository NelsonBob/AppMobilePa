class ProgrammingLanguageAssociation {
  final String languageName;
  final String displayLanguageName;
  final String mainFile;
  final String fileExtension;
  final String baseValue;

  const ProgrammingLanguageAssociation(
      this.languageName,
      this.displayLanguageName,
      this.mainFile,
      this.fileExtension,
      this.baseValue);

  factory ProgrammingLanguageAssociation.fromJson(Map<String, dynamic> json) {
    return ProgrammingLanguageAssociation(
      json['languageName'],
      json['displayLanguageName'],
      json['mainFile'],
      json['fileExtension'],
      json['baseValue'],
    );
  }

  @override
  String toString() {
    return "{languageName: $languageName, displayLanguageName: $displayLanguageName, mainFile: $mainFile, fileExtension: $fileExtension,baseValue:$baseValue}";
  }
}
