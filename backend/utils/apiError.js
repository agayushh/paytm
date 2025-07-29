class ApiError extends Error {
  constructor(
    StatusCode,
    message = "Something went wrong",
    Error = [],
    Stack = ""
  ) {
    super(message);
    (this.StatusCode = StatusCode), (this.message = message);
    this.Error = Error;
    this.data = null;
    this.success = false;
  }
}

export { ApiError };
