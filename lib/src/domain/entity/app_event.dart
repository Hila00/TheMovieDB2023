class AppEvent<T> {
  T? data;
  Status status;

  AppEvent({
    this.status = Status.loading,
    this.data,
  });
}

enum Status {
  loading,
  success,
  error,
  empty,
}
