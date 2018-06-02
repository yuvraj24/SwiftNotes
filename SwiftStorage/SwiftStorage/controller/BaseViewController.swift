//
//  BasrViewController.swift
//  swiftconcepts
//
//  Created by new on 21/05/18.
//  Copyright © 2018 yuvraj. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var progress : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40));

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround();
        // Do any additional setup after loading the view.
    }
    
    func showProgressIndicator(){
        
        container  = UIView()
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColorFromHex(rgbValue : 0xffffff, alpha: 0.7)
        
        loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue : 0x444444, alpha: 1)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        progress = UIActivityIndicatorView()
        progress.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
        progress.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        loadingView.addSubview(progress)
        container.addSubview(loadingView)
        view.addSubview(container)
        progress.startAnimating()
    }
    
    func hideProgressIndicator(){
        progress.stopAnimating()
        container.removeFromSuperview()
    }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
