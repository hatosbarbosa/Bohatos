//
//  PalavraDaSemanaTableViewCell.swift
//  Bohatos
//
//  Created by Hatos Barbosa on 21/05/19.
//  Copyright © 2019 Hatos Barbosa. All rights reserved.
//

import UIKit

class PalavraDaSemanaTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundLayer: UIView!
    @IBOutlet weak var palavraDaSemanaLabel: UILabel!
    @IBOutlet weak var palavraDaSemanaDescription: UILabel!
    @IBOutlet weak var palavraDaSemanaDate: UILabel!
    
   
    
    func setShadows() {
        backgroundLayer.layer.shadowColor = UIColor.black.cgColor
        backgroundLayer.layer.shadowOpacity = 1
        backgroundLayer.layer.shadowOffset = .zero
        backgroundLayer.layer.shadowRadius = 130
        backgroundLayer.layer.shadowPath = UIBezierPath(rect: backgroundLayer.bounds).cgPath
        backgroundLayer.layer.shouldRasterize = true
        backgroundLayer.layer.rasterizationScale = UIScreen.main.scale
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //nothing to do here since I won't use it. - Hatos
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadows()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
