//
//  MenuViewController.swift
//  zungu
//
//  Created by Hector Aguilar on 20/10/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class RegistroMascotaController: UIViewController {
    
    @IBOutlet weak var nombreMiMascota: UITextField!
    
    @IBOutlet weak var nacimientoMiMascota: UITextField!
    
    @IBOutlet weak var razaMiMascota: UITextField!
    
    @IBOutlet weak var pesoMiMascota: UITextField!
    
    @IBOutlet weak var colorMiMascota: UITextField!
    
    @IBOutlet weak var heatsMiMascota: UITextField!
    
    @IBOutlet weak var seniasParticulares: UITextField!
    
    let id_usuario = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registrarMascota(sender: UIButton) {
        if(nombreMiMascota.text!.isEmpty || nacimientoMiMascota.text!.isEmpty || razaMiMascota.text!.isEmpty || pesoMiMascota.text!.isEmpty || colorMiMascota.text!.isEmpty || heatsMiMascota.text!.isEmpty || seniasParticulares.text!.isEmpty) {
            print("entroerror")
            nombreMiMascota.attributedPlaceholder = NSAttributedString(string: "Nombre", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            nacimientoMiMascota.attributedPlaceholder = NSAttributedString(string: "Fecha de nacimiento", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            razaMiMascota.attributedPlaceholder = NSAttributedString(string: "Raza", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
           
            
            pesoMiMascota.attributedPlaceholder = NSAttributedString(string: "Peso", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            colorMiMascota.attributedPlaceholder = NSAttributedString(string: "Color", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            heatsMiMascota.attributedPlaceholder = NSAttributedString(string: "Heats", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            seniasParticulares.attributedPlaceholder = NSAttributedString(string: "Señas particulares", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])

            
        }else{
            print("entro");
            let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/agregar_mascota.php")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            
            /*
             var descrip:String = ""
             
             if descripcionAdopta2.text!.isEmpty{
             descrip = descripcionAdopta1.text!
             }else{
             
             descrip = descripcionAdopta1.text! + "%20" + descripcionAdopta2.text!
             }
             */
            
            let body = "id_usuario=\(id_usuario)&nombre=\(nombreMiMascota.text!)&fecha_nacimiento=\(nacimientoMiMascota.text!)&raza=\(razaMiMascota.text!)&peso=\(pesoMiMascota.text!)&color=\(colorMiMascota.text!)&heats=\(heatsMiMascota.text!)&senias_particulares=\(seniasParticulares.text!)"
            
            
            
            request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, reponse, error) in
                if error == nil{
                    print("dentro")
                    dispatch_async(dispatch_get_main_queue(), {
                        do{
                            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                            
                            guard let parseJson = json else{
                                print("Error parsing")
                                return
                            }
                            print(parseJson)
                            
                            print("ok")
                            /*
                             let id = parseJson["id_adopta_mascota"]
                             
                             if id != nil {
                             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                             
                             let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("MascotaAgregada") as! MascotaAgregadaViewController
                             self.presentViewController(nextViewController, animated:true, completion:nil)
                             }
                             */
                            
                        } catch{
                            print(error)
                        }
                    })
                    
                }else{
                    
                    print(error)
                }
            }).resume()
        }
    }
    
    @IBAction func limpiarInformacion(sender: UIButton) {
        nombreMiMascota.text = ""
        nacimientoMiMascota.text = ""
        razaMiMascota.text = ""
        pesoMiMascota.text = ""
        colorMiMascota.text = ""
        heatsMiMascota.text = ""
        seniasParticulares.text = ""
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
