import 'package:assignment/src/modules/random_user/business/entities/random_user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'random_user_model.g.dart';

RandomUserModel randomUserModelFromJson(String str) => RandomUserModel.fromJson(json.decode(str));

String randomUserModelToJson(RandomUserModel data) => json.encode(data.toJson());

@JsonSerializable()
class RandomUserModel extends RandomUserEntity {
  @override
  @JsonKey(name: "results")
  final List<UserModel>? results;
  @override
  @JsonKey(name: "info")
  final InfoModel? info;

  RandomUserModel({
    this.results,
    this.info,
  }) : super(
    results: results,
    info: info,
  );

  RandomUserModel copyWith({
    List<UserModel>? results,
    InfoModel? info,
  }) =>
      RandomUserModel(
        results: results ?? this.results,
        info: info ?? this.info,
      );

  factory RandomUserModel.fromJson(Map<String, dynamic> json) => _$RandomUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$RandomUserModelToJson(this);
}

@JsonSerializable()
class InfoModel extends InfoEntity{
  @override
  @JsonKey(name: "seed")
  final String? seed;
  @override
  @JsonKey(name: "results")
  final int? results;
  @override
  @JsonKey(name: "page")
  final int? page;
  @override
  @JsonKey(name: "version")
  final String? version;

  InfoModel({
    this.seed,
    this.results,
    this.page,
    this.version,
  }) : super(
    seed: seed,
    results: results,
    page: page,
    version: version,
  );

  InfoModel copyWith({
    String? seed,
    int? results,
    int? page,
    String? version,
  }) =>
      InfoModel(
        seed: seed ?? this.seed,
        results: results ?? this.results,
        page: page ?? this.page,
        version: version ?? this.version,
      );

  factory InfoModel.fromJson(Map<String, dynamic> json) => _$InfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$InfoModelToJson(this);
}

@JsonSerializable()
class UserModel extends UserEntity {
  @override
  @JsonKey(name: "gender")
  final String? gender;
  @override
  @JsonKey(name: "name")
  final NameModel? name;
  @override
  @JsonKey(name: "location")
  final LocationModel? location;
  @override
  @JsonKey(name: "email")
  final String? email;
  @override
  @JsonKey(name: "login")
  final LoginModel? login;
  @override
  @JsonKey(name: "dob")
  final DobModel? dob;
  @override
  @JsonKey(name: "registered")
  final DobModel? registered;
  @override
  @JsonKey(name: "phone")
  final String? phone;
  @override
  @JsonKey(name: "cell")
  final String? cell;
  @override
  @JsonKey(name: "id")
  final IdModel? id;
  @override
  @JsonKey(name: "picture")
  final PictureModel? picture;
  @override
  @JsonKey(name: "nat")
  final String? nat;

  UserModel({
    this.gender,
    this.name,
    this.location,
    this.email,
    this.login,
    this.dob,
    this.registered,
    this.phone,
    this.cell,
    this.id,
    this.picture,
    this.nat,
  }) : super(
    gender: gender,
    name: name,
    location: location,
    email: email,
    login: login,
    dob: dob,
    registered: registered,
    phone: phone,
    cell: cell,
    id: id,
    picture: picture,
    nat: nat,
  );

  UserModel copyWith({
    String? gender,
    NameModel? name,
    LocationModel? location,
    String? email,
    LoginModel? login,
    DobModel? dob,
    DobModel? registered,
    String? phone,
    String? cell,
    IdModel? id,
    PictureModel? picture,
    String? nat,
  }) =>
      UserModel(
        gender: gender ?? this.gender,
        name: name ?? this.name,
        location: location ?? this.location,
        email: email ?? this.email,
        login: login ?? this.login,
        dob: dob ?? this.dob,
        registered: registered ?? this.registered,
        phone: phone ?? this.phone,
        cell: cell ?? this.cell,
        id: id ?? this.id,
        picture: picture ?? this.picture,
        nat: nat ?? this.nat,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class DobModel extends DobEntity{
  @override
  @JsonKey(name: "date")
  final DateTime? date;
  @override
  @JsonKey(name: "age")
  final int? age;

  DobModel({
    this.date,
    this.age,
  }) : super(
    date: date,
    age: age,
  );

  DobModel copyWith({
    DateTime? date,
    int? age,
  }) =>
      DobModel(
        date: date ?? this.date,
        age: age ?? this.age,
      );

  factory DobModel.fromJson(Map<String, dynamic> json) => _$DobModelFromJson(json);

  Map<String, dynamic> toJson() => _$DobModelToJson(this);
}

@JsonSerializable()
class IdModel extends IdEntity{
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "value")
  final String? value;

  IdModel({
    this.name,
    this.value,
  }) : super(
    name: name,
    value: value,
  );

  IdModel copyWith({
    String? name,
    String? value,
  }) =>
      IdModel(
        name: name ?? this.name,
        value: value ?? this.value,
      );

  factory IdModel.fromJson(Map<String, dynamic> json) => _$IdModelFromJson(json);

  Map<String, dynamic> toJson() => _$IdModelToJson(this);
}

@JsonSerializable()
class LocationModel extends LocationEntity{
  @override
  @JsonKey(name: "street")
  final StreetModel? street;
  @override
  @JsonKey(name: "city")
  final String? city;
  @override
  @JsonKey(name: "state")
  final String? state;
  @override
  @JsonKey(name: "country")
  final String? country;
  @override
  @JsonKey(name: "postcode")
  final String? postcode;
  @override
  @JsonKey(name: "coordinates")
  final CoordinatesModel? coordinates;
  @override
  @JsonKey(name: "timezone")
  final TimezoneModel? timezone;

