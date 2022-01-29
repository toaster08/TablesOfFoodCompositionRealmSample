//
//  CustomViewCell.swift
//  RealmTest
//
//  Created by toaster on 2022/01/27.
//  Copyright © 2022 toaster. All rights reserved.
//

import UIKit

final class CustomViewCell: UITableViewCell {

    @IBOutlet private weak var foodNameLabel: UILabel!
    @IBOutlet private weak var ketoIndexValueLabel: UILabel!
    @IBOutlet private weak var foodAmountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(food:CalcObject) {
        foodNameLabel.text = food.foodObject.food_name
        foodAmountLabel.text = String(food.foodWeight)
        ketoIndexValueLabel.text = "ケトン値"
    }

    func configure(Tables:TablesOfFoodComposition) {
        foodNameLabel.text = Tables.food_name
        foodAmountLabel.text = String(100.0)
        ketoIndexValueLabel.text = "ケトン値"
    }
    
}
