import 'dart:convert';

class Details {
  Details({
    required this.madlineEmail,
    required this.madlineNumber,
    required this.smChannels,
    required this.successStudents,
    required this.id,
    required this.brands,
    required this.guidNumber,
    required this.enquiryLink,
  });

  final String madlineEmail;
  final String madlineNumber;
  final List<MetaData> smChannels;
  final List<SuccessStudent> successStudents;
  final String id;
  final List<MetaData> brands;
  final String guidNumber;
  final String enquiryLink;

  Details copyWith({
    String? madlineEmail,
    String? madlineNumber,
    List<MetaData>? smChannels,
    List<SuccessStudent>? successStudents,
    String? id,
    List<MetaData>? brands,
    String? guidNumber,
    String? enquiryLink,
  }) =>
      Details(
        madlineEmail: madlineEmail ?? this.madlineEmail,
        madlineNumber: madlineNumber ?? this.madlineNumber,
        smChannels: smChannels ?? this.smChannels,
        successStudents: successStudents ?? this.successStudents,
        id: id ?? this.id,
        brands: brands ?? this.brands,
        guidNumber: guidNumber ?? this.guidNumber,
        enquiryLink: enquiryLink ?? this.enquiryLink,
      );

  factory Details.fromJson(String str) => Details.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Details.fromMap(Map<String, dynamic> json) => Details(
        madlineEmail: json["madlineEmail"],
        madlineNumber: json["madlineNumber"],
        smChannels: List<MetaData>.from(
            json["smChannels"].map((x) => MetaData.fromMap(x))),
        successStudents: List<SuccessStudent>.from(
            json["successStudents"].map((x) => SuccessStudent.fromMap(x))),
        id: json["id"],
        brands:
            List<MetaData>.from(json["brands"].map((x) => MetaData.fromMap(x))),
        guidNumber: json["guidNumber"],
        enquiryLink: json["enquiryLink"],
      );

  Map<String, dynamic> toMap() => {
        "madlineEmail": madlineEmail,
        "madlineNumber": madlineNumber,
        "smChannels": List<dynamic>.from(smChannels.map((x) => x.toMap())),
        "successStudents":
            List<dynamic>.from(successStudents.map((x) => x.toMap())),
        "id": id,
        "brands": List<dynamic>.from(brands.map((x) => x.toMap())),
        "guidNumber": guidNumber,
        "enquiryLink": enquiryLink,
      };
}

class MetaData {
  MetaData({
    required this.name,
    required this.link,
    required this.image,
  });

  final String name;
  final String link;
  final String image;

  MetaData copyWith({
    String? name,
    String? link,
    String? image,
  }) =>
      MetaData(
        name: name ?? this.name,
        link: link ?? this.link,
        image: image ?? this.image,
      );

  factory MetaData.fromJson(String str) => MetaData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MetaData.fromMap(Map<String, dynamic> json) => MetaData(
        name: json["name"],
        link: json["link"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "link": link,
        "image": image,
      };
}

class SuccessStudent {
  SuccessStudent({
    required this.name,
    required this.brandlogo,
    required this.label,
    required this.image,
  });

  final String name;
  final String brandlogo;
  final String label;
  final String image;

  SuccessStudent copyWith({
    String? name,
    String? brandlogo,
    String? label,
    String? image,
  }) =>
      SuccessStudent(
        name: name ?? this.name,
        brandlogo: brandlogo ?? this.brandlogo,
        label: label ?? this.label,
        image: image ?? this.image,
      );

  factory SuccessStudent.fromJson(String str) =>
      SuccessStudent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuccessStudent.fromMap(Map<String, dynamic> json) => SuccessStudent(
        name: json["name"],
        brandlogo: json["brandlogo"],
        label: json["label"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "brandlogo": brandlogo,
        "label": label,
        "image": image,
      };
}
