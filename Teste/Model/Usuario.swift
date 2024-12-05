import Foundation
import FirebaseFirestore

struct Usuario: Identifiable, Codable {
    @DocumentID var id: String?
    var nome: String
    var telefone: String
    var email: String
    var endereco: String
}
