
import UIKit
import SwiftUI

class ExerciseDispatchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Navigator.default.lastPresented = self
    }

    @IBAction private func onCollectionViewExercise(button: UIButton) {
        Navigator.default.openFlow {
            ExerciseCollectionViewController.create()
        }
    }
    
    @IBAction private func onDataServicesExercise(button: UIButton) {
        Navigator.default.openFlow {
            ExerciseDataServicesViewController.create()
        }
    }
    
    @IBAction private func onTestingExercise(button: UIButton) {
        
    }
    @IBAction func onSwiftUIExercise(_ sender: Any) {
        let swiftUIView = ExerciseSwiftUI()
        let hostingController = UIHostingController(rootView: swiftUIView)
        navigationController?.pushViewController(hostingController, animated: true)

    }
}

