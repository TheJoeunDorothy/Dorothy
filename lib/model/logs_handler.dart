import 'package:dorothy/model/logs.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
/// SQLite에 관련 로그 클래스
class LogsHandler {
  /// Logs DB를 시작하기
  Future<Database> initalizeDB() async {
    // 여기서 init해줘야 db에 연결해서 insert 가능함
    String path = await getDatabasesPath(); // 데이터 위치 알기위해 만들기
    return openDatabase(
      join(path, 'logs.db'), // 해당 위치에 들어가서 student.db 접속
      // table 만들기
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE logs(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              originalimage TEXT, 
              personalimage TEXT, 
              ageimage TEXT, 
              datetime TEXT)'''); // sqllite는 varchar없음
      },
      version: 1,
    );
  }

  /// 모든 LogsDB에 관련된 함수 가져오기
  Future<List<Logs>> selectAllLogs() async {
    final Database db = await initalizeDB();
    // null data가 있을수도 있어서 ?
    final List<Map<String, Object?>> queryResults =
        await db.rawQuery('SELECT * from logs');
    // return할려고 Map형식을 List로 형변환
    return queryResults.map((e) => Logs.fromMap(e)).toList();
  }

  /// Logs를 입력
  /// 
  /// `@param [Logs]` 
  /// 
  /// `@return int = 0` => Success
  insertLogs(Logs log) async {
    // model의 Student생성자 타입으로 insert
    int result = 0;
    final Database db = await initalizeDB(); // sql에 connect
    result = await db.rawInsert(
        'INSERT INTO logs(originalimage,personalimage,ageimage,datetime) VALUES (?,?,?,?)',
        [
          log.originalimage,
          log.personalimage,
          log.ageimage,
          DateFormat('yyyy-MM-dd hh:mm aaa').format(DateTime.now())
        ]);
    return result;
  }
  /// Logs 삭제
  /// 
  /// `@param [int] id값` 
  deleteLogs(int id) async {
    final Database db = await initalizeDB();
    await db.rawDelete('DELETE FROM logs WHERE id =?', [id]);
  }
} // End