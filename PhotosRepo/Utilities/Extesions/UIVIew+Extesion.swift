//
//  View+Extension.swift
//  PhotosRepo
//
//  Created by Smart Zone on 5/12/22.
//

import Foundation
import UIKit

extension UITableView{
    func registerCell<T: UITableViewCell>(type: T.Type, bundle: Bundle? = nil){
        let className = String(describing: type.self)
        let nib = UINib(nibName: className, bundle: nil)
        self.register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with cellType: T.Type ,for indexPath: IndexPath)-> UITableViewCell{
        let className = String(describing: cellType.self)
        return self.dequeueReusableCell(withIdentifier: className, for: indexPath) as! T
    }
}
