import SwiftUI

struct CadastroView: View {
    @State private var nome: String = ""
    @State private var email: String = ""
    @State private var telefone: String = ""
    @State private var endereco: String = ""
    
    private let usuarioService = UsuarioService()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nome", text: $nome)
                TextField("Email", text: $email)
                TextField("Telefone", text: $telefone)
                TextField("Endereço", text: $endereco)
                
                Button(action: salvarUsuario) {
                    Text("Salvar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(nome.isEmpty || email.isEmpty || telefone.isEmpty || endereco.isEmpty)
            }
            .navigationTitle("Cadastrar Usuário")
        }
    }
    
    private func salvarUsuario() {
        let usuario = Usuario(nome: nome, telefone: telefone, email: email, endereco: endereco)
        usuarioService.adicionarUsuario(usuario) { error in
            if let error = error {
                print("Erro ao salvar: \(error.localizedDescription)")
            } else {
                print("Usuário salvo com sucesso!")
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
