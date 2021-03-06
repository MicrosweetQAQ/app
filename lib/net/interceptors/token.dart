import 'package:app/types/auth_token.dart';
import 'package:app/utils/jwt.dart';
import 'package:dio/dio.dart';

class TokenInterceptors extends QueuedInterceptor {
  TokenInterceptors(this.dio, this._token);

  final Dio dio;
  final AuthToken? _token;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_token != null) {
      final expiration = Jwt.remaingTime(_token!.accessToken);

      if (expiration != null && expiration.inSeconds < 60) {
        // dio.interceptors.requestLock.lock();
        // RefireshToken

        // Call the refresh endpoint to get a new token
        // await UserService().refresh().then((response) async {
        //   await TokenRepository().persistAccessToken(response.accessToken);
        //   accessToken = response.accessToken;
        // }).catchError((error, stackTrace) {
        //   handler.reject(error, true);
        // }).whenComplete(() => dio.interceptors.requestLock.unlock());
      }

      options.headers['Authorization'] = 'Bearer ${_token!.accessToken}';
    }

    return handler.next(options);
  }
}
