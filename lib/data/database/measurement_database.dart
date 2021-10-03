import 'package:heart_rate/data/model/measurement.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class MeasurementDataBase {
  static final MeasurementDataBase instance = MeasurementDataBase.init();

  static Database? _database;

  MeasurementDataBase.init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('measurement.sqlite');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final intType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableMeasurements (
    ${MeasurementFields.id} $idType,
    ${MeasurementFields.BPM} $intType,
    ${MeasurementFields.status} $textType,
    ${MeasurementFields.comment} $textType,
    ${MeasurementFields.dateTime} $intType
    )
    ''');
  }

  Future<Measurement> create(Measurement measurement) async {
    final db = await instance.database;
    
    final id = await db.insert(tableMeasurements, measurement.toJson());
    return measurement.copy(id: id);
  }

  Future<Measurement?> read(int id) async {
    final db = await instance.database;
    
    final maps = await db.query(
      tableMeasurements,
      columns: MeasurementFields.values,
      where: '${MeasurementFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Measurement.fromJson(maps.first);
    } else {
      //throw Exception('ID $id not found');
      return null;
    }
  }

  Future<List<Measurement>> readAll([DateTime? timestamp]) async {
    final db = await instance.database;
    String? where;
    List? whereArgs;

    if (timestamp != null) {
      where = "dateTime >= ?";
      whereArgs = [timestamp.toUtc().millisecondsSinceEpoch];
    }

    //DEC == reversed, с конца
    final orderBy = '${MeasurementFields.dateTime} DESC';
    //WhereArgs
    final result = await db.query(tableMeasurements, orderBy: orderBy, where: where, whereArgs: whereArgs);

    return result.map((json) => Measurement.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}