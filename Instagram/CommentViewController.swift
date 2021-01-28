//
//  CommentViewController.swift
//  Instagram
//
//  Created by 齋藤友祐 on 2021/01/17.
//  Copyright © 2021 yusuke.saito. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentText: UITextField!
    
    var postData : PostData!
    var postArray:[PostData] = []
    
    //commentAddButtonがタップされた時に呼ばれるメソッド
    @IBAction func commentAddButton(_ sender: Any) {
        
        //HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        //FireStoreにコメントデータを保存する
        var updateValue: FieldValue
        let comment = self.commentText.text!
        updateValue = FieldValue.arrayUnion([comment])
        
        //コメントデータの保存場所を定義する
        let commentRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        commentRef.updateData(["comment": updateValue])
        
        //nameの保存場所を定義する
        let nameRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        nameRef.updateData(["name": updateValue])
        
        //HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        //投稿処理が完了したのでホーム画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    //commentCancelButtonがタップされた時に呼ばれるメソッド
    @IBAction func commentCancelButton(_ sender: Any) {
        
        //ホーム画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
