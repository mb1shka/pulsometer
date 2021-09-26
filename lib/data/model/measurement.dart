import 'package:heart_rate/data/model/status.dart';

final String tableMeasurements = 'measurement';

class MeasurementFields {
  static final List<String> values = [
    ///Add all fields
    id, BPM, status, comment, dateTime
  ];

  static final String id = '_id';
  static final String BPM = 'BPM';
  static final String status = 'status';
  static final String comment = 'comment';
  static final String dateTime = 'dateTime';
}

class Measurement {
  final int? id;
  final int BPM;
  final Status status;
  final String comment;
  final DateTime dateTime;

  const Measurement({
   this.id,
   required this.BPM,
   required this.status,
   required this.comment,
   required this.dateTime,
  });

  Measurement copy({
    int? id,
    int? BPM,
    Status? status,
    String? comment,
    DateTime? dateTime,
  }) =>
      Measurement(
        id: id ?? this.id,
        BPM: BPM ?? this.BPM,
        status: status ?? this.status,
        comment: comment ?? this.comment,
        dateTime: dateTime ?? this.dateTime,
      );

  static Measurement fromJson(Map<String, Object?> json) => Measurement(
        id: json[MeasurementFields.id] as int?,
        BPM: json[MeasurementFields.BPM] as int,
        status: parseStatus(json[MeasurementFields.status] as String), //TODO проверить, работает ли as Status. если не работает, нужно будет написать ручной парсер
        comment: json[MeasurementFields.comment] as String,
        dateTime: new DateTime.fromMillisecondsSinceEpoch(json[MeasurementFields.dateTime] as int),
  );

  static Status parseStatus(String str) {
    switch (str) {
      case "Normal":
        return Status.Normal;
      case "Active":
        return Status.Active;
      case "Rest":
        return Status.Rest;
    }
    return Status.Normal;
  }

  Map<String, Object?> toJson() => {
    MeasurementFields.id: id,
    MeasurementFields.BPM: BPM,
    MeasurementFields.status: status.toShortString(),
    MeasurementFields.comment: comment,
    MeasurementFields.dateTime: dateTime.toUtc().millisecondsSinceEpoch,
  };
}