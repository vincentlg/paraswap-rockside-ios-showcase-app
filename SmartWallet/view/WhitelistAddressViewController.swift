//
//  WhitelistAddressViewController.swift
//  SmartWallet
//
//  Created by Frederic DE MATOS on 08/04/2020.
//  Copyright © 2020 Frederic DE MATOS. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialSnackbar
import JGProgressHUD
import RocksideWalletSdk

class WhitelistAddressViewController:UIViewController {
    
    @IBOutlet weak var addressTextField: MDCTextField!
    var addressTextFieldController: MDCTextInputControllerUnderline?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addressTextFieldController = MDCTextInputControllerUnderline(textInput: addressTextField)
        self.addressTextField.becomeFirstResponder()
    }
    
    @IBAction func addAction(_ sender: Any) {
        self.addressTextFieldController?.setErrorText(nil, errorAccessibilityValue: nil)
        
        if  !EthereumAddress.isValid(string: addressTextField.text!) {
            self.addressTextFieldController?.setErrorText("Invalid address", errorAccessibilityValue: "Invalid addresss")
            return
        }
        
        
        let hud = JGProgressHUD(style: .extraLight)
        hud.textLabel.text = "Your address is being added.\nPlease wait (around 1 min)"
        hud.show(in: self.view)
        
        self.rockside.identity!.updateWhiteList(eoa: addressTextField.text!, value: true) { (result) in
            switch result {
            case .success(let txHash):
                DispatchQueue.main.async {
                    _ = self.rockside.rpc.waitTxToBeMined(txHash: txHash) { (result) in
                        switch result {
                        case .success(_):
                            DispatchQueue.main.async {
                                hud.dismiss()
                                self.dismiss(animated: true, completion: nil)
                            }
                            break
                            
                        case .failure(let error):
                            print(error)
                            DispatchQueue.main.async {
                                hud.dismiss()
                                self.displayErrorOccured()
                            }
                            break
                        }
                    }
                }
                break
                
            case .failure(let error):
                print(error)
                hud.dismiss()
                self.displayErrorOccured()
                break
            }
        }
    }
    
    
    public func displayErrorOccured() {
        let snackBarMessage = MDCSnackbarMessage()
        snackBarMessage.text = "An error occured. Please try again."
        MDCSnackbarManager.show(snackBarMessage)
    }
    
    func qrCodeFound(qrcode: String) {
        self.addressTextField.text = qrcode
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_scanner_segue" {
            if let destinationVC = segue.destination as? ScannerViewController {
                destinationVC.qrCodeHandler = self.qrCodeFound
            }
        }
    }
    
}