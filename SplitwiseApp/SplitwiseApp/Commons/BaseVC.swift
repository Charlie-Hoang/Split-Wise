//
//  BaseVC.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/14/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseVC: UIViewController{
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
// MARK: SETUP NavigationBar
extension BaseVC{
    @objc func back() {
        self.navigationController?.popViewController(animated: true);
    }
    @objc func save() {
        
    }
    @objc func diary() {
        
    }
    @objc func balance() {
        
    }
    func showBackButton() {
        self.navigationItem.leftBarButtonItem = createBarButton(title: "Cancel", image: nil, selector: #selector(back))
    }
    func showSaveButton(){
        self.navigationItem.rightBarButtonItem = createBarButton(title: "Save", image: nil, selector: #selector(save))
    }
    func showDiaryButton(){
        self.navigationItem.rightBarButtonItem = createBarButton(title: "Diary", image: nil, selector: #selector(diary))
    }
    func showBalanceButton(){
        self.navigationItem.rightBarButtonItem = createBarButton(title: "Balance", image: nil, selector: #selector(balance))
    }
    func createBarButton(title: String?, image: UIImage?, selector: Selector) -> UIBarButtonItem{
        let _button = UIButton(type: .custom)
        _button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        _button.setBackgroundImage(image, for: .normal)
        _button.setTitle(title, for: .normal)
        _button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        _button.setTitleColor(UIColor.white, for: .normal)
        _button.addTarget(self, action: selector, for: .touchUpInside)
        return UIBarButtonItem(customView: _button)
    }
}
