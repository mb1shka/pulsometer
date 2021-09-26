import 'package:json_annotation/json_annotation.dart';

enum Status {
  Rest,
  Normal,
  Active,
}

extension StatusExtension on Status {
  String toShortString() {
    return this.toString().split('.').last;
  }
}