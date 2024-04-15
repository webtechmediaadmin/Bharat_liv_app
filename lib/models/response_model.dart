/// data : "responseModel"
/// status : true
/// error : "xjkvskdbvksvdbvkjsvj"

class ResponseModel {
  ResponseModel({
    dynamic data,
    bool? status,
    String? error,
  }) {
    _data = data;
    _status = status;
    _error = error;
  }

  ResponseModel.fromJson(dynamic json) {
    _data = json['data'];
    _status = json['status'];
    _error = json['error'];
  }
  dynamic _data;
  bool? _status;
  String? _error;

  dynamic get data => _data;
  bool? get status => _status;
  String? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['status'] = _status;
    map['error'] = _error;
    return map;
  }
}
