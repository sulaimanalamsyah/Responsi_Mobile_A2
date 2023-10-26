class Ikan {
  final String id;
  final String nama;
  final String jenis;
  final String warna;
  final String habitat;

  Ikan({
    required this.id,
    required this.nama,
    required this.jenis,
    required this.warna,
    required this.habitat,
  });

  factory Ikan.fromJson(Map<String, dynamic> json) {
    return Ikan(
      id: json['id'],
      nama: json['nama'],
      jenis: json['jenis'],
      warna: json['warna'],
      habitat: json['habitat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'jenis': jenis,
      'warna': warna,
      'habitat': habitat,
    };
  }
}
