import 'package:flutter/foundation.dart';

import '../models/promo_game.dart';
import '../models/sync_result.dart';
import '../services/promo_game_service.dart';

class PromoGameProvider extends ChangeNotifier {
  PromoGameProvider({PromoGameService? service})
    : _service = service ?? PromoGameService();

  final PromoGameService _service;

  List<PromoGame> _promos = [];
  bool _loading = false;
  bool _syncing = false;
  String? _error;
  String _query = '';
  String _platform = 'All';

  List<PromoGame> get promos => List.unmodifiable(_promos);
  bool get loading => _loading;
  bool get syncing => _syncing;
  String? get error => _error;
  String get query => _query;
  String get platform => _platform;

  List<PromoGame> get filteredPromos {
    final kata = _query.trim().toLowerCase();
    return _promos.where((promo) {
      final cocokKata = kata.isEmpty ||
          promo.namaGame.toLowerCase().contains(kata) ||
          promo.platform.toLowerCase().contains(kata) ||
          promo.toko.toLowerCase().contains(kata) ||
          promo.genre.toLowerCase().contains(kata);
      return cocokKata && _cocokPlatform(promo);
    }).toList();
  }

  List<PromoGame> get topDeals {
    final kandidat = filteredPromos.where((promo) => promo.isAktif).toList();
    final sumber = kandidat.isEmpty ? filteredPromos : kandidat;
    sumber.sort((a, b) {
      final selisihDiskon = b.diskonPersen.compareTo(a.diskonPersen);
      if (selisihDiskon != 0) return selisihDiskon;
      return a.batasPromo.compareTo(b.batasPromo);
    });
    return sumber.take(4).toList();
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setPlatform(String value) {
    _platform = value;
    notifyListeners();
  }

  Future<void> loadPromos() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _promos = await _service.fetchPromos();
    } catch (e) {
      _error = _pesan(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<SyncResult?> syncFromCheapShark() async {
    _syncing = true;
    _error = null;
    notifyListeners();
    try {
      final hasil = await _service.syncCheapShark();
      await loadPromos();
      return hasil;
    } catch (e) {
      _error = _pesan(e);
      return null;
    } finally {
      _syncing = false;
      notifyListeners();
    }
  }

  Future<bool> createPromo(PromoGame promo) async {
    return _jalankan(() => _service.createPromo(promo));
  }

  Future<bool> updatePromo(PromoGame promo) async {
    final berhasil = await _jalankan(() => _service.updatePromo(promo));
    if (berhasil) {
      final index = _promos.indexWhere((item) => item.idPromo == promo.idPromo);
      if (index != -1) {
        _promos[index] = promo;
        notifyListeners();
      }
    }
    return berhasil;
  }

  Future<bool> deletePromo(int id) async {
    final berhasil = await _jalankan(() => _service.deletePromo(id));
    if (berhasil) {
      _promos.removeWhere((item) => item.idPromo == id);
      notifyListeners();
    }
    return berhasil;
  }

  Future<bool> _jalankan(Future<void> Function() aksi) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      await aksi();
      await loadPromos();
      return true;
    } catch (e) {
      _error = _pesan(e);
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  bool _cocokPlatform(PromoGame promo) {
    if (_platform == 'All') return true;
    // Cek setiap platform yang melekat pada satu promo.
    bool cocok(String kata) =>
        promo.daftarPlatform.any((nama) => nama.toLowerCase().contains(kata));

    switch (_platform) {
      case 'PC':
        // CheapShark hanya menyediakan toko PC; semua platform toko tersebut
        // harus tetap masuk filter "PC".
        const pc = [
          'steam', 'epic', 'gog', 'ubisoft', 'humble', 'fanatical',
          'gamebillet', 'wingamestore', 'amazon', 'gamestop', 'origin',
          'blizzard', 'gamesplanet', '2game', 'voidu', 'indiegala',
          'dlgamer', 'gamersgate', 'pc',
        ];
        return pc.any(cocok);
      case 'PS5':
        return cocok('playstation') || cocok('ps5');
      default:
        return cocok(_platform.toLowerCase());
    }
  }

  String _pesan(Object error) =>
      error.toString().replaceFirst('Exception: ', '');
}
