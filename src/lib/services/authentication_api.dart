import 'package:src/models/data/users/token_data.dart';
import 'package:src/models/data/users/user_data.dart';
import 'package:src/services/api_service.dart';
import 'package:src/services/base_api.dart';

class AuthenticationAPI extends BaseAPI {
  static const String prefix = "auth/";

  AuthenticationAPI() : super(prefix);

  Future<void> loginByAccount({
    required String email,
    required String password,
    required Function(UserData, TokenData) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(url: 'login', data: {
      "email": email,
      "password": password,
    }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        final user = UserData.fromJson(response.response['user']);
        final token = TokenData.fromJson(response.response['tokens']);
        await onSuccess(user, token);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> signUpByAccount({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String) onFail,
  }) async {
    final response =
    await service.postFormUrlEncoded(url: "register", headers: {
      "origin": "https://sandbox.app.lettutor.com",
      "referer": "https://sandbox.app.lettutor.com/",
    }, data: {
      "email": email,
      "password": password,
      "source": null
    }) as BoundResource;
    switch (response.statusCode) {
      case 200:
      case 201:

      onSuccess();
        break;
      default:
        onFail(response.errorMsg.toString());

        break;
    }
  }
}