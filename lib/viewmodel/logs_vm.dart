import 'package:dorothy/model/logs.dart';
import 'package:dorothy/model/logs_handler.dart';
import 'package:get/get.dart';

/// LogsScreen을 위한 Controller
class LogsVM extends GetxController {
  late LogsHandler handler;
  RxList<Logs> logs = RxList<Logs>(); // RxList 추가
  
  @override
  void onInit() async {
    super.onInit();
    handler = LogsHandler();
    logs.addAll(await selectAllLogs()); // logs 초기화
  }
  /// 로그의 모든 기록을 가져오기
  /// @Return : Logs table의 모든 데이터
  Future<List<Logs>> selectAllLogs() async {
    return await handler.selectAllLogs();
  }

  /// 로그의 모든 기록을 지우기
  deleteAllLogs() async {
    await handler.deleteAllLogs();
    logs.clear();
    logs.addAll(await selectAllLogs());
  }

  /// 로그의 기록 지우기
  /// @Params : id
  deleteLogs(int id) async {
    await handler.deleteLogs(id);
    logs.removeWhere((log) => log.id == id); // logs 업데이트
  }
}

