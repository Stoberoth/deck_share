// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_cards_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShareCards _$ShareCardsFromJson(Map<String, dynamic> json) => _ShareCards(
  id: json['id'] as String?,
  title: json['title'] as String?,
  expectedReturnDate: json['expectedReturnDate'] == null
      ? null
      : DateTime.parse(json['expectedReturnDate'] as String),
  returnedAt: json['returnedAt'] == null
      ? null
      : DateTime.parse(json['returnedAt'] as String),
  status: $enumDecodeNullable(_$ShareCardsStatusEnumMap, json['status']),
  notes: json['notes'] as String?,
  lender: json['lender'] as String,
  applicant: json['applicant'] as String,
  lendingCards: (json['lendingCards'] as List<dynamic>)
      .map((e) => MtgCard.fromJson(e as Map<String, dynamic>))
      .toList(),
  lendingDate: json['lendingDate'] == null
      ? null
      : DateTime.parse(json['lendingDate'] as String),
);

Map<String, dynamic> _$ShareCardsToJson(_ShareCards instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'expectedReturnDate': instance.expectedReturnDate?.toIso8601String(),
      'returnedAt': instance.returnedAt?.toIso8601String(),
      'status': _$ShareCardsStatusEnumMap[instance.status],
      'notes': instance.notes,
      'lender': instance.lender,
      'applicant': instance.applicant,
      'lendingCards': instance.lendingCards,
      'lendingDate': instance.lendingDate?.toIso8601String(),
    };

const _$ShareCardsStatusEnumMap = {
  ShareCardsStatus.active: 'active',
  ShareCardsStatus.returned: 'returned',
  ShareCardsStatus.overdue: 'overdue',
};
