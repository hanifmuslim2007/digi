import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../config/api_config.dart';
import '../config/app_keys.dart';
import '../models/promo_game.dart';
import '../providers/promo_game_provider.dart';

class PromoFormPage extends StatefulWidget {
  const PromoFormPage({super.key, this.promo});

  final PromoGame? promo;

  @override
  State<PromoFormPage> createState() => _PromoFormPageState();
}

class _PromoFormPageState extends State<PromoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final DateFormat _tanggal = DateFormat('yyyy-MM-dd');

  late final TextEditingController _nama;
  late final TextEditingController _hargaAwal;
  late final TextEditingController _hargaDiskon;
  late final TextEditingController _gambar;
  late final TextEditingController _genre;
  late final TextEditingController _deskripsi;
  late String _platform;
  late String _status;
  late DateTime _batas;
  bool _saving = false;

  bool get _modeEdit => widget.promo != null;

  @override
  void initState() {
    super.initState();
    final promo = widget.promo;
    _nama = TextEditingController(text: promo?.namaGame ?? '');
    _hargaAwal = TextEditingController(
      text: promo == null ? '' : promo.hargaAwal.toStringAsFixed(0),
    );
    _hargaDiskon = TextEditingController(
      text: promo == null ? '' : promo.hargaDiskon.toStringAsFixed(0),
    );
    _gambar = TextEditingController(text: promo?.gambarGame ?? '');
    _genre = TextEditingController(text: promo?.genre ?? '');
    _deskripsi = TextEditingController(text: promo?.deskripsi ?? '');
    _platform = promo?.platform ?? ApiConfig.platformOptions.first;
    _status = promo?.statusPromo ?? ApiConfig.statusOptions.first;
    _batas = promo?.batasPromo ?? DateTime.now().add(const Duration(days: 30));
  }

  @override
  void dispose() {
    _nama.dispose();
    _hargaAwal.dispose();
    _hargaDiskon.dispose();
    _gambar.dispose();
    _genre.dispose();
    _deskripsi.dispose();
    super.dispose();
  }

  InputDecoration _decor(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Color(0xFF97A3B5)),
      hintStyle: const TextStyle(color: Color(0xFF68768A)),
      filled: true,
      fillColor: const Color(0xFF161D28),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF29323F)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF29323F)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFBBF76A)),
      ),
    );
  }

  double? _angka(String value) =>
      double.tryParse(value.trim().replaceAll(',', '.'));

  String? _validasiAngka(String? value, String label) {
    if (value == null || value.trim().isEmpty) return '$label wajib diisi';
    if (_angka(value) == null) return '$label harus berupa angka';
    return null;
  }

  Future<void> _pilihTanggal() async {
    final now = DateTime.now();
    final pilihan = await showDatePicker(
      context: context,
      initialDate: _batas,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 10),
    );
    if (pilihan != null) setState(() => _batas = pilihan);
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;

    final awal = _angka(_hargaAwal.text) ?? 0;
    final diskon = _angka(_hargaDiskon.text) ?? 0;
    if (diskon > awal) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Harga diskon tidak boleh lebih besar dari harga awal')),
      );
      return;
    }

    setState(() => _saving = true);
    final promo = PromoGame(
      idPromo: widget.promo?.idPromo ?? 0,
      namaGame: _nama.text.trim(),
      platform: _platform,
      hargaAwal: awal,
      hargaDiskon: diskon,
      gambarGame: _gambar.text.trim(),
      batasPromo: _batas,
      statusPromo: _status,
      genre: _genre.text.trim(),
      deskripsi: _deskripsi.text.trim(),
    );

    final provider = context.read<PromoGameProvider>();
    final berhasil = _modeEdit
        ? await provider.updatePromo(promo)
        : await provider.createPromo(promo);

    if (!mounted) return;
    setState(() => _saving = false);
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          berhasil
              ? (_modeEdit
                  ? 'Promo berhasil diperbarui'
                  : 'Promo berhasil ditambahkan')
              : 'Gagal menyimpan promo. Cek koneksi ke API.',
        ),
      ),
    );
    if (berhasil) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1017),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C1017),
        title: Text(
          _modeEdit ? 'Ubah Promo' : 'Tambah Promo',
          style: const TextStyle(color: Color(0xFFF6F7FB), fontSize: 18),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF6F7FB)),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            child: Column(
              children: [
                TextFormField(
                  controller: _nama,
                  decoration: _decor('Nama game'),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Nama game wajib diisi'
                      : null,
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: _platform,
                  decoration: _decor('Platform'),
                  dropdownColor: const Color(0xFF161D28),
                  items: [
                    for (final item in ApiConfig.platformOptions)
                      DropdownMenuItem(value: item, child: Text(item)),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _platform = value);
                  },
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _hargaAwal,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: _decor('Harga awal'),
                        validator: (value) => _validasiAngka(value, 'Harga awal'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _hargaDiskon,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: _decor('Harga diskon'),
                        validator: (value) =>
                            _validasiAngka(value, 'Harga diskon'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _gambar,
                  decoration: _decor('URL gambar game'),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'URL gambar wajib diisi'
                      : null,
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: _pilihTanggal,
                  child: InputDecorator(
                    decoration: _decor('Batas promo'),
                    child: Text(
                      _tanggal.format(_batas),
                      style: const TextStyle(color: Color(0xFFF6F7FB)),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: _status,
                        decoration: _decor('Status'),
                        dropdownColor: const Color(0xFF161D28),
                        items: [
                          for (final item in ApiConfig.statusOptions)
                            DropdownMenuItem(value: item, child: Text(item)),
                        ],
                        onChanged: (value) {
                          if (value != null) setState(() => _status = value);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _genre,
                        decoration: _decor('Genre'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _deskripsi,
                  maxLines: 4,
                  decoration: _decor('Deskripsi (opsional)'),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFBBF76A),
                      foregroundColor: const Color(0xFF13200D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _saving ? null : _simpan,
                    child: _saving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Color(0xFF13200D),
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            _modeEdit ? 'Simpan Perubahan' : 'Tambah Promo',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
