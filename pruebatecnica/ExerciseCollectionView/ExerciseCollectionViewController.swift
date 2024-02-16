
import UIKit
import Combine

private let exerciseCollectionViewCellId = "ExerciseCollectionViewCell"

class ExerciseCollectionViewController: ExerciseBaseViewController {
    
    // MARK: - Collection View display properties
    
    private let collectionViewHorizontalInset: CGFloat = 16.0
    private let collectionViewVerticalInset: CGFloat   = 8.0
    
    private let collectionCellHorizontalSpacing: CGFloat = 16.0
    private let collectionCellVerticalSpacing: CGFloat   = 8.0
    
    private var collectionViewInsetHorizontalSpace: CGFloat {
        collectionView.bounds.width - (collectionViewHorizontalInset * 2)
    }
    
    private var collectionViewNumberColumns: CGFloat = 1.0
    
    private let cellHeight: CGFloat = 128.0
    private var cellWidth: CGFloat {
        (collectionViewInsetHorizontalSpace / collectionViewNumberColumns) - (collectionCellHorizontalSpacing * (collectionViewNumberColumns - 1))
    }

    
    // MARK: - Class Properties
    
    private let viewModel = ExerciseCollectionViewModel()
    private var disposables: Set<AnyCancellable> = Set()
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var execiseContents: [ExerciseCollectionViewModel.Content] = []
    
    // MARK: - System functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // todo: Add all configuration you want
        configureCollectionView()
        baseConfigureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver (
            self,
            selector: #selector(self.orientationChangeCallback),
            name: UIDevice.orientationDidChangeNotification,
            object: nil )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadContents()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(
            self,
            name: UIDevice.orientationDidChangeNotification,
            object: nil)
    }
    
    // MARK: - Private functions
    
    private func configureCollectionView() {
        let cellNib = UINib(nibName: exerciseCollectionViewCellId, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: exerciseCollectionViewCellId)

        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func draw(_ contents: [ExerciseCollectionViewModel.Content]) {
        // Setea el contenido
        execiseContents = contents
    }
    
    // MARK: - Orientation Change Callback
    
    @objc private func orientationChangeCallback() {
        collectionView.reloadData()
    }
}


// MARK: Exercise configuration (not touch it)
extension ExerciseCollectionViewController {
    
    static func create() -> UIViewController {
        ExerciseCollectionViewController(nibName: "ExerciseCollectionViewController", bundle: .main)
    }
    
    private func loadContents() {
        viewModel.load().sink { _ in
            // do nothing
        } receiveValue: { [weak self] contents in
            self?.draw(contents)
        }
        .store(in: &disposables)
    }
    
    private func baseConfigureView() {
        title = "Ej1: CollectionView"
    }
}

// MARK: - Collection View extensions

extension ExerciseCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection View configuration
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return execiseContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (
            top:    collectionViewVerticalInset,
            left:   collectionViewHorizontalInset,
            bottom: collectionViewVerticalInset,
            right:  collectionViewHorizontalInset
        )
    }
    
    // MARK: - Collection Cell configuration
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if traitCollection.horizontalSizeClass == .compact {
            collectionViewNumberColumns = 1
        } else {
            collectionViewNumberColumns = 2
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseCollectionViewCellId, for: indexPath) as? ExerciseCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // Configuro la celda
        cell.configure(with: execiseContents[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionCellVerticalSpacing    // Espacio vertical
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionCellHorizontalSpacing   // Espacio horizontal entre celdas
    }
    

}
