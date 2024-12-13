//
//  RegisterController.swift
//  OrderApp
//
//  Created by Elsever on 08.12.24.
//

import UIKit
import Lottie
class RegisterController: UIViewController {
    var colorConfigure = ColorConfigure()
    let manager = FileManagerHelp()
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var aniFood: LottieAnimationView!
    @IBOutlet weak var nameBox: UITextField!
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var phoneBox: UITextField!
    @IBOutlet weak var phoneError: UILabel!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var emptyError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var passwordBox: UITextField!
    var callBack: ((UserInfo) -> Void)?
    var user = [UserInfo]()
   

    override func viewDidLoad() {
        super.viewDidLoad()
       
        manager.readData { userInfo in
                self.user = userInfo
            }
        
        configureUI()
        animationCOnfigure()
    }
    
    func animationCOnfigure() {
        let path = Bundle.main.path(forResource: "AnimationRegister", ofType: "json")
        aniFood.animation = LottieAnimation.filepath(path!)
        aniFood.play()
        aniFood.loopMode = .loop
    }
    
    func configureUI() {
        colorConfigure.setGradientBackground(view)
        colorConfigure.selTextField(nameBox)
        colorConfigure.selTextField(emailBox)
        colorConfigure.selTextField(passwordBox)
        colorConfigure.selTextField(phoneBox)
        colorConfigure.setLabel(label: nameError, color: .red, size: 10)
        colorConfigure.setLabel(label: emailError, color: .red, size: 10)
        colorConfigure.setLabel(label: passwordError, color: .red, size: 10)
        colorConfigure.setLabel(label: emptyError, color: .red, size: 10)
        colorConfigure.setLabel(label: phoneError, color: .red, size: 10)
        colorConfigure.setButton(register)
    }
    
    @IBAction func register(_ sender: Any) {
        if let nameBox = nameBox.text, let emailBox = emailBox.text, let passwordBox = passwordBox.text {
            let user: UserInfo = UserInfo(name: nameBox, email: emailBox, password: passwordBox)
            self.user.append(user)
            callBack?(user)
            manager.writeData(user: self.user)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailBox.text {
            if let errorMassage = InvalidMail(email) {
                emailError.text = errorMassage
                emailError.isHidden = false
            } else {
                emailError.isHidden = true
            }
        }
        check()
    }
    
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordBox.text {
            if let errorMassage = InvalidPassword(password) {
                passwordError.text = errorMassage
                passwordError.isHidden = false
            } else {
                passwordError.isHidden = true
            }
        }
        check()
    }
    
    @IBAction func phoneChanged(_ sender: Any) {
        if let phoneNum = phoneBox.text {
            if let errorMassage = InvalidPhoneNum(phoneNum) {
                phoneError.text = errorMassage
                phoneError.isHidden = false
            } else {
                phoneError.isHidden = true
            }
        }
        check()
    }
    
    func InvalidPhoneNum(_ value: String) -> String? {
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set) {
            return "Phone number must be digits"
        }
        if value.count != 10 {
            return "Phone number must be 10 digits"
        }
        return nil
    }
    
    
    func InvalidMail(_ value: String) -> String? {
        let regExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regExp)
        if !pred.evaluate(with: value) {
            return "Invalid email"
        }
        return nil
    }
    
    func InvalidPassword(_ value: String) -> String? {
        
        if value.count < 8
        {
            return "Password must be at least 8 characters"
        }
        if containsDigital(value)!
        {
            return "Password must contain at least one digit"
        }
        if containsLower(value)!
        {
            return "Password must contain at least one lowercase"
        }
        if containsUpper(value)!
        {
            return "Password must contain at least one uppercase"
        }
    
        return nil
    }
    
    func containsDigital(_ value: String) -> Bool? {
        let regExp = ".*[0-9]+.*"
        let pred = NSPredicate(format:"SELF MATCHES %@", regExp)
        return !pred.evaluate(with: value)
    }
    func containsLower(_ value: String) -> Bool? {
        let regExp = ".*[a-z]+.*"
        let pred = NSPredicate(format:"SELF MATCHES %@", regExp)
        return !pred.evaluate(with: value)
    }
    func containsUpper(_ value: String) -> Bool? {
        let regExp = ".*[A-Z]+.*"
        let pred = NSPredicate(format:"SELF MATCHES %@", regExp)
        return !pred.evaluate(with: value)
    }
    
    func check() {
        if  passwordError.isHidden && emailError.isHidden  {
            register.isEnabled = true
        } else {
            register.isEnabled = false
        }
    }
    
}
