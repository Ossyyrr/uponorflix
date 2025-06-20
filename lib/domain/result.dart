import 'package:uponorflix/domain/enum/result_status.dart';

class Result<T> {
  final T? data;
  final String? error;
  final ResultStatus status;

  Result.success(this.data) : status = ResultStatus.success, error = null;

  Result.error(this.error) : status = ResultStatus.error, data = null;

  bool get isSuccess => status == ResultStatus.success;
  bool get isError => status == ResultStatus.error;

  R when<R>({
    required R Function(T? data) success,
    required R Function(String? error) error,
  }) {
    if (status == ResultStatus.success) {
      return success(data);
    } else {
      return error(this.error);
    }
  }
}
