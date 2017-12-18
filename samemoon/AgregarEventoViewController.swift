//
//  AgendarCitaViewController.swift/Users/hectoraguilar/Git/SamemoonIOS/samemoon/AgregarEventoViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 27/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class AgregarEventoViewController: UIViewController {
    
    
    @IBOutlet weak var nombreEvento: UITextField!
    
    @IBOutlet weak var descripcionEvento: UITextField!
    //@IBOutlet weak var fechaPicker: UIDatePicker!
    
    //@IBOutlet weak var fechaPicker: UIDatePicker!
    @IBOutlet weak var fechaEvento: UIDatePicker!
    
    //@IBOutlet weak var fechaPicker: UIDatePicker!
    /*
    @IBOutlet weak var motivo5: UIButton!
    @IBOutlet weak var motivo4: UIButton!
    @IBOutlet weak var motivo3: UIButton!
    @IBOutlet weak var motivo2: UIButton!
    @IBOutlet weak var motivo1: UIButton!
     
     @IBOutlet weak var doctoresSelect: UITextField!
     @IBOutlet weak var textOtro: UITextField!

     */
    
    //var idvet:Int? = nil
    var idDoctor = 0
    var motivo = 0
    //var fecha:String?
    var fecha:String?
    var idu = 0
    var strOtro = ""
    
    let preferences = NSUserDefaults.standardUserDefaults()
    
    let currentLevelKey = "arrayUsuario"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DetalleEventoViewController.keyboardWillHide)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DetalleEventoViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        */
        
        if preferences.objectForKey(currentLevelKey) == nil {
        } else {
            let array_usuario = preferences.objectForKey(currentLevelKey)
            
            idu = (array_usuario!["id_usuario"]!!.integerValue)!
            
        }
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calls this function when the tap is recognized.
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    /*
    @IBAction func changeFecha(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        let strDate = dateFormatter.stringFromDate(fechaPicker.date)
        self.fecha = strDate
    }
     
     
     @IBAction func changeFecha(sender: UIDatePicker) {
     let dateFormatter = NSDateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
     let strDate = dateFormatter.stringFromDate(fechaPicker.date)
     self.fecha = strDate
     }
    */
    
    
    @IBAction func cambiarFecha(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        let strDate = dateFormatter.stringFromDate(fechaEvento.date)
        self.fecha = strDate
    }
    
    @IBAction func agregarEvento(sender: UIButton) {
        //if descripcionEvento == nil{
        //!textOtro.text!.isEmpty
        if fecha == nil {
            
            let alerta = UIAlertController(title: "Datos incorrectos",
                                           message: "Usuario ó Password incorrecto",
                                           preferredStyle: UIAlertControllerStyle.Alert)
            let accion = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                alerta.dismissViewControllerAnimated(true, completion: nil)
            })
            alerta.addAction(accion)
            self.presentViewController(alerta, animated: true, completion: nil)
            
            
        }else{
            //let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/motivo.php")
            let url = NSURL(string: "http://aguitech.com/samemoon/cobradores/ios_agregar_evento.php")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            //let body = "id_usuario=\(idu)&evento=\(nombreEvento)&descripcion=\(descripcionEvento)&fecha=\(fecha!)\(strOtro)"
            let body = "id_usuario=\(idu)&evento=\(nombreEvento.text!)&descripcion=\(descripcionEvento.text!)&fecha=\(fecha!)"
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
                            
                            let id = parseJson["id_evento"]
                            print("entro hasta aqui")
                            if id != nil {
                                
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                
                                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeView") as! HomeController
                                //nextViewController.id_cita = id?.integerValue
                                self.presentViewController(nextViewController, animated:false, completion:nil)
                            }
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
    /*
    @IBAction func returnDetalle(sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("DetalleVeterinario") as! VeterinariosDosViewController
        nextViewController.veterinaria = idvet!
        self.presentViewController(nextViewController, animated: false, completion: nil)
    }
    */
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
            else {
                
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
            else {
                
            }
        }
    }

    
    
}
// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
