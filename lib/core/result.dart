enum ResultStatus { success, error }

class Result<T> {
  final T? data;
  final String? error;
  final ResultStatus status;

  Result.success(this.data) : status = ResultStatus.success, error = null;

  Result.error(this.error) : status = ResultStatus.error, data = null;

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
