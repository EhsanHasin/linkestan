class VisitCardMap {
  final int? id;
  final String name;
  final String address;
  final String phoneNumber;
  final String description;
  final String imageUrl;
  final String type;
  late final int favorite;
  final String createdAt;

  VisitCardMap({
    this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.description,
    required this.imageUrl,
    required this.type,
    this.favorite = 0,
    required this.createdAt,
  });

  factory VisitCardMap.fromMap(Map<String, dynamic> map) {
    return VisitCardMap(
      id: map['vc_id'],
      name: map['vc_name'],
      address: map['vc_address'],
      phoneNumber: map['vc_phone_number'],
      description: map['vc_description'],
      imageUrl: map['vc_image_url'],
      type: map['vc_type'],
      favorite: map['vc_favorite'],
      createdAt: map['vc_created_at'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vc_name': name,
      'vc_address': address,
      'vc_phone_number': phoneNumber,
      'vc_description': description,
      'vc_image_url': imageUrl,
      'vc_type': type,
      'vc_favorite': favorite,
      'vc_created_at': createdAt,
    };
  }
  VisitCardMap copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    String? imageUrl,
    int? favorite,
    String? address,
    String? description,
    String? type,
    String? createdAt,
  }) {
    return VisitCardMap(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      favorite: favorite ?? this.favorite,
      address: address ?? this.address,
      description: description ?? this.description,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
