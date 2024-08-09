import 'package:fmraipuromes/data/response/staus.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed() : status = Status.COMLETED;
  ApiResponse.error() : status = Status.ERROR;

  String toString() {
    return 'Status : $status \n Message : $message \n Data: $data';
  }
}
