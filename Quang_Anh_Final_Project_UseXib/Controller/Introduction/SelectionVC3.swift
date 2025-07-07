import UIKit

class SelectionVC3: BaseSelectionVC {
    override func viewDidLoad() {
        pageTitle = "What type of plan would you like to follow?"
        options = [
            CardOption(title: "Educational Plan", imageName: "ic_f3_sl1"),
            CardOption(title: "Exercise Plan", imageName: "ic_f3_sl2"),
            CardOption(title: "Health Tests", imageName: "ic_f3_sl3")
        ]
        onContinue = { selectedIndices in
            // ✅ Đánh dấu đã xem Intro
            UserDefaults.standard.set(true, forKey: "hasSeenIntro")

            // ✅ Chuyển đến TabBar
            let mainTabBarVC = MainTabBarVC()

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = mainTabBarVC
                window.makeKeyAndVisible()

                UIView.transition(with: window,
                                  duration: 0.3,
                                  options: [.transitionCrossDissolve],
                                  animations: nil)
            }
        }
        super.viewDidLoad()
    }
}
