enum ScreenStatus { initial, loading, success, error }

extension ScreenStatusWhen on ScreenStatus {
  T when<T>({
    required T Function() loading,
    required T Function() error,
    required T Function() success,
    required T Function() initial,
  }) {
    switch (this) {
      case ScreenStatus.loading:
        return loading();
      case ScreenStatus.error:
        return error();
      case ScreenStatus.success:
        return success();
      case ScreenStatus.initial:
        return initial();
    }
  }
}
