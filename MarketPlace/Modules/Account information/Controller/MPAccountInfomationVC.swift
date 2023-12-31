//
//  MPAccountInfomationVC.swift
//  MarketPlace
//
//  Created by 世文 on 2023/7/21.
//

import UIKit

class MPAccountInfomationVC: BaseHiddenNaviController {

    let mainView = MPAccountMainView.fromNib()
    let menuToolView = MPHomeToolsView.fromNib()
    
    let publicVM = MPPublicViewModel()
    
    var type = "" {
        didSet{
            requestData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Account infomation".localString()
        self.topViewLeftBtn.setImage(UIImage(named: "ic_back_family_Normal"), for: .normal)
        //添加底部背景图
        let homeBgImage = UIImageView(frame: .zero)
        homeBgImage.image = UIImage(named: "homebg_1_Normal")
        homeBgImage.contentMode = .scaleAspectFill
        self.view.addSubview(homeBgImage)
        homeBgImage.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(48 + STATUSBAR_HIGH)
        }
        
        mainView.backgroundColor = UIColor(17, 34, 42, 0).withAlphaComponent(0.8)
        
        self.view.addSubview(mainView)
      
        
        
        //添加底部菜单
        menuToolView.accountData = [["text":"Generate QR nickname".localString(),"img":"create_qr_ic_Normal"],
                                    ["text":"Open savings account".localString(),"img":"home_opensaving_ic_Normal"],
                                    ["text":"Transfer".localString(),"img":"shot_transfer_selected_Normal"],
                                    ["text":"Top up".localString(),"img":"ntdt_Normal"],
                                    ["text":"Bill payment".localString(),"img":"shot_bill_selected_Normal"]]
        menuToolView.backgroundColor = UIColor(17, 34, 42, 0).withAlphaComponent(0.8)
        menuToolView.isInfomationVC = true
        menuToolView.collecView.reloadData()
        menuToolView.selctItemBlock = { index in
            if index == 2 {
                //转账
                print("跳转转账")
                let transferAlert = MPTransferListAlert.init(nibName: "MPTransferListAlert", bundle: nil)
                transferAlert.pan_show()
                transferAlert.didSelectItemBlock = { index in
                    if index == 1 {
                        let quickTransferVC = MPQuickTransferController()
                        self.pushViewController(vc: quickTransferVC)
                    }
                   
                }
                
            }
        }
        view.addSubview(menuToolView)
        
        mainView.searchMoreBlock = {[weak self] in
            guard let self = self else{return}
//            let vc = MPTransactionHistoryController()
            let vc = MPTransactionHistoryController.init(nibName: "MPTransactionHistoryController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        mainView.segmentClickBlock = {[weak self] idx in
            guard let self = self else{return}
            self.type = "\(idx)"
        }
        
        
        
        menuToolView.snp.makeConstraints { make in
            make.bottom.equalTo(SafeAreaBottom-20)
            make.left.right.equalTo(mainView)
            make.height.equalTo(itemWidth+30)
            
        }
        
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(homeBgImage)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(menuToolView.snp.top)
        }
        
        
        type = "0"//全部
        
    }
    
    func requestData() {
        HudManager.show()
        publicVM.requestTransferRecord(token: "", type: type, startTime: "", endTime: "").subscribe(onNext: {[weak self] _ in
            guard let self = self else {return}
            self.mainView.recordeModel = self.publicVM.recordeModel
        }).disposed(by: disposeBag)
    }

}
