import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../config/api_config.dart';
import '../config/app_keys.dart';
import '../models/promo_game.dart';
import '../providers/promo_game_provider.dart';
import '../config/app_theme.dart';

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
  late final TextEditingController _platformController;
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
    _platformController = TextEditingController(text: promo?.platform ?? 'PC');
    _status = promo?.statusPromo ?? ApiConfig.statusOptions.first;
    _batas = promo?.batasPromo ?? DateTime.now().add(Duration(days: 30));
  }

  @override
  void dispose() {
    _nama.dispose();
    _hargaAwal.dispose();
    _hargaDiskon.dispose();
    _gambar.dispose();
    _genre.dispose();
    _deskripsi.dispose();
    _platformController.dispose();
    super.dispose();
  }

  InputDecoration _decor(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(color: context.palette.textMuted),
      hintStyle: TextStyle(color: context.palette.textSubtle),
      filled: true,
      fillColor: context.palette.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: context.palette.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: context.palette.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: context.palette.accent),
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
        SnackBar(content: Text('Harga diskon tidak boleh lebih besar dari harga awal')),
      );
      return;
    }

    setState(() => _saving = true);
    final promo = PromoGame(
      idPromo: widget.promo?.idPromo ?? 0,
      namaGame: _nama.text.trim(),
      platform: _platformController.text.trim(),
      hargaAwal: awal,
      hargaDiskon: diskon,
      gambarGame: _gambar.text.trim(),
      batasPromo: _batas,
      statusPromo: _status,
      genre: _genre.text.trim(),
      deskripsi: _deskripsi.text.trim(),
      toko: widget.promo?.toko ?? '',
    );

    final provider = context.read<PromoGameProvider>();
    final berhasil = _modeEdit
        ? await provider.updatePromo(promo)
        : await provider.createPromo(promo);

    if (!mounted) return;
    setState(() => _saving = false);
    final pesan = berhasil
        ? (_modeEdit
            ? 'Promo berhasil diperbarui'
            : 'Promo berhasil ditambahkan')
        : (provider.error?.trim().isNotEmpty ?? false
            ? provider.error!
            : 'Gagal menyimpan promo. Cek koneksi ke API.');
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(pesan)),
    );
    if (berhasil) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.background,
      appBar: AppBar(
        backgroundColor: context.palette.background,
        title: Text(
          _modeEdit ? 'Ubah Promo' : 'Tambah Promo',
          style: TextStyle(color: context.palette.text, fontSize: 18),
        ),
        iconTheme: IconThemeData(color: context.palette.text),
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
                TextFormField(
                  controller: _platformController,
                  decoration: _decor(
                    'Platform',
                    hint: 'Contoh: Steam, Epic Games, PlayStation',
                  ).copyWith(
                    helperText: 'Boleh lebih dari satu, pisahkan dengan koma',
                    helperStyle: TextStyle(
                      color: context.palette.textSubtle,
                      fontSize: 10,
                    ),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Platform wajib diisi'
                      : null,
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
                      style: TextStyle(color: context.palette.text),
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
                        dropdownColor: context.palette.surface,
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
                      backgroundColor: context.palette.accent,
                      foregroundColor: context.palette.onAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _saving ? null : _simpan,
                    child: _saving
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: context.palette.onAccent,
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
