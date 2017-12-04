//
//  EditarPerfilViewController.swift
//  zungu
//
//  Created by Hector Aguilar on 20/10/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class EditarPerfilViewController: UIViewController {
    
    
    
    @IBOutlet weak var sexo: UITextField!
    @IBOutlet weak var cumpleanios: UITextField!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var contrasenia: UITextField!
    @IBOutlet weak var ciudad: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var apellido: UITextField!
    @IBOutlet weak var nombre: UITextField!
    var ArrayPerfil:[String: String] = [String: String]()
    
    /*
    @IBOutlet weak var telefonoPerfil: UILabel!
    
    @IBOutlet weak var emailPerfil: UILabel!
    @IBOutlet weak var ciudadPerfil: UILabel!
    @IBOutlet weak var nombrePerfil: UILabel!
    @IBOutlet weak var imagenPerfil: UIImageView!
    */
    var id_usuario = 0
    let preferences = NSUserDefaults.standardUserDefaults()
    let currentLevelKey = "arrayUsuario"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if preferences.objectForKey(currentLevelKey) == nil {
        } else {
            let array_usuario = preferences.objectForKey(currentLevelKey)
            
            id_usuario = (array_usuario!["id_usuario"]!!.integerValue)!
            
            print(id_usuario)
            self.cargarDatos()
        }
        //self.cargarDatos()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editarPerfil(sender: UIButton) {
        
        if(cumpleanios.text!.isEmpty || sexo.text!.isEmpty || telefono.text!.isEmpty || contrasenia.text!.isEmpty || ciudad.text!.isEmpty || email.text!.isEmpty || apellido.text!.isEmpty || nombre.text!.isEmpty) {
            print("entroerror")
            cumpleanios.attributedPlaceholder = NSAttributedString(string: "Cumpleaños", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            sexo.attributedPlaceholder = NSAttributedString(string: "Sexo", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            telefono.attributedPlaceholder = NSAttributedString(string: "Teléfono", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            contrasenia.attributedPlaceholder = NSAttributedString(string: "Contraseña", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            ciudad.attributedPlaceholder = NSAttributedString(string: "Ubicación", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            email.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            apellido.attributedPlaceholder = NSAttributedString(string: "Apellido", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            nombre.attributedPlaceholder = NSAttributedString(string: "Nombre", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
        }else{
            print("entro");
            let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/editar_perfil.php")
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
            /*
             @IBOutlet weak var telefono: UITextField!
             @IBOutlet weak var contrasenia: UITextField!
             @IBOutlet weak var ciudad: UITextField!
             @IBOutlet weak var email: UITextField!
             @IBOutlet weak var apellido: UITextField!
             @IBOutlet weak var nombre: UITextField!
             
             */
            
            let body = "id_usuario=\(id_usuario)&nombre=\(nombre.text!)&apellido=\(apellido.text!)&correo=\(email.text!)&ciudad=\(ciudad.text!)&contrasena=\(contrasenia.text!)&telefono=\(telefono.text!)&cumpleanios=\(cumpleanios.text!)&sexo=\(sexo.text!)"
            
            
            
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
                            
                            self.cargarDatos()
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
    func cargarDatos(){
        //let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/adoptar_mascota.php?lim=\(lim)")
        //idu=\(id_usuario)
        //let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/editar_perfil.php?id_usuario=4")
        print("\(id_usuario)")
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/editar_perfil.php?id_usuario=\(id_usuario)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    self.ArrayPerfil = jsonResult as! NSDictionary as! [String : String]
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        /*
                         if self.lim == 0{
                         self.total = Int(self.ArrayPerfil["total"]!)!
                         }
                         
                         @IBOutlet weak var telefono: UITextField!
                         @IBOutlet weak var contrasenia: UITextField!
                         @IBOutlet weak var ciudad: UITextField!
                         @IBOutlet weak var email: UITextField!
                         @IBOutlet weak var nombre: UITextField!
                         
                         $nombre = $_GET["nombre"];
                         $apellido = $_GET["apellido"];
                         $correo = $_GET[""];
                         
                         $id = $_GET["id"];
                         */
                        self.nombre.text = self.ArrayPerfil["nombre"]
                        self.apellido.text = self.ArrayPerfil["apellido"]
                        self.contrasenia.text = self.ArrayPerfil["contrasena"]
                        self.email.text = self.ArrayPerfil["correo"]
                        self.telefono.text = self.ArrayPerfil["telefono"]
                        self.ciudad.text = self.ArrayPerfil["ciudad"]
                        self.cumpleanios.text = self.ArrayPerfil["cumpleanios"]
                        self.sexo.text = self.ArrayPerfil["sexo"]
                        
                        //self.nombrePerfil.text = self.ArrayPerfil["nombre"]
                        //self.emailPerfil.text = self.ArrayPerfil["correo"]
                        
                        /*
                         let imagenPatrocinador = "http://hyperion.init-code.com/zungu/mascotas_subidas/\(self.ArrayPatrocinador["imagen"]!)"
                         
                         if let url = NSURL(string: imagenPatrocinador) {
                         if let data = NSData(contentsOfURL: url) {
                         self.imagenPrincipal.image = UIImage(data: data)
                         }
                         }else{
                         print("no pudo")
                         }
                         */
                        
                        //self.imagenPatrocinio.image = UIImage(data: data)
                        return
                    })
                    
                }
            }
        }
        task.resume()
        
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

