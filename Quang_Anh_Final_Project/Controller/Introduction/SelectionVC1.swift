import UIKit

class SelectionVC1: BaseSelectionVC {
    override func viewDidLoad() {
        pageTitle = "Which heart health issue\nconcerns you the most?"
        options = [
            CardOption(title: "Hearth Rate", imageName: "ic_f1_sl1"),
            CardOption(title: "High Blood Pressure", imageName: "ic_f1_sl2"),
            CardOption(title: "Stress & Anxiety", imageName: "ic_f1_sl3"),
            CardOption(title: "Low Energy Levels", imageName: "ic_f1_sl4")
        ]
        onContinue = { selected in
            let nextVC = SelectionVC2()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        super.viewDidLoad()
    }
}
