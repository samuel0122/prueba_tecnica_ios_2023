//
//  Exercise4NewsModel.swift
//  pruebatecnica
//
//  Created by Samuel Oliva Bulpitt on 16/2/24.
//

import Foundation

enum Exercise4NewsModelResult {
    case failedResult
    case news(news: [New])
}

class Exercise4NewsModel {
    
    // MARK: - Get news by section
    
    func getNews(from section: String, callback: @escaping (Exercise4NewsModelResult)-> Void) {
        var obtainedNews: [New] = []
        
        do {
            // ...
            // Toda la logica para obtener los datos del modelo
            // ...
            callback(Exercise4NewsModelResult.news(news: obtainedNews))
        } catch {
            callback(Exercise4NewsModelResult.failedResult)
        }
    }
}
