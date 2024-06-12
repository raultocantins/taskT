import 'package:mobx/mobx.dart';
import 'package:task_planner/src/features/home/domain/usecases/get_count_task_pending_usecase.dart';
part 'home_controller.g.dart';

// ignore: library_private_types_in_public_api
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final GetCountTasksPendingUsecase _getCountTasksPendingUsecase;
  _HomeControllerBase(
    this._getCountTasksPendingUsecase,
  );

  @observable
  int countTasksPending = 0;

  @action
  void changeCountTasksPending(int value) {
    countTasksPending = value;
  }

  Future<void> getCountTasksPending() async {
    var result = await _getCountTasksPendingUsecase();
    result.fold(
      (l) => null,
      (r) {
        changeCountTasksPending(r);
      },
    );
  }
}
