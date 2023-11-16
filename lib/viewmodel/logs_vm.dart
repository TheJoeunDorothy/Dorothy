import 'package:dorothy/model/logs.dart';
import 'package:dorothy/model/logs_handler.dart';
import 'package:get/get.dart';

/// LogsScreen을 위한 Controller
class LogsVM extends GetxController {
  late LogsHandler handler;

  @override
  void onInit() async {
    super.onInit();
    handler = LogsHandler();
    // await addDummyLogs();
  }
  /// 로그의 모든 기록을 가져오기
  /// @Return : Logs table의 모든 데이터
  Future<List<Logs>> selectAllLogs() async {
    return await handler.selectAllLogs();
  }
  /// 로그의 기록 지우기
  /// @Params : id
  deleteLogs(int id) async {
    await handler.deleteLogs(id);
  }
}