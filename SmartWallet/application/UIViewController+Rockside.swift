//
//  UIViewController+Rockside.swift
//  SmartWallet
//
//  Created by Frederic DE MATOS on 06/03/2020.
//  Copyright © 2020 Frederic DE MATOS. All rights reserved.
//

import UIKit
import RocksideWalletSdk

extension UIViewController {
    
    var navigationController: WalletNavigationViewController? {
        return UIApplication.shared.keyWindow?.rootViewController as? WalletNavigationViewController 
    }
}
