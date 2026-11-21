import 'package:dio/dio.dart';

import '../config/api_config.dart';
import '../models/promo_game.dart';

class PromoGameService {
  PromoGameService({Dio? dio})
    : _dio = dio ?? Dio(_baseOptions);

  static BaseOptions get _baseOptions => BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
  );

  final Dio _dio;

  Future<List<PromoGame>> fetchPromos({String query = '', String platform = ''}) async {
    try {
      final response = await _dio.get(
        ApiConfig.read,
        queryParameters: {'q': query, 'platform': platform},
      );
      final body = Map<String, dynamic>.from(response.data as Map);
      if (body['success'] != true) {
        throw Exception(body['message']?.toString() ?? 'Gagal memuat data promo');
      }
      final rows = (body['data'] as List<dynamic>? ?? []);
      return rows
          .map((row) => PromoGame.fromJson(Map<String, dynamic>.from(row as Map)))
          .toList();
    } on DioException catch (e) {
      throw Exception(_pesan(e));
    }
  }

  Future<PromoGame?> fetchPromo(int id) async {
    try {
      final response = await _dio.get(ApiConfig.read, queryParameters: {'id': id});
      final body = Map<String, dynamic>.from(response.data as Map);
      if (body['success'] != true) {
        throw Exception(body['message']?.toString() ?? 'Gagal memuat detail promo');
      }
      final rows = (body['data'] as List<dynamic>? ?? []);
      if (rows.isEmpty) return null;
      return PromoGame.fromJson(Map<String, dynamic>.from(rows.first as Map));
    } on DioException catch (e) {
      throw Exception(_pesan(e));
    }
  }

  Future<void> createPromo(PromoGame promo) async {
    await _kirim(ApiConfig.create, promo.toJson());
  }

  Future<void> updatePromo(PromoGame promo) async {
    await _kirim(ApiConfig.edit, promo.toJson());
  }

  Future<void> deletePromo(int id) async {
    await _kirim(ApiConfig.delete, {'id_promo': id});
  }

  Future<void> _kirim(String url, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(url, data: data);
      final body = Map<String, dynamic>.from(response.data as Map);
      if (body['success'] != true) {
        throw Exception(body['message']?.toString() ?? 'Permintaan gagal');
      }
    } on DioException catch (e) {
      throw Exception(_pesan(e));
    }
  }

  String _pesan(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final message = data['message']?.toString();
      if (message != null && message.isNotEmpty) return message;
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Koneksi ke API timeout. Cek XAMPP dan jaringan.';
      case DioExceptionType.connectionError:
        return 'Tidak dapat terhubung ke API (${ApiConfig.host}). '
            'Pastikan XAMPP aktif dan HP terhubung Wi-Fi yang sama.';
      default:
        return e.message ?? 'Terjadi kesalahan saat menghubungi API';
    }
  }
}
