import '../models/usuario.dart';

class AuthService {
  static Usuario usuarioValido = Usuario(id: 'cliente1', senha: 'senha123');

  bool login(String id, String senha) {
    return id == usuarioValido.id && senha == usuarioValido.senha;
  }
}
