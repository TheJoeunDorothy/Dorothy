class Logs{
  int? id;  // ai라서 required받지 않을 거라서 이렇게함
  String? originalimage;
  String? personalimage;
  String? ageimage;
  String? datetime;

  Logs(
    {
      this.id,
      this.originalimage,
      this.personalimage,
      this.ageimage,
      this.datetime,
    }
  );
  Logs.fromMap(Map<String, dynamic> res)  // 생성자 만들기
    : id = res['id'],
    originalimage = res['originalimage'],
    personalimage = res['personalimage'],
    ageimage = res['ageimage'],
    datetime = res['datetime'];
  
  Map<String, Object?> toMap(){ // method 만들기(그림타입이 있을 수 있어서 Object)
    return {
      'id': id,
      'originalimage': originalimage,
      'personalimage': personalimage,
      'ageimage': ageimage,
      'datetime': datetime,
    };
  }
}

