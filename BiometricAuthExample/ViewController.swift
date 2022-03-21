//
//  ViewController.swift
//  BiometricAuthExample
//
//  Created by Eclectics on 21/03/2022.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Authorize", for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    
    }
    
    @objc func didTapButton(){
        //get prompted for authorization
        let context = LAContext()
        var error: NSError? = nil
        
        //some older versions dont support bio auth features
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     error: &error){
            
            let reason = "Please authorize with touch ID!"
            //if we are able to use touchID or faceID
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason){[weak self] success, error in
                
            
                //Show other screen
                //Success
                DispatchQueue.main.async {
                    //success was true and error was nil
                    guard success, error == nil else{
                        //failed
                        let alert = UIAlertController(title: "Failed to Authenticate",
                                                      message: "Please try again",
                                                    preferredStyle: .alert)
                        
                        //adding a dismiss button to the alert
                        alert.addAction(UIAlertAction(title: "Dismiss",
                                                      style: .cancel,
                                                      handler: nil))
                        //show the alert
                        self?.present(alert, animated: true)
                        return
                    }
                    let vc = UIViewController()
                    vc.title = "Welcome"
                    vc.view.backgroundColor = .systemBlue
                    
                    self?.present(UINavigationController(rootViewController: vc),
                                  animated: true,
                                  completion: nil)
                }
                
            }
            
        }else{
            //cannot use touchID or faceID
            let alert = UIAlertController(title: "Unavailable",
                                          message: "You can't use this feature",
                                        preferredStyle: .alert)
            
            //adding a dismiss button to the alert
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .cancel,
                                          handler: nil))
            //show the alert
            present(alert, animated: true)
        }
    }


}

