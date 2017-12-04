//
//  CellCarritoTableViewCell.swift
//  zungu
//
//  Created by Giovanni Aranda on 19/10/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class CellCarritoTableViewCell: UITableViewCell {

    @IBOutlet weak var cantidadProducto: UILabel!
    @IBOutlet weak var precioProducto: UILabel!
    @IBOutlet weak var nombreProducto: UILabel!
    @IBOutlet weak var veterinariaNombre: UILabel!
    @IBOutlet weak var imagenProducto: UIImageView!
    var cantidad:Int = 0
    
    var tapAction: ((UITableViewCell) -> Void)?
    var tapAction2:((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func masCantidad(sender: UIButton) {
        tapAction!(self)
        
    }
    @IBAction func menosCantidad(sender: UIButton) {
        tapAction2!(self)
    }

}
