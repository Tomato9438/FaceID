//
//  ViewController.swift
//  IDMania
//
//  Created by JimmyHarrington on 2019/11/01.
//  Copyright © 2019 JimmyHarrington. All rights reserved.
//

import UIKit
import LocalAuthentication

class HomeViewController: UIViewController {
    // MARK: - Instance variables
    
    // MARK: - IBOutlets
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    // MARK: - IBActions
    @IBAction func buttonTapped(_ sender: UIButton) {
        authenticateUser()
    }
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    // MARK: - deinit
    deinit {
        print("deinit is called by HomeViewController")
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        let biometricsPolicy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
        if (context.canEvaluatePolicy(biometricsPolicy, error: &error)) {
            if let laError = error {
                print("Error: \(laError)")
                return
            }

            var localizedReason = ""
            if #available(iOS 11.0, *) {
                if (context.biometryType == LABiometryType.faceID) {
                    localizedReason = "Unlock using Face ID"
                    print("FaceId support")
                } else if (context.biometryType == LABiometryType.touchID) {
                    localizedReason = "Unlock using Touch ID"
                    print("TouchId support")
                } else {
                    print("No Biometric support")
                }
            } else {
                // Fallback on earlier versions
            }

            context.evaluatePolicy(biometricsPolicy, localizedReason: localizedReason, reply: { (isSuccess, error) in
                DispatchQueue.main.async(execute: {
                    if let error = error {
                        print("Error: \(error)")
                    } else {
                        if isSuccess {
                            let ac = UIAlertController(title: "Authentication successful", message: "Authentication is successful", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(ac, animated: true)
                        } else {
                            let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(ac, animated: true)
                        }
                    }
                })
            })
        }
    }
}

