class Servico {
  final String id;
  final String jogadorId;
  final String tipo;
  final String status;
  final String data; // Mantém como String

  Servico({
    required this.id,
    required this.jogadorId,
    required this.tipo,
    required this.status,
    required this.data,
  });

  // Converte um Servico em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jogadorId': jogadorId,
      'tipo': tipo,
      'status': status,
      'data': data,
    };
  }

  // Constrói um Servico a partir de um Map
  factory Servico.fromMap(Map<String, dynamic> map) {
    return Servico(
      id: map['id'],
      jogadorId: map['jogadorId'],
      tipo: map['tipo'],
      status: map['status'],
      data: map['data'],
    );
  }

  // Converte DateTime para String
  static String dateTimeToString(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  // Converte String para DateTime
  static DateTime stringToDateTime(String dateString) {
    return DateTime.parse(dateString);
  }
}
