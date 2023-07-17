//
//  BaseTabBarController.swift
//  MarketPlace
//
//  Created by tanktank on 2022/5/30.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    
    let tabbarNormalArray = ["bar_home_dark","bar_market_dark","bar_treaty_dark","bar_otc_dark","bar_property_dark"]
    let tabbarSeletedArray = ["bar_home_light","bar_market_light","bar_treaty_light","bar_otc_light","bar_property_light"]

    let titles = ["首页","行情","合约","C2C","资产"]
        
    let homeVC = CCHomeViewController()
    let contractVC = MPContractMainController()
    let otcVC = MPQuickController()
    let walletsVC = MPWalletController()
    let marketVC = CCMaketQuotationController()
    lazy var baseHomeNav = BaseNavigationController.init(rootViewController: homeVC)
    lazy var baseContractNav = BaseNavigationController.init(rootViewController: contractVC)
    lazy var baseOTCNav = BaseNavigationController.init(rootViewController: otcVC)
    lazy var baseWalletsNav = BaseNavigationController.init(rootViewController: walletsVC)
    lazy var baseMarketNav = BaseNavigationController.init(rootViewController: marketVC)

    var selectButton = UIButton()
    lazy var tmpViewControllers = [baseHomeNav,baseMarketNav,baseContractNav,baseOTCNav,baseWalletsNav]
    override func viewDidLoad() {
        super.viewDidLoad()
//        initControllers()
        self.delegate = self
        
        self.tabBar.backgroundImage = UIImage(named: "bottom-bar-bg")
        
        self.loadTabbar(vcs: tmpViewControllers)

        self.configyrationLatestVersion()
        NotificationCenter.default.addObserver(self, selector: #selector(goToHomePage), name: loginSuccessNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToQuickBuy), name: C2CQuickBuyNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToContract), name: PushToContractNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToMarket), name: PushToMarketNotification, object: nil)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: LocalLanguageChangeNotification.rawValue), object: nil,  queue: nil) { (notification) in
                        
            for index in 0..<self.tmpViewControllers.count {
                let nav = self.tmpViewControllers[index]
                if let vc = nav.viewControllers.last {
                    vc.tabBarItem.title = self.titles[index].localString()
                }
            }
            self.tabBar.selectedItem?.title = "首页".localString()//LanguageManager.localValue("首页")
                        
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configyrationLatestVersion()
//        UITabBar.appearance().backgroundImage = UIImage(named: "bottom-bar-bg") //UIImage.getImageWithColor(color: .white) // UIImage(named: "fifa_tabbar")
    }
    
    @objc func goToHomePage(){
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
        if Archive.getIsBackToHome() {
            self.selectedIndex = 0
        }
        Archive.saveIsBackToHome(true)
    }
    
    @objc func goToQuickBuy(){
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.selectedIndex = 3
//        }
    }
    @objc func goToContract(){
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.selectedIndex = 2
//        }
    }
    @objc func goToMarket(){
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.selectedIndex = 1
//        }
    }

    func loadTabbar(vcs : [BaseNavigationController]){
        for index in 0..<vcs.count {
            let nav = vcs[index]
            if let vc = nav.viewControllers.last {
                vc.hidesBottomBarWhenPushed = false
                vc.tabBarItem.image = UIImage.init(named:self.tabbarNormalArray[index])?.withRenderingMode(.alwaysOriginal)
                vc.tabBarItem.selectedImage = UIImage.init(named:self.tabbarSeletedArray[index])?.withRenderingMode(.alwaysOriginal)
                vc.tabBarItem.title = LanguageManager.localValue(self.titles[index]) //self.titles[index]
                vc.tabBarItem.tag = index
            }
        }
        self.setViewControllers(vcs, animated: true)
    }
    
    
    @objc func onClick(button: UIButton) {
        // 将上个选中按钮设置为未选中
        self.selectButton.isSelected = false
        // 当前按钮设置为选中
        button.isSelected = true
        // 记录选中按钮
        self.selectButton = button
        
        // 通过UITabBarController的selectedIndex属性设置选中了哪个UIViewController
        self.selectedIndex = button.tag
        self.hidesBottomBarWhenPushed = false
    }
    
    func initControllers() {
        
//        self.tabBar.isTranslucent = true // tabbar不透明
        // 直接用颜色
//        self.tabBar.barTintColor = .init(white: 1, alpha: 1)
//        UITabBar.appearance().backgroundColor = .red //.init(white: 1, alpha: 1)
////        UITabBar.appearance().backgroundImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage(named: "fifa_tabbar")
        
//        let tmpViewControllers = [baseHomeNav,baseMarketsNav,baseTradeNav,baseFuturesNav,baseWalletsNav]
        //选中和非选中字体颜色
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.hexColor("2B2B33")], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:kMainColor], for: .selected)
        //MARK: fifa
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hexColor("FFC619") ], for: .selected)
        
    }

}
//extension BaseTabBarController {
//    override func qmui_themeDidChange(by manager: QMUIThemeManager, identifier: NSCopying & NSObjectProtocol, theme: NSObject) {
//        super.qmui_themeDidChange(by: manager, identifier: identifier, theme: theme)
//
//        guard let items = self.tabBar.items else {
//            return
//        }
//
//        for i in 0..<items.count {
////            UITabBarItem *item = items[i];
//            let item = items[i]
//            item.image = UIImage.init(named:self.tabbarNormalArray[i])?.withRenderingMode(.alwaysOriginal)
//            item.selectedImage = UIImage.init(named:self.tabbarSeletedArray[i])?.withRenderingMode(.alwaysOriginal)
//            item.title = self.titles[i]
//        }
//    }
//}


