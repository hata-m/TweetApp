//
//  TweetViewController.swift
//  TweetApp
//
//  Created by PC220205 on 2022/09/01.
//

import Foundation
import UIKit

protocol TweetViewControllerDelegate{
    func didFinishEditing(massage: Tweet!)
}

class TweetViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    var delegate: TweetViewControllerDelegate?
    var tweet:Tweet!
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweet = Tweet()
    }

    @IBAction func tweetButton(_ sender: Any) {
        if let delegate = delegate {
            let tweet = Tweet()
            tweet.name = nameTextField.text
            tweet.content = contentTextView.text
            tweet.tweetTitle = titleTextField.text
            tweet.uiImage = image
            delegate.didFinishEditing(massage: tweet)
        }
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func getImage(_ sender: Any) {
        let picker = UIImagePickerController() //アルバムを開く処理を呼び出す
           picker.sourceType = .photoLibrary
           picker.delegate = self
           present(picker, animated: true)
           self.present(picker, animated: true, completion: nil)
    }
    
    // 画像が選択された時に呼ばれる
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
       if let selectedImage = info[.originalImage] as? UIImage {
           let resize = selectedImage.resized(size: CGSize(width: 55, height: 55))
           imageView.image = resize//imageViewにカメラロールから選んだ画像を表示する
           image = resize
       }
       self.dismiss(animated: true)  //画像をImageViewに表示したらアルバムを閉じる
   }
       
   // 画像選択がキャンセルされた時に呼ばれる
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       self.dismiss(animated: true, completion: nil)
   }
}
extension UIImage {
    func resized(size: CGSize) -> UIImage {
        // リサイズ後のサイズを指定して`UIGraphicsImageRenderer`を作成する
        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { (context) in
            // 描画を行う
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
