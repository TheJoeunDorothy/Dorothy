class Logs {
  int? id;
  String originalImage;
  String colorResult;
  String ageResult;
  int onePercent;
  int twoPercent;
  int threePercent;
  int fourPercent;
  int fivePercent;
  int sixPercent;
  int sevenPercent;
  String datetime;

  Logs({
    this.id,
    required this.originalImage,
    required this.colorResult,
    required this.ageResult,
    required this.onePercent,
    required this.twoPercent,
    required this.threePercent,
    required this.fourPercent,
    required this.fivePercent,
    required this.sixPercent,
    required this.sevenPercent,
    required this.datetime,
  });

  Logs.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        originalImage = map['originalImage'],
        colorResult = map['colorResult'],
        ageResult = map['ageResult'],
        onePercent = map['onePercent'],
        twoPercent = map['twoPercent'],
        threePercent = map['threePercent'],
        fourPercent = map['fourPercent'],
        fivePercent = map['fivePercent'],
        sixPercent = map['sixPercent'],
        sevenPercent = map['sevenPercent'],
        datetime = map['datetime'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'originalImage': originalImage,
      'colorResult': colorResult,
      'ageResult': ageResult,
      'onePercent': onePercent,
      'twoPercent': twoPercent,
      'threePercent': threePercent,
      'fourPercent': fourPercent,
      'fivePercent': fivePercent,
      'sixPercent': sixPercent,
      'sevenPercent': sevenPercent,
      'datetime': datetime,
    };
  }
}
