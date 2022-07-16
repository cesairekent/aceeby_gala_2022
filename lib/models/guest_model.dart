import 'package:aceeby_gala_2022/models/base_model.dart';
import 'package:aceeby_gala_2022/models/table_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GuestModel extends BaseModel
{
  String? referenceId;
  final String fullName;
  final String invitationCardType;
  final String invitationCardNumber;
  final String tableId;
  final TableModel? table;
  final String? invitedBy;

  GuestModel({
    id = 0,
    createdAt = 0,
    updatedAt = 0,
    deletedAt = 0,
    this.referenceId,
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
    referenceId,
    fullName,
    invitationCardType,
    invitationCardNumber,
    tableId,
    table,
    invitedBy,
  ];

  factory GuestModel.fromMap(Map<String, dynamic> map)
  {
    return GuestModel(
      id: map['id'] ?? 0,
      createdAt: map['createdAt'] ?? 0,
      updatedAt: map['updatedAt'] ?? 0,
      deletedAt: map['deletedAt'] ?? 0,
      referenceId: map['referenceId'] ?? '',
      fullName: map['fullName'] ?? '',
      invitationCardType: map['invitationCardType'] ?? '',
      invitationCardNumber: map['invitationCardNumber'] ?? '',
      tableId: map['tableId'] ?? '',
      //table: TableModel.fromMap(map['table']) ?? null,
      invitedBy: map['invitedBy'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'deletedAt': deletedAt,
    'referenceId': referenceId,
    'fullName': fullName,
    'invitationCardType': invitationCardType,
    'invitationCardNumber': invitationCardNumber,
    'tableId': tableId,
    'table': table?.toJson(),
    'invitedBy': invitedBy,
  };

  factory GuestModel.fromSnapshot(DocumentSnapshot snapshot) {
    final newGuest = GuestModel.fromMap(snapshot.data() as Map<String, dynamic>);
    newGuest.referenceId = snapshot.reference.id;
    return newGuest;
  }
}