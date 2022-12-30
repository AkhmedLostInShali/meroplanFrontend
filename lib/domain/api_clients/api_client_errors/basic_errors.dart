class ApiClientError implements Exception{
  final String? message;
  final Uri? uri;
  ApiClientError(this.message, {this.uri});

  String getErrorMessage() {
    return message ?? '';
  }
}

class UndeterminedApiClientError extends ApiClientError{
  UndeterminedApiClientError(String? message, {Uri? uri}) : super(message, uri: uri);
}