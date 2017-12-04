//
//  CitaGuardadaViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 13/10/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class CitaGuardadaViewController: UIViewController {

    @IBOutlet weak var buttonMetodo3: UIButton!
    @IBOutlet weak var buttonMetodo2: UIButton!
    @IBOutlet weak var buttonMetodo1: UIButton!
    @IBOutlet weak var buttonConfirmar: UIButton!
    @IBOutlet weak var nombreDoctora: UILabel!
    @IBOutlet weak var fechaCita: UILabel!
    @IBOutlet weak var precioCita: UILabel!
    var id_cita:Int? = nil
    var metodo_pago = 0
     var ArrayPatrocinador:[String: String] = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonConfirmar.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        
    }
    
    func cargarDatos(){
       
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/motivorow.php")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayPatrocinador = jsonResult as! [String : String]
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.nombreDoctora.text = self.ArrayPatrocinador["doctor"]
                        self.fechaCita.text = self.ArrayPatrocinador["fecha"]
                        self.precioCita.text = "$\(self.ArrayPatrocinador["precio"])"
                        
                        return
                    })
                    
                }
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func metodoPago1(sender: UIButton) {
        self.metodo_pago = 1
        
        self.buttonMetodo1.setImage(UIImage(named:"button-selected2"), forState: UIControlState.Normal)
        self.buttonMetodo2.setImage(UIImage(named:"prendido3"), forState: UIControlState.Normal)
        self.buttonMetodo3.setImage(UIImage(named:"prendido3"), forState: UIControlState.Normal)
        
    }
    
    @IBAction func metodoPago2(sender: UIButton) {
        self.metodo_pago = 2
        self.buttonMetodo1.setImage(UIImage(named:"prendido3"), forState: UIControlState.Normal)
        self.buttonMetodo2.setImage(UIImage(named:"button-selected2"), forState: UIControlState.Normal)
        self.buttonMetodo3.setImage(UIImage(named:"prendido3"), forState: UIControlState.Normal)
    }
    
    @IBAction func metodoPago3(sender: UIButton) {
        self.metodo_pago = 3
        self.buttonMetodo1.setImage(UIImage(named:"prendido3"), forState: UIControlState.Normal)
        self.buttonMetodo2.setImage(UIImage(named:"prendido3"), forState: UIControlState.Normal)
        self.buttonMetodo3.setImage(UIImage(named:"button-selected2"), forState: UIControlState.Normal)

    }
    
    @IBAction func confirmar(sender: UIButton) {
        if metodo_pago == 0{
            let alerta = UIAlertController(title: "Metodo de Pago incorrecto",
                                           message: "Por favor elija un métodod de pago",
                                           preferredStyle: UIAlertControllerStyle.Alert)
            let accion = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                alerta.dismissViewControllerAnimated(true, completion: nil)
            })
            alerta.addAction(accion)
            self.presentViewController(alerta, animated: true, completion: nil)
        }else{
            let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/motivo.php")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            let body = "metodo=\(metodo_pago)&idc=\(id_cita!)"
            print(body)
            request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, reponse, error) in
                if error == nil{
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        do{
                            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                            
                            guard let parseJson = json else{
                                print("Error parsing")
                                return
                            }
                            
                           
                           // if id != nil {
                                
                                let alerta = UIAlertController(title: "Pago",
                                    message: "Tu pago será procesado",
                                    preferredStyle: UIAlertControllerStyle.Alert)
                                let accion = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                                    alerta.dismissViewControllerAnimated(true, completion: nil)
                                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                    
                                    let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("VeterinariasMapa") as! VeterinariasViewController
                                    self.presentViewController(nextViewController, animated:true, completion:nil)
                                })
                                alerta.addAction(accion)
                                self.presentViewController(alerta, animated: true, completion: nil)
                          //  }
                            /*}else{
                             let alerta = UIAlertController(title: "Usuario existente",
                             message: "Este correo ya existe",
                             preferredStyle: UIAlertControllerStyle.Alert)
                             let accion = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                             alerta.dismissViewControllerAnimated(true, completion: nil)
                             })
                             alerta.addAction(accion)
                             self.presentViewController(alerta, animated: true, completion: nil)
                             }*/
                            
                            
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
   
    @IBAction func cancelar(sender: UIButton) {
    }
    
    


}
