//
//  Utilites.swift
//  Sos
//
//  Created by mohammad ahmad on 12/21/20.
//

import Foundation
import UIKit
public func bottomBorder(with button : UIButton){

    let lineView = UIView(frame: CGRect(x: 0, y:button.frame.size.height, width: button.frame.size.width, height: 2))
    lineView.backgroundColor=#colorLiteral(red: 0.1437328833, green: 0.2071459947, blue: 1, alpha: 1)

    button.addSubview(lineView)
}
public func removeBottomBorder(with button : UIButton){

    let lineView = UIView(frame: CGRect(x: 0, y:button.frame.size.height, width: button.frame.size.width, height: 2))
    lineView.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    button.addSubview(lineView)
}
public func buttonCornerRadius(with button : UIButton){
    button.layer.cornerRadius = 10
    button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    button.layer.shadowRadius = 1
    button.layer.shadowOffset = CGSize(width: 0, height: 0)
    button.layer.shadowOpacity = 0.4
}
public func viewsCornerRadius(with view : UIView){
    view.layer.cornerRadius = 5
    view.layer.shadowColor = #colorLiteral(red: 0.1437328833, green: 0.2071459947, blue: 1, alpha: 1)
    view.layer.shadowRadius = 1
    view.layer.shadowOffset = CGSize(width: 0, height: 0)
    view.layer.shadowOpacity = 0.3
}
public func viewCornerRadius(with view : UIView){
    view.layer.cornerRadius = 40

}
