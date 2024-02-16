//
//  Exercise4ListView.swift
//  pruebatecnica
//
//  Created by Samuel Oliva Bulpitt on 16/2/24.
//

import UIKit
import Combine

class Exercise4ListView: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var errorLabel: UILabel!
    
    // MARK: - Private properties
    
    private let exercise4NewsModelView: Exercise4NewsViewModel = Exercise4NewsViewModel()
    private var newsSubscribers: Set<AnyCancellable> = Set()
    
    private var newsSectionTitle: String = ""
    private var newsSectionCode: String = ""
    
    // MARK: - Initializers
    
    required init?(coder: NSCoder, newsSectionTitle: String, newsSectionCode: String) {
        super.init(coder: coder)
        self.newsSectionTitle = newsSectionTitle
        self.newsSectionCode = newsSectionCode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - System functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = newsSectionTitle
        configureInitialUI()
        startLoadingAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNewsSubscribers()
        exercise4NewsModelView.loadNews(from: newsSectionCode)
    }
    
    // MARK: - Private configure news subscribers
    
    private func configureNewsSubscribers() {
        newsSubscribers = [
            exercise4NewsModelView.$newsData
                .receive(on: DispatchQueue.main)
                .sink { news in
                    self.reciveNews(news)
                }
        ]
    }
    
    // MARK: - Private UI functions
    
    private func configureInitialUI() {
        errorLabel.isHidden = true
    }
    
    private func startLoadingAnimation() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    private func endLoadingAnimation() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    // MARK: - Recived news action
    
    private func reciveNews(_ newsResult: Exercise4ObtainNewsResult) {
        endLoadingAnimation()
        
        switch newsResult {
        case .newsFailed:
            displayError(error: "ERROR: Failed to get news")
        case .newsEmpty:
            displayError(error: "ERROR: No news obtained")
        case .newsValid(let news):
            displayNews(news)
        }
    }
    
    private func displayError(error message: String) {
        stackView.clean()
        
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    
    private func displayNews(_ news: [New]) {
        stackView.clean()
        errorLabel.isHidden = false
        
        Exercise4ListCellMapper()
            .mapNews(news: news)
            .forEach { stackView.addArrangedSubview($0) }
    }
}
