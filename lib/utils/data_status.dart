class DataStatus<T> {
  final Status status;
  final T? data;
  final String? message;

  DataStatus({
    required this.status,
    this.data,
    this.message,
  });

  factory DataStatus.loading() {
    return DataStatus(status: Status.loading);
  }

  factory DataStatus.success(T? data) {
    return DataStatus(
      status: Status.success,
      data: data,
    );
  }

  factory DataStatus.error(String error) {
    return DataStatus(
      status: Status.fail,
      message: error,
    );
  }
}

enum Status {
  loading,
  success,
  fail,
}