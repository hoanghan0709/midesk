// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'APIsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIsResponse _$APIsResponseFromJson(Map<String, dynamic> json) => APIsResponse(
      json['status'] as bool,
      json['message'] as String,
      Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$APIsResponseToJson(APIsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
