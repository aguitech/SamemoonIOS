//
//  FiltroViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 20/10/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class FiltroViewController: UIViewController {
    
    var tipo_mascota = 0
    var zona = ""
    var tamano = 0
    var edad = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func aplicarFiltro(sender: UIButton) {
        if edad != 0 || tamano != 0 || zona != "" || tipo_mascota != 0{
            
        }
    }
    
    @IBAction func limpiarFiltro(sender: UIButton) {
        tipo_mascota = 0
        zona = ""
        tamano = 0
        edad = 0

    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
