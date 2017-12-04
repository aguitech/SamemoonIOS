//
//  AgendarCitaViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 27/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class AgendarCitaViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    

    
    @IBOutlet weak var fechaPicker: UIDatePicker!
    @IBOutlet weak var motivo5: UIButton!
    @IBOutlet weak var motivo4: UIButton!
    @IBOutlet weak var motivo3: UIButton!
    @IBOutlet weak var motivo2: UIButton!
    @IBOutlet weak var motivo1: UIButton!
    @IBOutlet weak var doctoresSelect: UITextField!
    @IBOutlet weak var textOtro: UITextField!
    var ArrayList = [[String: String]]()
    let pickerView = UIPickerView()
    var idvet:Int? = nil
    var idDoctor = 0
    var motivo = 0
    var fecha:String?
    var idu = 0
    var strOtro = ""
    
    let preferences = NSUserDefaults.standardUserDefaults()
    
    let currentLevelKey = "arrayUsuario"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AgendarCitaViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AgendarCitaViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        if preferences.objectForKey(currentLevelKey) == nil {
        } else {
            let array_usuario = preferences.objectForKey(currentLevelKey)
            
            idu = (array_usuario!["id_usuario"]!!.integerValue)!
            
        }
       
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.whiteColor()
        
        
        doctoresSelect.inputView = pickerView
        
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.BlackTranslucent
        
        toolBar.tintColor = UIColor.whiteColor()
        
        toolBar.backgroundColor = UIColor.grayColor()
        
        let defaultButton = UIBarButtonItem(title: "Default", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.tappedToolBarBtn))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clearColor()
        
        label.textColor = UIColor.whiteColor()
        
        label.text = "Selecciona uno"
        
        label.textAlignment = NSTextAlignment.Center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([defaultButton,flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        doctoresSelect.inputAccessoryView = toolBar
        
        cargaDatos()

        // Do any additional setup after loading the view.
    }
    
    func cargaDatos(){
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/doctores.php?vet=\(idvet!)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    //self.ArrayList = [[String: String]]()
                    if let items = jsonResult as? [[String: String]]{
                        print(items)
                        for item in items{
                            self.ArrayList.append(item)
                        }
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                      print(self.ArrayList)
                        self.pickerView.reloadAllComponents()
                        
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ArrayList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ArrayList[row]["nombre"]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        doctoresSelect.text = ArrayList[row]["nombre"]
        idDoctor = Int(ArrayList[row]["id_doctor"]!)!
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        doctoresSelect.text = "Doctor / Doctora"
        
        doctoresSelect.resignFirstResponder()
    }
    
    func donePressed(sender: UIBarButtonItem) {
        
        doctoresSelect.resignFirstResponder()
        
    }
    
    @IBAction func changeFecha(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        let strDate = dateFormatter.stringFromDate(fechaPicker.date)
        self.fecha = strDate
    }
    
    @IBAction func accionMotivo1(sender: UIButton) {
        self.motivo = 1
       
        self.motivo1.setImage(UIImage(named:"button-selected"), forState: UIControlState.Normal)
        self.motivo2.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo3.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo4.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo5.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        
    }
    
    @IBAction func accionMotivo2(sender: UIButton) {
        self.motivo = 2
       
        self.motivo1.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo2.setImage(UIImage(named:"button-selected"), forState: UIControlState.Normal)
        self.motivo3.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo4.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo5.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
    }
    
    @IBAction func accionMotivo3(sender: UIButton) {
        self.motivo = 3
        
        self.motivo1.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo2.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo3.setImage(UIImage(named:"button-selected"), forState: UIControlState.Normal)
        self.motivo4.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo5.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)

    }
    
    @IBAction func accionMotivo4(sender: UIButton) {
        self.motivo = 4
       
        self.motivo1.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo2.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo3.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo4.setImage(UIImage(named:"button-selected"), forState: UIControlState.Normal)
        self.motivo5.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
    }
    @IBAction func accionMotivo5(sender: UIButton) {
        self.motivo = 5
        self.motivo1.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo2.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo3.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo4.setImage(UIImage(named:"prendido2"), forState: UIControlState.Normal)
        self.motivo5.setImage(UIImage(named:"button-selected"), forState: UIControlState.Normal)
        
        if(!textOtro.text!.isEmpty){
            strOtro = "&otro=\(textOtro.text!)"
        }
        
    }

    @IBAction func continuarCita(sender: UIButton) {
        if motivo == 0 || fecha == nil || idDoctor == 0{
            let alerta = UIAlertController(title: "Datos incorrectos",
                                           message: "Usuario ó Password incorrecto",
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
            let body = "idv=\(idvet!)&idu=\(idu)&idd=\(idDoctor)&motivo=\(motivo)&fecha=\(fecha!)\(strOtro)"
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
                            
                           let id = parseJson["id_cita"]
                            print("entro hasta aqui")
                            if id != nil {
                                                               
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                
                                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("CitaGuardada") as! CitaGuardadaViewController
                                nextViewController.id_cita = id?.integerValue
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
    
    @IBAction func returnDetalle(sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("DetalleVeterinario") as! VeterinariosDosViewController
        nextViewController.veterinaria = idvet!
        self.presentViewController(nextViewController, animated: false, completion: nil)
    }
    
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
