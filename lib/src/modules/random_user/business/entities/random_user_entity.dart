
class RandomUserEntity {
  final List<UserEntity>? results;
  final InfoEntity? info;

  const RandomUserEntity({
    this.results,
    this.info,
  });
}

class InfoEntity {
  final String? seed;
  final int? results;
  final int? page;
  final String? version;

  const InfoEntity({
    this.seed,
    this.results,
    this.page,
    this.version,
  });
}

class UserEntity {
  final String? gender;
  final NameEntity? name;
  final LocationEntity? location;
  final String? email;
  final LoginEntity? login;
  final DobEntity? dob;
  final DobEntity? registered;
  final String? phone;
  final String? cell;
  final IdEntity? id;
  final PictureEntity? picture;
  final String? nat;

  const UserEntity({
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
  });
}

class DobEntity {
  final DateTime? date;
  final int? age;

  const DobEntity({
    this.date,
    this.age,
  });
}

class IdEntity {
  final String? name;
  final String? value;

  const IdEntity({
    this.name,
    this.value,
  });
}

class LocationEntity {
  final StreetEntity? street;
  final String? city;
  final String? state;
  final String? country;
  final String? postcode;
  final CoordinatesEntity? coordinates;
  final TimezoneEntity? timezone;

  const LocationEntity({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.coordinates,
    this.timezone,
  });
}

class CoordinatesEntity {
  final String? latitude;
  final String? longitude;

  const CoordinatesEntity({
    this.latitude,
    this.longitude,
  });
}

class StreetEntity {
  final int? number;
  final String? name;

  const StreetEntity({
    this.number,
    this.name,
  });
}

class TimezoneEntity {
  final String? offset;
  final String? description;

  const TimezoneEntity({
    this.offset,
    this.description,
  });
}

class LoginEntity {
  final String? uuid;
  final String? username;
  final String? password;
  final String? salt;
  final String? md5;
  final String? sha1;
  final String? sha256;

  const LoginEntity({
    this.uuid,
    this.username,
    this.password,
    this.salt,
    this.md5,
    this.sha1,
    this.sha256,
  });
}

class NameEntity {
  final String? title;
  final String? first;
  final String? last;

  const NameEntity({
    this.title,
    this.first,
    this.last,
  });
}

class PictureEntity {
  final String? large;
  final String? medium;
  final String? thumbnail;
  final String? path;

  const PictureEntity({
    this.large,
    this.medium,
    this.thumbnail,
    this.path,
  });
}
