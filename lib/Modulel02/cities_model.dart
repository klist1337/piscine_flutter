
class Cities {
    int id;
    String name;
    double latitude;
    double longitude;
    int elevation;
    String featureCode;
    String countryCode;
    int admin1Id;
    int admin2Id;
    String timezone;
    int population;
    List<String>? postcodes;
    int countryId;
    String country;
    String admin1;
    String admin2;

    Cities({
        required this.id,
        required this.name,
        required this.latitude,
        required this.longitude,
        required this.elevation,
        required this.featureCode,
        required this.countryCode,
        required this.admin1Id,
        required this.admin2Id,
        required this.timezone,
        required this.population,
        this.postcodes,
        required this.countryId,
        required this.country,
        required this.admin1,
        required this.admin2,
    });

    Cities copyWith({
        int? id,
        String? name,
        double? latitude,
        double? longitude,
        int? elevation,
        String? featureCode,
        String? countryCode,
        int? admin1Id,
        int? admin2Id,
        String? timezone,
        int? population,
        List<String>? postcodes,
        int? countryId,
        String? country,
        String? admin1,
        String? admin2,
    }) => 
        Cities(
            id: id ?? this.id,
            name: name ?? this.name,
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
            elevation: elevation ?? this.elevation,
            featureCode: featureCode ?? this.featureCode,
            countryCode: countryCode ?? this.countryCode,
            admin1Id: admin1Id ?? this.admin1Id,
            admin2Id: admin2Id ?? this.admin2Id,
            timezone: timezone ?? this.timezone,
            population: population ?? this.population,
            postcodes: postcodes ?? this.postcodes,
            countryId: countryId ?? this.countryId,
            country: country ?? this.country,
            admin1: admin1 ?? this.admin1,
            admin2: admin2 ?? this.admin2,
        );

    factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        elevation: json["elevation"],
        featureCode: json["feature_code"],
        countryCode: json["country_code"],
        admin1Id: json["admin1_id"],
        admin2Id: json["admin2_id"],
        timezone: json["timezone"],
        population: json["population"],
        postcodes: json["postcodes"] != null ?
         List<String>.from(json["postcodes"].map((x) => x))
         : null,
        countryId: json["country_id"],
        country: json["country"],
        admin1: json["admin1"],
        admin2: json["admin2"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "elevation": elevation,
        "feature_code": featureCode,
        "country_code": countryCode,
        "admin1_id": admin1Id,
        "admin2_id": admin2Id,
        "timezone": timezone,
        "population": population,
        "postcodes": postcodes != null ?
         List<dynamic>.from(postcodes!.map((x) => x))
         : null,
        "country_id": countryId,
        "country": country,
        "admin1": admin1,
        "admin2": admin2,
    };
}
