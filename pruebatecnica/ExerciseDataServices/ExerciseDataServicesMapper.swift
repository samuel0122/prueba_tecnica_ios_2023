//
//  ExerciseDataServicesMapper.swift
//  pruebatecnica
//
//  Created by Samuel Oliva Bulpitt on 15/2/24.
//

class ExerciseDataServicesMapper {
    static func mapSafeUsers(data: [Safe<InnocvUser>]) -> [InnocvUser] {
        return data.filter { $0.value != nil }.map { $0.value! }
    }
    
    static func mapUsersNames(data: [InnocvUser]) -> [String] {
        return data.map { $0.name }
    }
}
