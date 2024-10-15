class Pedido {
  final String id;
  final String clienteId; // Mantendo o nome consistente
  final String status;
  final String data;

  Pedido({
    required this.id,
    required this.clienteId,
    required this.status,
    required this.data, required String descricao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clienteId, // Certifique-se de que 'clientId' é o que você realmente quer
      'status': status,
      'data': data,
    };
  }

  static Pedido fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id'],
      clienteId: map['clientId'], // Certifique-se de que 'clientId' é o que você realmente quer
      status: map['status'],
      data: map['data'], descricao: '',
    );
  }

  static String dateTimeToString(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  static DateTime stringToDateTime(String dateString) {
    return DateTime.parse(dateString);
  }
}
