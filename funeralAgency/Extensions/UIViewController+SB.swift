//
//  UIViewController+SB.swift
//  funeralAgency
//
//  Created by user on 20/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    class var storyboardID: String {
        return "\(self)"
    }
    
    class var instance: UIStoryboard? {
        let storyboard = UIStoryboard(
            name: String(describing: self),
            bundle: Bundle(for: self.self)
        )
        return storyboard
    }

    class func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T  {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return (instance?.instantiateViewController(withIdentifier: storyboardID) as? T)!
    }

    class func initialViewController<T: UIViewController>() -> T? {
        guard let vc = instance?.instantiateInitialViewController() as? T else {
            print("Could not navigate to the \(T.Type.self), make sure that it is initial controller in \(String(describing: self)).storyboard!")
            return nil
        }
        return vc
    }
    
}
