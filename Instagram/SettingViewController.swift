//
//  SettingViewController.swift
//  Instagram
//
//  Created by 齋藤友祐 on 2020/12/27.
//  Copyright © 2020 yusuke.saito. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SettingViewController: UIViewController {
    
    
    @IBOutlet weak var displayNameTextField: UITextField!
    
    //表示名変更ボタンをタップした時に呼ばれるメソッド
    @IBAction func handlechangeButton(_ sender: Any) {
        if let displayName = displayNameTextField.text {
            
            //表示名が入力されていない時はHUDを出して何もしない
            if displayName.isEmpty {
                SVProgressHUD.showError(withStatus: "表示名を入力してください")
                return
            }
            
            //表示名を設定する
            let user = Auth.auth().currentUser
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { error in
                    if let error = error {
                        SVProgressHUD.showError(withStatus: "表示名の変更に失敗しました")
                        print("DEBUG_PRINT:" + error.localizedDescription)
                        return
                    }
                    
                    print ("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました")
                    
                    //HUDで完了を知らせる
                    SVProgressHUD.showSuccess(withStatus: "表示名を変更しました")
                    
            }
            
        }
    }
        
        //キーボードを閉じる
        self.view.endEditing(true)
        
    }
    
    //ログアウトボタンをタップした時に呼ばれるメソッド
    @IBAction func handleLogoutButton(_ sender: Any) {
        
        //ログアウトする
        try! Auth.auth().signOut()
        
        //ログイン画面を表示する
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        
        //ログイン画面から戻って来た時のためにホーム画面を選択している状態にしておく
        tabBarController?.selectedIndex = 0
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //表示名を取得してTextFieldに設定する
        let user = Auth.auth().currentUser
        if let user = user {
            displayNameTextField.text = user.displayName
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
