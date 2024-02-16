
import Foundation
import Combine

struct InnocvUser: Codable, Identifiable {
    let id: Int
    let name: String
}

enum DataServicesError: Error {
    case InvalidURL
    case InvalidData
    case NilData
}

class ExerciseDataServicesViewModel {
    
    // MARK: - Properties
    
    var users: AnyPublisher<[InnocvUser], Never> {
        _users.eraseToAnyPublisher()
    }
    private var _users: PassthroughSubject<[InnocvUser], Never> = PassthroughSubject()

    private let exerciseDataServicesModel: ExerciseDataServicesModel = ExerciseDataServicesModel()
    
    // MARK: - Load function
    
    func load() {
        // loadDataURLSession()
        loadDataURLNotificationCenter()
    }
    
    // MARK: - Function simple URLSession load data
    
    private func loadDataURLSession() {
        // Esta función simplemente ejecuta la función notify cuando recibe los datos
        exerciseDataServicesModel.loadUsersURLSession { users in
            self.notify(users: users)
        }
    }
    
    // MARK: - Function URLSession with Notifications
    
    private func loadDataURLNotificationCenter() {
        // Esta función comunica la recepción de datos mediante notificaciones
        // Añade a un observador al evento NOTIF_DATA_RECIVED
        NotificationCenter.default.addObserver (
            self,
            selector: #selector(self.loadDataURLNotificationCenterResponse(notification:)),
            name: Notification.Name(exerciseDataServicesModel.NOTIF_DATA_RECIVED),
            object: nil )
        
        exerciseDataServicesModel.loadUsersURLNotificationCenter()
    }
    
    @objc private func loadDataURLNotificationCenterResponse(notification: Notification) {
        if let users = notification.userInfo?[exerciseDataServicesModel.NOTIF_DATA_HOLDER] as? [InnocvUser] {
            notify(users: users)
        }
    }
    
    // MARK: - Function notify
    
    private func notify(users: [InnocvUser]) {
        _users.send(users)
    }
}
