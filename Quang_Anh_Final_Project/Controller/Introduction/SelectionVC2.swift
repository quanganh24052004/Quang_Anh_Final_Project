import UIKit

class SelectionVC2: BaseSelectionVC {
    override func viewDidLoad() {
        pageTitle = "What would you like to achieve?"
        options = [
            CardOption(title: "Improve Heart Health", imageName: "ic_f2_sl1"),
            CardOption(title: "Improve blood pressure health", imageName: "ic_f2_sl2"),
            CardOption(title: "Reduce Stress", imageName: "ic_f2_sl3"),
            CardOption(title: "Increase Energy Levels", imageName: "ic_f2_sl4")
        ]
        onContinue = { selected in
            let nextVC = SelectionVC3()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        super.viewDidLoad()
    }
}
