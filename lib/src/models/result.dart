class Result<T> {
  final ResultCode code;
  final String? message;
  final T? data;

  Result({
    required this.code,
    this.message,
    this.data,
  });
}

enum ResultCode {
  success,
  timeout,
  socket,
  platform,
  firebase,
  exception,
}
