// Copyright (c) 2014-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit
import AccountKit
import FBSDKLoginKit

// MARK: - AccountViewController: UIViewController

class AccountViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var accountIDLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    // MARK: Properties
    
    fileprivate var accountKit = AKFAccountKit(responseType: .accessToken)
    
    /// A flag indicating the presence of an AccountKit access token
    fileprivate let isAccountKitLogin: Bool = {
        return AKFAccountKit(responseType: .accessToken).currentAccessToken != nil
    }()
    
    /// A flag indicating the presence of an Facebook SDK access token
    fileprivate let isFacebookLogin: Bool = {
        return FBSDKAccessToken.current() != nil
    }()
    
    // MARK: View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyStyling()
        
        //Check if we are working with Account Kit or Facebook OAuth
        if isAccountKitLogin {
            self.accountKit.requestAccount { (account, error) in
                if error != nil {
                    self.accountIDLabel.text = "N/A"
                    self.titleLabel.text = "Error"
                    self.valueLabel.text = error?.localizedDescription
                } else {
                    self.accountIDLabel.text = account?.accountID
                    if let emailAddress = account?.emailAddress, emailAddress.characters.count > 0 {
                        self.titleLabel.text = "Email Address"
                        self.valueLabel.text = emailAddress
                    } else if let phoneNumber = account?.phoneNumber {
                        self.titleLabel.text = "Phone Number"
                        self.valueLabel.text = phoneNumber.stringRepresentation()
                    }

                }
            }
        
        //We are using Facebook OAuth, hide.
        } else {
            
            DispatchQueue.main.async {
                self.valueLabel.isHidden = !self.isAccountKitLogin
                self.accountIDLabel.isHidden = !self.isAccountKitLogin
            }

        }
        
        
    }
    
    // MARK: Styling
    
    func applyStyling() {
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 9/255, green: 212/255, blue: 182/255, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 17)!]
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    // MARK: Actions
    
    @IBAction func logOut(_ sender: AnyObject){
        if isAccountKitLogin {
            accountKit.logOut()
        } else {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
}
