//
//  ViewController.swift
//  RealmTest
//
//  Created by 山田　天星 on 2021/02/20.
//  Copyright © 2021 toaster. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, UISearchResultsUpdating{
    
    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController()
    var foodArray:Results<FoodComposition>!
    var searchResults:Results<FoodComposition>!
    let bundleRealmPath = Bundle.main.url(forResource: "default", withExtension: "realm")

        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        searchBar.delegate = self 

        let config = Realm.Configuration(
        // Get the URL to the bundled file
        fileURL: bundleRealmPath,
        // Open the file in read-only mode as application bundles are not wri32i jbhuiteable
        readOnly: true,deleteRealmIfMigrationNeeded: true)

        let realm = try! Realm(configuration: Realm.Configuration(fileURL: bundleRealmPath))
        foodArray = realm.objects(FoodComposition.self).sorted(byKeyPath: "id", ascending: true)
        
        self.view.addSubview(tableView)
        searchController = UISearchController(searchResultsController: nil)
        //結果表示用のビューコントローラーに自分を設定する。
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        //検索中にコンテンツをグレー表示にしない。
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        //テーブルビューのヘッダーにサーチバーを設定する。
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // DB内のタスクが格納されるリスト。
    // データの数（＝セルの数）を返すメソッド
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
//            print("searchResults:\(searchResults!.count)")
            return searchResults.count
        } else {
//            print("searchResults:\(searchResults!.count)")
            return foodArray.count
        }
       }
    
   // 各セルの内容を返すメソッド
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // 再利用可能な cell を得る
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let foodComposition = foodArray![indexPath.row]
            
           // Cellに値を設定する.  --- ここから ---
            if searchController.isActive {
                let searchComposition = searchResults![indexPath.row]
                cell.textLabel!.text = "\(searchComposition.id.value!) : \(searchComposition.food_name!)"
            } else {
                cell.textLabel!.text = "\(foodComposition.id.value!) : \(foodComposition.food_name!)"
            }
            return cell
        }
        
        // 各セルを選択した時に実行されるメソッド
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //performSegue(withIdentifier:      "cellSegue",sender: nil)
            let inputViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popover") as! InputViewController
            let indexPath = self.tableView.indexPathForSelectedRow

            if searchController.isActive {
                inputViewController.food = searchResults![indexPath!.row]
            } else {
                inputViewController.food = foodArray![indexPath!.row]
            }
            
            // 子クラスに追加
            self.addChild(inputViewController)
            inputViewController.view.frame = self.view.frame
            self.view.addSubview(inputViewController.view)
            inputViewController.didMove(toParent: self)
        }
    
      //検索文字列変更時の呼び出しメソッド
    func updateSearchResults(for searchController: UISearchController) {
        print("検索バー実行中")
        _ = Realm.Configuration(
               // Get the URL to the bundled file
               fileURL: bundleRealmPath,
               // Open the file in read-only mode as application bundles are not wri32i jbhuiteable
               readOnly: true,deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: Realm.Configuration(fileURL: bundleRealmPath))

        guard searchController.searchBar.text! != "" else {
            self.searchResults = foodArray
                tableView.reloadData()
                return
        }
            //検索文字列を含むデータを検索結果配列に格納する。
            let search =
                realm.objects(FoodComposition.self).filter("food_name CONTAINS '\(searchController.searchBar.text!)'")
            searchResults = search.self
        
//            print(search.count)
//            print(type(of: search))
//            print("サーチバーテキストisnotEmpty：\(searchController.searchBar.text!)")
           //テーブルビューを再読み込みする。
            tableView.reloadData()
        }
    
}
 

