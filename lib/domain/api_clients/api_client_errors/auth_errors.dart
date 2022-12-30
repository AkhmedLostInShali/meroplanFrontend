import 'package:hacaton/domain/api_clients/api_client_errors/basic_errors.dart';

class AuthIncorrectPhoneApiClientError extends ApiClientError{
  AuthIncorrectPhoneApiClientError(String? message, {Uri? uri}) : super('Номер введён\n некорректно', uri: uri);
}

class AuthEmptyTokenApiClientError extends ApiClientError{
  AuthEmptyTokenApiClientError(String? message, {Uri? uri}) : super('Запрос отклонён', uri: uri);
}