  LocationModel({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.coordinates,
    this.timezone,
  }) : super(
    street: street,
    city: city,
    state: state,
    country: country,
    postcode: postcode,
    coordinates: coordinates,
    timezone: timezone,
  );

  LocationModel copyWith({
    StreetModel? street,
    String? city,
    String? state,
    String? country,
    String? postcode,
    CoordinatesModel? coordinates,
    TimezoneModel? timezone,
  }) =>
      LocationModel(
        street: street ?? this.street,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        postcode: postcode ?? this.postcode,
        coordinates: coordinates ?? this.coordinates,
        timezone: timezone ?? this.timezone,
      );

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}

@JsonSerializable()
class CoordinatesModel extends CoordinatesEntity{
  @override
  @JsonKey(name: "latitude")
  final String? latitude;
  @override
  @JsonKey(name: "longitude")
  final String? longitude;

  CoordinatesModel({
    this.latitude,
    this.longitude,
  }) : super(
    latitude: latitude,
    longitude: longitude,
  );

  CoordinatesModel copyWith({
    String? latitude,
    String? longitude,
  }) =>
      CoordinatesModel(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) => _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);
}

@JsonSerializable()
class StreetModel extends StreetEntity{
  @override
  @JsonKey(name: "number")
  final int? number;
  @override
  @JsonKey(name: "name")
  final String? name;

  StreetModel({
    this.number,
    this.name,
  }) : super(
    number: number,
    name: name,
  );

  StreetModel copyWith({
    int? number,
    String? name,
  }) =>
      StreetModel(
        number: number ?? this.number,
        name: name ?? this.name,
      );

  factory StreetModel.fromJson(Map<String, dynamic> json) => _$StreetModelFromJson(json);

  Map<String, dynamic> toJson() => _$StreetModelToJson(this);
}

@JsonSerializable()
class TimezoneModel extends TimezoneEntity{
  @override
  @JsonKey(name: "offset")
  final String? offset;
  @override
  @JsonKey(name: "description")
  final String? description;

  TimezoneModel({
    this.offset,
    this.description,
  }) : super(
    offset: offset,
    description: description,
  );

  TimezoneModel copyWith({
    String? offset,
    String? description,
  }) =>
      TimezoneModel(
        offset: offset ?? this.offset,
        description: description ?? this.description,
      );

  factory TimezoneModel.fromJson(Map<String, dynamic> json) => _$TimezoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimezoneModelToJson(this);
}

@JsonSerializable()
class LoginModel extends LoginEntity{
  @override
  @JsonKey(name: "uuid")
  final String? uuid;
  @override
  @JsonKey(name: "username")
  final String? username;
  @override
  @JsonKey(name: "password")
  final String? password;
  @override
  @JsonKey(name: "salt")
  final String? salt;
  @override
  @JsonKey(name: "md5")
  final String? md5;
  @override
  @JsonKey(name: "sha1")
  final String? sha1;
  @override
  @JsonKey(name: "sha256")
  final String? sha256;

  LoginModel({
    this.uuid,
    this.username,
    this.password,
    this.salt,
    this.md5,
    this.sha1,
    this.sha256,
  }) : super(
    uuid: uuid,
    username: username,
    password: password,
    salt: salt,
    md5: md5,
    sha1: sha1,
    sha256: sha256,
  );

  LoginModel copyWith({
    String? uuid,
    String? username,
    String? password,
    String? salt,
    String? md5,
    String? sha1,
    String? sha256,
  }) =>
      LoginModel(
        uuid: uuid ?? this.uuid,
        username: username ?? this.username,
        password: password ?? this.password,
        salt: salt ?? this.salt,
        md5: md5 ?? this.md5,
        sha1: sha1 ?? this.sha1,
        sha256: sha256 ?? this.sha256,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class NameModel extends NameEntity{
  @override
  @JsonKey(name: "title")
  final String? title;
  @override
  @JsonKey(name: "first")
  final String? first;
  @override
  @JsonKey(name: "last")
  final String? last;

  NameModel({
    this.title,
    this.first,
    this.last,
  }) : super(
    title: title,
    first: first,
    last: last,
  );

  NameModel copyWith({
    String? title,
    String? first,
    String? last,
  }) =>
      NameModel(
        title: title ?? this.title,
        first: first ?? this.first,
        last: last ?? this.last,
      );

  factory NameModel.fromJson(Map<String, dynamic> json) => _$NameModelFromJson(json);

  Map<String, dynamic> toJson() => _$NameModelToJson(this);
}

@JsonSerializable()
class PictureModel extends PictureEntity{
  @override
  @JsonKey(name: "large")
  final String? large;
  @override
  @JsonKey(name: "medium")
  final String? medium;
  @override
  @JsonKey(name: "thumbnail")
  final String? thumbnail;
  @override
  @JsonKey(name: "path")
  final String? path;

  PictureModel({
    this.large,
    this.medium,
    this.thumbnail,
    this.path,
  }) : super(
    large: large,
    medium: medium,
    thumbnail: thumbnail,
    path: path,
  );

  PictureModel copyWith({
    String? large,
    String? medium,
    String? thumbnail,
    String? path,
  }) =>
      PictureModel(
        large: large ?? this.large,
        medium: medium ?? this.medium,
        thumbnail: thumbnail ?? this.thumbnail,
        path: path ?? this.path,
      );

  factory PictureModel.fromJson(Map<String, dynamic> json) => _$PictureModelFromJson(json);

  Map<String, dynamic> toJson() => _$PictureModelToJson(this);
}
