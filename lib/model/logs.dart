class Logs{
  int? id;  // ai라서 required받지 않을 거라서 이렇게함
  String image;
  String timestamp;

  Logs(
    {
      this.id,
      required this.image,
      required this.timestamp,
    }
  );
  Logs.fromMap(Map<String, dynamic> res)  // 생성자 만들기
    : id = res['id'],
    image = res['image'],
    timestamp = res['timestamp'];
  
  Map<String, Object?> toMap(){ // method 만들기(그림타입이 있을 수 있어서 Object)
    return {
      'id': id,
      'image': image,
      'timestamp': timestamp,
    };
  }
}

