//
//  YDUIViewExtension.swift
//  YDPlayer
//
//  Created by Douglas Hennrich on 28/08/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import UIKit

extension UIView {
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
}

// MARK: Layout
extension UIView {

    var safeTopAnchor: NSLayoutYAxisAnchor {
      if #available(iOS 11.0, *) {
        return self.safeAreaLayoutGuide.topAnchor
      }
      return self.topAnchor
    }

    var safeLeftAnchor: NSLayoutXAxisAnchor {
      if #available(iOS 11.0, *){
        return self.safeAreaLayoutGuide.leftAnchor
      }
      return self.leftAnchor
    }

    var safeRightAnchor: NSLayoutXAxisAnchor {
      if #available(iOS 11.0, *){
        return self.safeAreaLayoutGuide.rightAnchor
      }
      return self.rightAnchor
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
      if #available(iOS 11.0, *) {
        return self.safeAreaLayoutGuide.bottomAnchor
      }
      return self.bottomAnchor
    }
    
}
