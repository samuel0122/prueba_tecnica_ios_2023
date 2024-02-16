//
//  ExerciseDataServicesModel.swift
//  pruebatecnica
//
//  Created by Samuel Oliva Bulpitt on 16/2/24.
//

import Foundation

class ExerciseDataServicesModel {
    
    // MARK: - Model notifications
    
    let NOTIF_DATA_RECIVED = "NOTIF_DATA_RECIVED"
    let NOTIF_DATA_HOLDER = "NOTIF_DATA_HOLDER"
    
    // MARK: - Properties
    
    private let exerciseServicesStringURL = "https://hello-world.innocv.com/api/User"
    
    // MARK: - Function simple URLSession load data
    
    func loadUsersURLSession(_ callback: @escaping ([InnocvUser]) -> Void) {
        // Esta función simplemente ejecuta la función notify cuando recibe los datos
        runFetchDataURLSession { datosUsuariosCargados in
            callback(datosUsuariosCargados)
        }
    }
    
    // MARK: - Function URLSession with Notifications
    
    func loadUsersURLNotificationCenter() {
        // Esta función comunica la recepción de datos mediante notificaciones
        // Añade a un observador al evento NOTIF_DATA_RECIVED

        runFetchDataURLSession { datosUsuariosCargados in
            NotificationCenter.default.post (
                name: Notification.Name(self.NOTIF_DATA_RECIVED),
                object: nil,
                userInfo: [self.NOTIF_DATA_HOLDER: datosUsuariosCargados])
        }
    }
    
    // MARK: - Function fetch data
    
    private func runFetchDataURLSession (callback: @escaping ([InnocvUser]) -> Void) {
        guard let url = URL(string: exerciseServicesStringURL) else {
            // PROBLEMA AL CREAR URL
            return
        }
        
        URLSession.shared.dataTask(with: url) { recivedData, recivedResponse, recivedError in
            var loadedUserData: [InnocvUser] = []
            Thread.sleep(forTimeInterval: 1) // Para probar que no se congela el UI
            
            do {
                guard let data = recivedData else {
                    // DATOS NIL
                    throw DataServicesError.NilData
                }
                
                // Decodifica los datos
                let safeUserData: [Safe<InnocvUser>] = try JSONDecoder().decode([Safe<InnocvUser>].self, from: data)
                // Obtén los datos filtrando los inválidos
                loadedUserData = ExerciseDataServicesMapper.mapSafeUsers(data: safeUserData)
            } catch DataServicesError.NilData {
                // RECIVIDO NIL
                print("ERROR: Recived nil data.")
            } catch {
                // ERROR AL DECODIFICAR
                print("ERROR: Recived invalid data")
            }
            
            OperationQueue.main.addOperation {
                callback(loadedUserData)
            }
        }.resume()
    }
}
