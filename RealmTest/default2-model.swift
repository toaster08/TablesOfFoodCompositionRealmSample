import Foundation
import RealmSwift

class Standard tables of food composition in Japan: Object {
    let id = RealmOptional<Int>()
    let food_code = RealmOptional<Int>()
    @objc dynamic var food_name: String? = nil
    let energy = RealmOptional<Int>()
    let water = RealmOptional<Double>()
    let protein = RealmOptional<Double>()
    let fat = RealmOptional<Int>()
    let dietaryfiber = RealmOptional<Double>()
    let carbohydrate = RealmOptional<Double>()
    @objc dynamic var category: String? = nil
    @objc dynamic var memo: String? = nil
}

