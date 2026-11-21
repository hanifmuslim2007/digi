class ApiConfig {
  static const String host = '192.168.1.3';
  static const String baseUrl = 'http://$host/api_digi';

  static const String read = '$baseUrl/read.php';
  static const String create = '$baseUrl/create.php';
  static const String edit = '$baseUrl/edit.php';
  static const String delete = '$baseUrl/delete.php';
  static const String syncCheapShark = '$baseUrl/sync_cheapshark.php';

  /// Jumlah deal CheapShark yang diambil setiap kali sinkron.
  static const int cheapSharkJumlah = 12;

  static const List<String> platformOptions = [
    'Steam',
    'Epic Games',
    'PlayStation',
    'Xbox',
    'Nintendo Switch',
    'PC',
  ];

  static const List<String> statusOptions = ['aktif', 'nonaktif'];
}
