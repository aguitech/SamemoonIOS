//
//  CanjearCodigoViewController.swift
//  samemoon
//
//  Created by Hector Aguilar on 24/01/18.
//  Copyright © 2018 Hector Aguilar. All rights reserved.
//


import UIKit

class CanjearCodigoViewController: UIViewController {
    
    
    //@IBOutlet weak var codigoCanjear: UITextField!
    @IBOutlet weak var txtCodigo: UITextField!
    
    
    
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
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
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
    
    
    
    @IBAction func canjeandoCodigo(sender: UIButton) {
        if txtCodigo.text!.isEmpty {
            
            let alerta = UIAlertController(title: "Introduce un código",
                                           message: "Introduce un código",
                                           preferredStyle: UIAlertControllerStyle.Alert)
            let accion = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                alerta.dismissViewControllerAnimated(true, completion: nil)
            })
            alerta.addAction(accion)
            self.presentViewController(alerta, animated: true, completion: nil)
            
            
        }else{
            let alerta = UIAlertController(title: txtCodigo.text!,
                                           message: txtCodigo.text!,
                                           preferredStyle: UIAlertControllerStyle.Alert)
            let accion = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                alerta.dismissViewControllerAnimated(true, completion: nil)
            })
            alerta.addAction(accion)
            self.presentViewController(alerta, animated: true, completion: nil)
            
            
            let url = NSURL(string: "http://aguitech.com/samemoon/cobradores/ios_canjear_codigo.php")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            let body = "id_usuario=\(idu)&codigo=\(txtCodigo)"
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
                            print("entro hasta aqui uju")
                            if id != nil {
                                
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                
                                //let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("CitaGuardada") as! CitaGuardadaViewController
                                //let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("Eventos") as! EventosViewController
                                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("Home") as! HomeController
                                //nextViewController.id_evento = id?.integerValue
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
     
     @IBAction func canjearCodigo(sender: UIButton) {
     //if descripcionEvento == nil{
     //!textOtro.text!.isEmpty
     //if codigoCanjear == nil {
     if codigoCanjear.text!.isEmpty {
     
     let alerta = UIAlertController(title: "Introduce un código",
     message: "Introduce un código",
     preferredStyle: UIAlertControllerStyle.Alert)
     let accion = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
     alerta.dismissViewControllerAnimated(true, completion: nil)
     })
     alerta.addAction(accion)
     self.presentViewController(alerta, animated: true, completion: nil)
     
     
     }else{
     
     }
     }
     
     
     , reason: '-[samemoon.CanjearCodigoViewController canjearCodigoWithSender:]: unrecognized selector sent to instance 0x175f7820'
     *** First throw call stack:
     
     
     
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

