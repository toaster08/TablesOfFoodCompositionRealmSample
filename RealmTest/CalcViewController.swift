//
//  CalcViewController.swift
//  RealmTest
//
//  Created by 山田　天星 on 2021/02/25.
//  Copyright © 2021 toaster. All rights reserved.
//

import UIKit
import RealmSwift  

class CalcViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
//    保持用のデータベース
    let bundleRealmPath = Bundle.main.url(forResource: "default", withExtension: "realm")
    var calcObjectArray:Results<CalcObject>!
    var foodWeight:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        let realmForSelection = try! Realm(configuration: Realm.Configuration(fileURL: bundleRealmPath))
        let config = Realm.Configuration(
         // Get the URL to the bundled file
         fileURL: bundleRealmPath,
         // Open the file in read-only mode as application bundles are not writeable
         readOnly: false,deleteRealmIfMigrationNeeded: true)
        calcObjectArray = realmForSelection.objects(CalcObject.self).sorted(byKeyPath: "id", ascending: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           tableView.reloadData()
           print(calcObjectArray.count)
       }
    
    // データの数（＝セルの数）を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calcObjectArray.count // ←修正する
    }

    // 各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "registeredCell", for: indexPath)
        // Cellに値を設定する.  --- ここから ---
        let foodList = calcObjectArray[indexPath.row]
        if calcObjectArray.count > 0 {
            cell.textLabel?.text = "　　食品名:\(foodList.foodObject!.food_name!)　重量：\(foodList.foodWeight)"
        } else {
            
        }
            // --- ここまで追加 ---
        return cell
    }
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      performSegue(withIdentifier: "registeredFood",sender: nil）,
        let inputViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popover") as! InputViewController
        
            let indexPath = self.tableView.indexPathForSelectedRow
            inputViewController.calcObject = calcObjectArray[indexPath!.row]
        
//        　親ビュー・子ビューのポップアップ
            self.addChild(inputViewController)
            inputViewController.view.frame = self.view.frame
            self.view.addSubview(inputViewController.view)
            inputViewController.didMove(toParent: self)
    }

    // セルが削除が可能なことを伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle {
        return .delete
    }

    // Delete ボタンが押された時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // --- ここから ---
        if editingStyle == .delete {
            // データベースから削除する
            let realmForSelection = try! Realm(configuration: Realm.Configuration(fileURL: bundleRealmPath))
            try! realmForSelection.write {
                realmForSelection.delete(self.calcObjectArray[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } // --- ここまで追加 --
    }
    
    @IBAction func addFood(_ sender: Any) {
         let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popunder") as! ViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    @IBAction func addFoodBtn(_ sender: Any) {

        }
 
    
}


