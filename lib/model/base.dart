class BaseResponse<T> {
  int code;
  String message;
  T data;

  BaseResponse(this.code, this.message, this.data);
}
