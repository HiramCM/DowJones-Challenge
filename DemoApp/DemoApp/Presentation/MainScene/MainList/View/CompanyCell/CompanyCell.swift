//
//  CompanyCell.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 04/10/21.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(with company:CompanyModel?) {
        symbolLabel.text      = company?.symbol      ?? ""
        companyNameLabel.text = company?.companyName ?? ""
        priceChangeLabel.text = company?.priceChange ?? ""
    }

}
