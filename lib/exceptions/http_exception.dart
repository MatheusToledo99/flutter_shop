class HttpException implements Exception {
  final String msg;
  final int statusCode;

  HttpException(this.msg, this.statusCode);

  @override
  String toString() {
    return msg;
  }
}