// MARK: - 版本适配
extension BaseTabBarController {
    /// 版本适配
    func configyrationLatestVersion() {
        if #available(iOS 13.0, *) {
            self.tabBar.tintColor = UIColor.hexColor("5171FF")
            self.tabBar.unselectedItemTintColor = UIColor.hexColor("999999")
            //MARK: fifa
//            self.tabBar.tintColor = .hexColor("FFC619")
//            self.tabBar.unselectedItemTintColor = .white

//            self.tabBar.tintColor = kMainColor // .hexColor("FFC619")
//            self.tabBar.unselectedItemTintColor =
//            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
//            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hexColor("FFC619") ], for: .selected)

//            self.tabBar.backgroundColor =   .red //.init(white: 1, alpha: 0.9)//根据自己的情况设置
            
//            if let image = UIImage(named: "fifa_tabbar") {
//
//                let color = UIColor(patternImage: image)
            UITabBar.appearance().backgroundColor = .white
            
//            let line = UIView()
//            line.backgroundColor = kLineColor
//            self.tabBar.addSubview(line)
//            line.snp.makeConstraints { make in
//
//                make.left.right.top.equalToSuperview()
//                make.height.equalTo(2)
//            }
            
            
            self.tabBar.layer.shadowColor = UIColor.hexColor("DBDDFD").cgColor
            self.tabBar.layer.shadowOffset = CGSizeMake(0,-3)
            self.tabBar.layer.shadowOpacity = 0.5
            self.tabBar.layer.shadowRadius = 3
//            }
            
            UITabBar.appearance().backgroundImage = UIImage(named: "become_trader")

//            let imaview = UIImageView(image: UIImage(named: "fifa_tabbar"))
//            UITabBar.appearance().qmui_backgroundView = imaview
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension BaseTabBarController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if !userManager.isLogin &&
//            (self.viewControllers?.firstIndex(of: viewController) ?? 0) > 3  {
//            if let vc = self.selectedViewController {
//                userManager.logoutWithVC(currentVC: vc)
//            }
//            return false
//        }
        return true
    }
    
}

extension BaseTabBarController {
    func setTabBarVisible(visible:Bool, duration: TimeInterval, animated:Bool) {
        if (tabBarIsVisible() == visible) { return }
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)

        // animation
        UIViewPropertyAnimator(duration: duration, curve: .linear) {
            self.tabBar.frame.offsetBy(dx:0, dy:offsetY)
            self.view.frame = CGRect(x:0,y:0,width: self.view.frame.width, height: self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }.startAnimation()
    }

    func tabBarIsVisible() ->Bool {
        return self.tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
}
