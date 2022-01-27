import Foundation
import RealmSwift

class FoodComposition: Object {
    let id = RealmOptional<Int>()
//    dynamic var id:Int? = nil
    
    let food_code = RealmOptional<Int>()
    @objc dynamic var food_name: String? = nil
    let energy = RealmOptional<Int>()
    let water = RealmOptional<Double>()
    let protein = RealmOptional<Double>()
    let fat = RealmOptional<Int>()
    let dietaryfiber = RealmOptional<Double>()
    let carbohydrate = RealmOptional<Double>()
    @objc dynamic var category: String? = nil
    
}
    
class CalcObject:Object {
       // 管理用 ID。プライマリーキー
       @objc dynamic var id:Int = 0

       // 内容
       @objc dynamic var foodObject:FoodComposition!

       // 日時
       @objc dynamic var foodWeight:Double = 0.0

       // id をプライマリーキーとして設定
       override static func primaryKey() -> String? {
           return "id"
       }
}


