//
//  LoginController.swift
//  OrderApp
//
//  Created by Elsever on 08.12.24.
//

import UIKit
import Lottie

class LoginController: UIViewController {
    @IBOutlet weak var aniFood: LottieAnimationView!
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var passwordBox: UITextField!
    @IBOutlet weak var emptyError: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
   
    var colorConfigure = ColorConfigure()
    let manager = FileManagerHelp()
    var user = [UserInfo]()    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readData()
        configureUI()
    }
    
    func configureUI() {
        let path = Bundle.main.path(forResource: "AnimationFood", ofType: "json")
        aniFood.animation = LottieAnimation.filepath(path!)
        aniFood.play()
        aniFood.loopMode = .loop
        
        colorConfigure.setGradientBackground(view)
        colorConfigure.setButton(loginButton)
        colorConfigure.selTextField(emailBox)
        colorConfigure.selTextField(passwordBox)
        colorConfigure.setLabel(label: emptyError, color: .red, size: 10)
        
        manager.readData { userInfo in
                self.user = userInfo
            }
    }
    
    func readData() {
        manager.readData { userInfo in
                self.user = userInfo
            }
    }
   
    @IBAction func login(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MainController") as! MainController
        readData()
        if let emailBox = emailBox.text,
            let passwordBox = passwordBox.text {
            let loginUser: UserInfo = .init(name: "", email: emailBox, password: passwordBox)
            
            if user.contains(where: { $0.email == loginUser.email
                && $0.password == loginUser.password }) {
                UserDefaults.standard.setValue(true, forKey: "login")
                navigationController?.show(controller, sender: nil)
                
            } else if !user.contains(where: { $0.email == loginUser.email && $0.password == loginUser.password }) {
                let alert = UIAlertController(title: "Error", message: "No such user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            }
        } else {
            emptyError.text = "Please fill all fields"
        }
        
    }
    
    @IBAction func register(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegisterController") as! RegisterController
        controller.callBack = { user in
            self.emailBox.text = user.email
            self.passwordBox.text = user.password
           
        }
        navigationController?.show(controller, sender: nil)
    }
}
