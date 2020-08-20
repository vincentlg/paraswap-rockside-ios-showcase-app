//
//  RecoveryViewController.swift
//  SmartWallet
//
//  Created by Frederic DE MATOS on 06/03/2020.
//  Copyright © 2020 Frederic DE MATOS. All rights reserved.
//

import UIKit
import MessageUI
import MaterialComponents.MaterialSnackbar

class RecoveryViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var walletAddressLabel: UILabel!
    @IBOutlet weak var mnemonicLabel: UILabel!
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CopyAddressAction(_ sender: Any) {
        UIPasteboard.general.string = ApplicationContext.smartwallet!.ethereumAddress+"\n"+ApplicationContext.account!.mnemonic
        let snackBarMessage = MDCSnackbarMessage()
        snackBarMessage.text = "Address and recovery phrase copied to clipboard."
        snackBarMessage.duration = 1
        MDCSnackbarManager.show(snackBarMessage)
    }
    
    override func viewDidLoad() {
        self.walletAddressLabel.text = ApplicationContext.smartwallet!.ethereumAddress
        self.mnemonicLabel.text = ApplicationContext.account!.mnemonic
    }
    
    
}
