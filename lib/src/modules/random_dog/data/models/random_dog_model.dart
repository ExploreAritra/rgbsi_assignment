import 'package:assignment/src/core/constants/constants.dart';

import '../../business/entities/random_dog_entity.dart';

class RandomDogModel extends RandomDogEntity {
  const RandomDogModel({
    String? message,
    String? status,
    String? path,
  }) : super(
    message: message,
    status: status,
    path: path
        );

  RandomDogModel copyWith({
    String? message,
    String? status,
    String? path,
  }) =>
      RandomDogModel(
        message: message ?? this.message,
        status: status ?? this.status,
        path: path ?? this.path,
      );

  factory RandomDogModel.fromJson({required Map<String, dynamic> json}) {
    return RandomDogModel(
      message: json[kUrl],
      status: json[kStatus],
      path: json[kPath],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kUrl: message,
      kStatus: status,
      kPath: path,
    };
  }
}
