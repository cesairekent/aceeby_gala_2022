import 'package:aceeby_gala_2022/models/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableModel extends BaseModel
{
  String? referenceId;
  final String tableName;
  final int tableNumber;
  final int tableCapacity;

  TableModel({
    id = 0,
    createdAt = 0,
    updatedAt = 0,
    deletedAt = 0,
    this.referenceId,
    required this.tableName,
    required this.tableNumber,
    required this.tableCapacity,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt, deletedAt: deletedAt);

  @override
  List<Object?> get props =>
  [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    referenceId,
    tableName,
    tableNumber,
    tableCapacity,
  ];

  factory TableModel.fromMap(Map<String, dynamic> map)
  {
    return TableModel(
      id: map['id'] ?? 0,
      createdAt: map['createdAt'] ?? 0,
      updatedAt: map['updatedAt'] ?? 0,
      deletedAt: map['deletedAt'] ?? 0,
      referenceId: map['referenceId'] ?? '',
      tableName: map['tableName'] ?? '',
      tableNumber: map['tableNumber'] ?? 0,
      tableCapacity: map['tableCapacity'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'deletedAt': deletedAt,
    'referenceId': referenceId,
    'tableName': tableName,
    'tableNumber': tableNumber,
    'tableCapacity': tableCapacity,
  };

  factory TableModel.fromSnapshot(DocumentSnapshot snapshot) {
    final newTable = TableModel.fromMap(snapshot.data() as Map<String, dynamic>);
    newTable.referenceId = snapshot.reference.id;
    return newTable;
  }
}