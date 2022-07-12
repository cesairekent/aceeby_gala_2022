import 'package:aceeby_gala_2022/models/base_model.dart';

class TableModel extends BaseModel
{
  final String tableName;
  final int tableNumber;
  final int tableCapacity;

  const TableModel({
    id = 0,
    createdAt = 0,
    updatedAt = 0,
    deletedAt = 0,
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
    tableName,
    tableNumber,
    tableCapacity,
  ];

  // factory UserModel.fromMap(Map<String, dynamic> map)
  // {
  //   return UserModel(
  //     id: map['id'] ?? 0,
  //     createdAt: map['createdAt'] ?? 0,
  //     updatedAt: map['updatedAt'] ?? 0,
  //     deletedAt: map['deletedAt'] ?? 0,
  //     description: map['description'] ?? '',
  //   );
  // }

  // @override
  // Map<String, dynamic> toJson() => {
  //   'id': id,
  //   'createdAt': createdAt,
  //   'updatedAt': updatedAt,
  //   'deletedAt': deletedAt,
  //   'description': description
  // };
}