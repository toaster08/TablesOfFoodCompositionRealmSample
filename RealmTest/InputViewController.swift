//
//  InputViewController.swift
//  RealmTest
//
//  Created by 山田　天星 on 2021/02/20.
//  Copyright © 2021 toaster. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {
    
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodWeight: UITextField!

//    let realm = try! Realm(fileURL:Realm.Configuration.defaultConfiguration.fileURL! as URL)   // 追加する
    var calcObject = CalcObject()
    var food:FoodComposition!

    override func viewDidLoad() {
        super.viewDidLoad()
        foodName.text = food.food_name!
        foodWeight.text = String(100.0)
        foodView.layer.cornerRadius = 30
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
              let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
              self.view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
      }
    
    @IBAction func dismiss(_ sender: Any) {
        self.view.removeFromSuperview()
    }
 
    @IBAction func foodRegisterBtn(_ sender: Any) {
        let calcViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "registeredFood") as! CalcViewController
        let inputViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popover") as! InputViewController
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popunder") as! ViewController
        
        let bundleRealmPath = Bundle.main.url(forResource: "default", withExtension: "realm")
        let realm = try! Realm(configuration: Realm.Configuration(fileURL: bundleRealmPath!))
        calcObject.foodObject = food
        calcObject.foodWeight = Double(foodWeight.text!) ?? 100.0

        do {
            try! realm.write {
                let allFoods = realm.objects(CalcObject.self)

                if  allFoods.count != 0 {
                    calcObject.id = allFoods.count + 1
                    realm.add(calcObject)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    calcObject.id = 1
                    realm.add(calcObject)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } catch {
            print("エラー")
        }
        self.dismiss(animated: true, completion: nil)
    }

}


