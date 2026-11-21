import 'package:intl/intl.dart';

final NumberFormat _rupiah = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp ',
  decimalDigits: 0,
);
final DateFormat _tanggalDb = DateFormat('yyyy-MM-dd');
final DateFormat _tanggalTampil = DateFormat('d MMM y', 'id_ID');

class PromoGame {
  const PromoGame({
    required this.idPromo,
    required this.namaGame,
    required this.platform,
    required this.hargaAwal,
    required this.hargaDiskon,
    required this.gambarGame,
    required this.batasPromo,
    required this.statusPromo,
    required this.genre,
    required this.deskripsi,
    this.sumber = 'manual',
  });

  final int idPromo;
  final String namaGame;
  final String platform;
  final double hargaAwal;
  final double hargaDiskon;
  final String gambarGame;
  final DateTime batasPromo;
  final String statusPromo;
  final String genre;
  final String deskripsi;
  final String sumber;

  factory PromoGame.fromJson(Map<String, dynamic> json) {
    return PromoGame(
      idPromo: int.tryParse(json['id_promo']?.toString() ?? '') ?? 0,
      namaGame: json['nama_game']?.toString() ?? '',
      platform: json['platform']?.toString() ?? '',
      hargaAwal: double.tryParse(json['harga_awal']?.toString() ?? '') ?? 0,
      hargaDiskon: double.tryParse(json['harga_diskon']?.toString() ?? '') ?? 0,
      gambarGame: json['gambar_game']?.toString() ?? '',
      batasPromo:
          DateTime.tryParse(json['batas_promo']?.toString() ?? '') ??
          DateTime.now(),
      statusPromo: json['status_promo']?.toString() ?? 'aktif',
      genre: json['genre']?.toString() ?? '',
      deskripsi: json['deskripsi']?.toString() ?? '',
      sumber: json['sumber']?.toString() ?? 'manual',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_promo': idPromo,
      'nama_game': namaGame,
      'platform': platform,
      'harga_awal': hargaAwal,
      'harga_diskon': hargaDiskon,
      'gambar_game': gambarGame,
      'batas_promo': _tanggalDb.format(batasPromo),
      'status_promo': statusPromo,
      'genre': genre,
      'deskripsi': deskripsi,
      'sumber': sumber,
    };
  }

  static String formatRupiah(double nilai) => _rupiah.format(nilai);

  int get diskonPersen => hargaAwal <= 0
      ? 0
      : (((hargaAwal - hargaDiskon) / hargaAwal) * 100).round();

  String get labelDiskon => '−$diskonPersen%';

  String get formatHargaAwal => _rupiah.format(hargaAwal);
  String get formatHargaDiskon => _rupiah.format(hargaDiskon);
  String get formatBatasPromo => _tanggalTampil.format(batasPromo);

  String get storeUrl {
    final kata = Uri.encodeQueryComponent(namaGame);
    final nama = platform.toLowerCase();
    if (nama.contains('epic')) {
      return 'https://store.epicgames.com/en-US/browse?q=$kata';
    }
    if (nama.contains('playstation') || nama.contains('ps5')) {
      return 'https://store.playstation.com/en-us/search/$kata';
    }
    if (nama.contains('xbox')) {
      return 'https://www.xbox.com/en-US/search?q=$kata';
    }
    if (nama.contains('nintendo')) {
      return 'https://www.nintendo.com/us/search/#q=$kata';
    }
    return 'https://store.steampowered.com/search/?term=$kata';
  }

  bool get dariCheapShark => sumber == 'cheapshark';

  bool get isAktif => statusPromo == 'aktif';

  bool get isKedaluwarsa {
    final now = DateTime.now();
    final hariIni = DateTime(now.year, now.month, now.day);
    final batas = DateTime(batasPromo.year, batasPromo.month, batasPromo.day);
    return batas.isBefore(hariIni);
  }
}
