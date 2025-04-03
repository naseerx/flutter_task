class ApiResponse<T> {
  Status status;
  T? data;
  String? message;
  int? statusCode;

  ApiResponse.loading([this.message])
      : status = Status.loading,
        statusCode = null;

  ApiResponse.completed(this.data, {this.statusCode})
      : status = Status.completed,
        message = null;

  ApiResponse.error(this.message, {this.statusCode})
      : status = Status.error,
        data = null;

  ApiResponse.noInternet([this.message])
      : status = Status.noInternet,
        data = null,
        statusCode = null;

  ApiResponse.unAuthorised([this.message, this.statusCode])
      : status = Status.unAuthorised,
        data = null;

  ApiResponse.timeout([this.message])
      : status = Status.timeout,
        data = null,
        statusCode = null;

  @override
  String toString() {
    return "Status: $status\nMessage: $message\nData: $data\nStatus Code: $statusCode";
  }
}

enum Status { loading, completed, error, noInternet, unAuthorised, timeout }
