//
//  LoginViewController.swift
//  instagram
//
//  Created by Regie Daquioag on 2/21/18.
//  Copyright © 2018 Regie Daquioag. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if(user != nil){
                print("You are logged in")
            }
            self.performSegue(withIdentifier: "loginSeque", sender: nil)
        }
    }
    
    @IBAction func OnSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if(success){
                print("User registered successfully")
                self.performSegue(withIdentifier: "loginSeque", sender: nil)
            }else{
                print(error?.localizedDescription)
                if (error?._code == 202){
                    print("Username has been taken" )
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
