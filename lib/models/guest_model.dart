import 'package:aceeby_gala_2022/models/base_model.dart';
import 'package:aceeby_gala_2022/models/table_model.dart';

class GuestModel extends BaseModel
{
  final String fullName;
  final String invitationCardType;
  final String invitationCardNumber;
  final int tableId;
  final TableModel? table;
  final String? invitedBy;

  const GuestModel({
    id = 0,
    createdAt = 0,
    updatedAt = 0,
    deletedAt = 0,
    required this.fullName,
    required this.invitationCardType,
    required this.invitationCardNumber,
    required this.tableId,
    this.table,
    this.invitedBy,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt, deletedAt: deletedAt);

  @override
  List<Object?> get props =>
  [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    fullName,
    invitationCardType,
    invitationCardNumber,
    tableId,
    table,
    invitedBy,
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