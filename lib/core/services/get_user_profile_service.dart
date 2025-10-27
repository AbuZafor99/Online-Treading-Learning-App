import 'package:get/get.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/domain/repo/auth_repo.dart';
import '../base/base_controller.dart';

class GetUserProfileService extends BaseController {
  final AuthRepository _authRepository;

  GetUserProfileService(this._authRepository);

  final Rxn<UserModel> _userInfo = Rxn<UserModel>();
  UserModel? get userInfo => _userInfo.value;

  Future<void> getUserProfile() async {
    final result = await _authRepository.getUserProfile();

    result.fold((fail) {}, (succees) {
      _userInfo.value = succees.data;
    });
  }
}
