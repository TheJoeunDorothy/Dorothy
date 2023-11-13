class Logs{
  int? id;  // ai라서 required받지 않을 거라서 이렇게함
  String image;
  String datetime;

  Logs(
    {
      this.id,
      required this.image,
      required this.datetime,
    }
  );
  Logs.fromMap(Map<String, dynamic> res)  // 생성자 만들기
    : id = res['id'],
    image = res['image'],
    datetime = res['datetime'];
  
  Map<String, Object?> toMap(){ // method 만들기(그림타입이 있을 수 있어서 Object)
    return {
      'id': id,
      'image': image,
      'datetime': datetime,
    };
  }
}

