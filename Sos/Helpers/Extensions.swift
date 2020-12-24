//
//  Extensions.swift
//  Sos
//
//  Created by hussein awaesha on 12/23/20.
//

import Foundation
import UIKit

extension UIView{
    
    func addviews(_ views: [UIView]){
        repeat{
            for i in 0 ..< views.count {
                addSubview(views[i])
            }
        }while(views.count > 0)
    }
    
    func addConstraints(_ top: NSLayoutYAxisAnchor?,_ lead: NSLayoutXAxisAnchor?,_ bottom: NSLayoutYAxisAnchor?,_ trail: NSLayoutXAxisAnchor?,_ padding: UIEdgeInsets = .zero,_ size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let lead = lead{
            leadingAnchor.constraint(equalTo: lead, constant: padding.left).isActive = true
        }
        
        if let trail = trail{
            trailingAnchor.constraint(equalTo: trail, constant: -padding.right).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if size.width != 0{
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0{
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
