//
//  TabBar.swift
//  Quang_Anh_Final_Project
//
//  Created by iKame Elite Fresher 2025 on 8/3/25.


import UIKit

class TabBar: UITabBarController {

    private var shapeLayer: CAShapeLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        addSomeTabItems()

        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTabBar() // Đặt ở đây để đảm bảo frame đúng
    }

    func setupTabBar() {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundColor = .clear
        tabBar.isTranslucent = true
        
        let frameWidth = UIScreen.main.bounds.width
        shapeLayer?.removeFromSuperlayer()

        let path = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 0
        shape.strokeColor = UIColor.background1.cgColor
        shape.fillColor = UIColor.white.cgColor
        shape.name = "customTabShape"

        tabBar.layer.insertSublayer(shape, at: 0)
        self.shapeLayer = shape

        tabBar.itemWidth = 60
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = frameWidth - (64 * CGFloat(tabBar.items!.count)) / 2

        tabBar.tintColor = UIColor(named: "primary1") ?? .neutral4
        tabBar.unselectedItemTintColor = UIColor(named: "neutral4")
    }

    func addSomeTabItems() {
        let vc1 = UINavigationController(rootViewController: Report())
        let vc2 = UINavigationController(rootViewController: Settings())
        vc1.title = "Report"
        vc2.title = "Settings"
        setViewControllers([vc1, vc2], animated: false)

        guard let items = tabBar.items else { return }
        items[0].image = UIImage(named: "ic_report") ?? UIImage(systemName: "ic_report")
        items[1].image = UIImage(named: "ic_settings") ?? UIImage(systemName: "ic_settings")
    }

    func getPathForTabBar() -> UIBezierPath {
        let frameWidth = tabBar.bounds.width
        let frameHeight: CGFloat = 80
        let cornerRadius: CGFloat = 14

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: frameHeight))
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight))
        path.addLine(to: CGPoint(x: frameWidth, y: cornerRadius))
        path.addArc(withCenter: CGPoint(x: frameWidth - cornerRadius, y: cornerRadius), radius: CGFloat(cornerRadius), startAngle: .zero, endAngle: .pi * 3/2, clockwise: false)
//        path.addQuadCurve(to: CGPoint(x: frameWidth - cornerRadius, y: 0),
//                          controlPoint: CGPoint(x: frameWidth, y: 0))
        path.addLine(to: CGPoint(x: cornerRadius, y: 0))
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: cornerRadius), radius: CGFloat(cornerRadius), startAngle: .pi * 3/2, endAngle: .pi, clockwise: false)
//        path.addQuadCurve(to: CGPoint(x: 0, y: cornerRadius),
//                          controlPoint: CGPoint(x: 0, y: 0))
        path.close()
        return path
    }
}
