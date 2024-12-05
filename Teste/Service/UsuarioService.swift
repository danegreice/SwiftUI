import Foundation
import FirebaseFirestore

class UsuarioService {
    private let collection = Firestore.firestore().collection("usuarios")
    
    func adicionarUsuario(_ usuario: Usuario, completion: @escaping (Error?) -> Void) {
        do {
            try collection.addDocument(from: usuario, completion: { error in
                completion(error)
            })
        } catch {
            completion(error)
        }
    }
    
    func buscarUsuarios(completion: @escaping (Result<[Usuario], Error>) -> Void) {
        collection.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            do {
                let usuarios = try documents.compactMap { try $0.data(as: Usuario.self) }
                completion(.success(usuarios))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
