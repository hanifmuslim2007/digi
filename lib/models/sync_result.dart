class SyncResult {
  const SyncResult({
    required this.ditambah,
    required this.diperbarui,
    required this.dihapus,
    required this.dilewati,
    required this.kurs,
    required this.metacritic,
    required this.batasPromo,
    required this.message,
  });

  factory SyncResult.fromJson(Map<String, dynamic> json) {
    return SyncResult(
      ditambah: int.tryParse(json['ditambah']?.toString() ?? '') ?? 0,
      diperbarui: int.tryParse(json['diperbarui']?.toString() ?? '') ?? 0,
      dihapus: int.tryParse(json['dihapus']?.toString() ?? '') ?? 0,
      dilewati: int.tryParse(json['dilewati']?.toString() ?? '') ?? 0,
      kurs: double.tryParse(json['kurs']?.toString() ?? '') ?? 0,
      metacritic: int.tryParse(json['metacritic']?.toString() ?? '') ?? 0,
      batasPromo: json['batas_promo']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
    );
  }

  final int ditambah;
  final int diperbarui;
  final int dihapus;
  final int dilewati;
  final double kurs;
  final int metacritic;
  final String batasPromo;
  final String message;

  int get total => ditambah + diperbarui;

  String get ringkasan {
    final bagian = <String>[
      if (ditambah > 0) '$ditambah ditambah',
      if (diperbarui > 0) '$diperbarui diperbarui',
    ];
    if (bagian.isEmpty) return 'Belum ada perubahan data';
    return bagian.join(', ');
  }
}
