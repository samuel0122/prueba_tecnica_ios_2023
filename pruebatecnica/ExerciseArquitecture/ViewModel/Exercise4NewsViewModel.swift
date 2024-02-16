//
//  Exercise4NewsViewModel.swift
//  pruebatecnica
//
//  Created by Samuel Oliva Bulpitt on 16/2/24.
//

import Foundation
import Combine

enum Exercise4ObtainNewsResult {
    case newsFailed
    case newsEmpty
    case newsValid(news: [New])
}

class Exercise4NewsViewModel {
    
    // MARK: - News Publisher
    
    @Published var newsData: Exercise4ObtainNewsResult = .newsEmpty
    
    // MARK: - News Data Model
    
    private let exercise4NewsModel: Exercise4NewsModel = Exercise4NewsModel()
    
    // MARK: - Load function
    
    func loadNews(from section: String) {
        // La logica para obtener los datos para la vista
        exercise4NewsModel.getNews(from: section) { obtainedNews in
            switch obtainedNews {
            case .failedResult:
                self.newsData = Exercise4ObtainNewsResult.newsFailed
            case .news(let news):
                if news.isEmpty {
                    self.newsData = Exercise4ObtainNewsResult.newsEmpty
                } else {
                    self.newsData = Exercise4ObtainNewsResult.newsValid(news: news)
                }
            }
        }
    }
}
