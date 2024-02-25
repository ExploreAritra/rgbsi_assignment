// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RandomUserModel _$RandomUserModelFromJson(Map<String, dynamic> json) =>
    RandomUserModel(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      info: json['info'] == null
          ? null
          : InfoModel.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RandomUserModelToJson(RandomUserModel instance) =>
    <String, dynamic>{
      'results': instance.results,
      'info': instance.info,
    };

InfoModel _$InfoModelFromJson(Map<String, dynamic> json) => InfoModel(
      seed: json['seed'] as String?,
      results: json['results'] as int?,
      page: json['page'] as int?,
      version: json['version'] as String?,
    );

Map<String, dynamic> _$InfoModelToJson(InfoModel instance) => <String, dynamic>{
      'seed': instance.seed,
      'results': instance.results,
      'page': instance.page,
      'version': instance.version,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      gender: json['gender'] as String?,
      name: json['name'] == null
          ? null
          : NameModel.fromJson(json['name'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      email: json['email'] as String?,
      login: json['login'] == null
          ? null
          : LoginModel.fromJson(json['login'] as Map<String, dynamic>),
      dob: json['dob'] == null
          ? null
          : DobModel.fromJson(json['dob'] as Map<String, dynamic>),
      registered: json['registered'] == null
          ? null
          : DobModel.fromJson(json['registered'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      cell: json['cell'] as String?,
      id: json['id'] == null
          ? null
          : IdModel.fromJson(json['id'] as Map<String, dynamic>),
      picture: json['picture'] == null
          ? null
          : PictureModel.fromJson(json['picture'] as Map<String, dynamic>),
      nat: json['nat'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'gender': instance.gender,
      'name': instance.name,
      'location': instance.location,
      'email': instance.email,
      'login': instance.login,
      'dob': instance.dob,
      'registered': instance.registered,
      'phone': instance.phone,
      'cell': instance.cell,
      'id': instance.id,
      'picture': instance.picture,
      'nat': instance.nat,
    };

DobModel _$DobModelFromJson(Map<String, dynamic> json) => DobModel(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      age: json['age'] as int?,
    );

Map<String, dynamic> _$DobModelToJson(DobModel instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'age': instance.age,
    };

IdModel _$IdModelFromJson(Map<String, dynamic> json) => IdModel(
      name: json['name'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$IdModelToJson(IdModel instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      street: json['street'] == null
          ? null
          : StreetModel.fromJson(json['street'] as Map<String, dynamic>),
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postcode: json['postcode']?.toString() as String?,
      coordinates: json['coordinates'] == null
          ? null
          : CoordinatesModel.fromJson(
              json['coordinates'] as Map<String, dynamic>),
      timezone: json['timezone'] == null
          ? null
          : TimezoneModel.fromJson(json['timezone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postcode': instance.postcode,
      'coordinates': instance.coordinates,
      'timezone': instance.timezone,
    };

CoordinatesModel _$CoordinatesModelFromJson(Map<String, dynamic> json) =>
    CoordinatesModel(
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );

Map<String, dynamic> _$CoordinatesModelToJson(CoordinatesModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

StreetModel _$StreetModelFromJson(Map<String, dynamic> json) => StreetModel(
      number: json['number'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$StreetModelToJson(StreetModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
    };

TimezoneModel _$TimezoneModelFromJson(Map<String, dynamic> json) =>
    TimezoneModel(
      offset: json['offset'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$TimezoneModelToJson(TimezoneModel instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'description': instance.description,
    };

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      uuid: json['uuid'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      salt: json['salt'] as String?,
      md5: json['md5'] as String?,
      sha1: json['sha1'] as String?,
      sha256: json['sha256'] as String?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'username': instance.username,
      'password': instance.password,
      'salt': instance.salt,
      'md5': instance.md5,
      'sha1': instance.sha1,
      'sha256': instance.sha256,
    };

NameModel _$NameModelFromJson(Map<String, dynamic> json) => NameModel(
      title: json['title'] as String?,
      first: json['first'] as String?,
      last: json['last'] as String?,
    );

Map<String, dynamic> _$NameModelToJson(NameModel instance) => <String, dynamic>{
      'title': instance.title,
      'first': instance.first,
      'last': instance.last,
    };

PictureModel _$PictureModelFromJson(Map<String, dynamic> json) => PictureModel(
      large: json['large'] as String?,
      medium: json['medium'] as String?,
      thumbnail: json['thumbnail'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$PictureModelToJson(PictureModel instance) =>
    <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
      'thumbnail': instance.thumbnail,
      'path': instance.path,
    };
