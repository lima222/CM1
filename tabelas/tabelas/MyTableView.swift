//
//  MyTableView.swift
//  tabelas
//
//  Created by DocAdmin on 4/27/18.
//  Copyright © 2018 ipvc.estg. All rights reserved.
//

import UIKit

class MyTableView: UITableViewCell {

    @IBOutlet var labelInfo: UILabel!
    @IBOutlet var othertituo: UILabel!
    @IBOutlet var labelSubTitulo: UILabel!
    @IBOutlet var labelImag: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
