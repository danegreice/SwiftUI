import SwiftUI

struct ListaUsuariosView: View {
    @State private var usuarios: [Usuario] = []
    private let usuarioService = UsuarioService()
    
    var body: some View {
        NavigationView {
            List(usuarios) { usuario in
                VStack(alignment: .leading) {
                    Text(usuario.nome)
                        .font(.headline)
                    Text(usuario.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Telefone: \(usuario.telefone)")
                        .font(.subheadline)
                    Text("Endereço: \(usuario.endereco)")
                        .font(.subheadline)
                }
            }
            .onAppear(perform: carregarUsuarios)
            .navigationTitle("Usuários Cadastrados")
        }
    }
    
    private func carregarUsuarios() {
        usuarioService.buscarUsuarios { result in
            switch result {
            case .success(let usuarios):
                self.usuarios = usuarios
            case .failure(let error):
                print("Erro ao buscar usuários: \(error.localizedDescription)")
            }
        }
    }
}
