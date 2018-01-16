//
//  IniciarSesionViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 05/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class IniciarSesionViewController: UIViewController, FBSDKLoginButtonDelegate{

    @IBOutlet weak var correoInicio: UITextField!
    @IBOutlet weak var passInicio: UITextField!
    
    @IBOutlet weak var loginFacebook: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureFacebook()
        // Do any additional setup after loading the view.
    }
    func configureFacebook()
    {
        loginFacebook.readPermissions = ["public_profile", "email", "user_friends"];
        loginFacebook.delegate = self
        //loginFacebook.readPermissions = ["public_profile", "email", "user_friends"];
        //loginFacebook.delegate = self
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        //ivUserProfileImage.image = nil
        //lblName.text = ""
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, email, last_name, picture.type(large)"]).startWithCompletionHandler { (connection, result, error) -> Void in
            
            print("login fb")
            
            let strFirstName: String = (result.objectForKey("first_name") as? String)!
            print(strFirstName)
            let strLastName: String = (result.objectForKey("last_name") as? String)!
            print(strLastName)
            let strIDFacebook: String = (result.objectForKey("id") as? String)!
            print(strIDFacebook)
            let strEmail: String = (result.objectForKey("email") as? String)!
            print(strEmail)
            print(result)
            
            //let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/registro_facebook.php")
            let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/registro_facebook.php")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            //let body = "nombre=\(nombreInput.text!)&pass=\(contrasenaUno.text!)&correo=\(correoInput.text!)&apellido=\(apellidoInput.text!)"
            //let body = "nombre=\(strFirstName.text!)&correo=\(strEmail.text!)&apellido=\(strLastName.text!)"
            let body = "nombre=\(strFirstName)&facebook_id=\(strIDFacebook)&apellido=\(strLastName)&correo=\(strEmail)"
            print("dentro")
            
            //let body = "nombre=hola&correo=test&apellido=test"
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
                            
                            let id = parseJson["id_usuario"]
                            
                            if id != nil {
                                let preferences = NSUserDefaults.standardUserDefaults()
                                
                                let arrayUsuarioKey = "arrayUsuario"
                                
                                _ = preferences.setObject(parseJson, forKey: arrayUsuarioKey)
                                
                                _ = preferences.synchronize()
                                
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                
                                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeView") as! HomeController
                                self.presentViewController(nextViewController, animated:true, completion:nil)
                            }else{
                                /*
                                 let alerta = UIAlertController(title: "Usuario existente",
                                 message: "Este correo ya existe",
                                 preferredStyle: UIAlertControllerStyle.Alert)
                                 let accion = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                                 alerta.dismissViewControllerAnimated(true, completion: nil)
                                 })
                                 alerta.addAction(accion)
                                 self.presentViewController(alerta, animated: true, completion: nil)
                                 */
                                
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                
                                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeView") as! HomeController
                                self.presentViewController(nextViewController, animated:true, completion:nil)
                            }
                            
                            
                        } catch{
                            print(error)
                        }
                    })
                    
                }else{
                    
                    print(error)
                }
            }).resume()
            
            
            //let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            
            //self.lblName.text = "Welcome, \(strFirstName) \(strLastName)"
            //self.ivUserProfileImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func iniciarSesion(sender: UIButton) {
        print("entro primero")
        if correoInicio.text!.isEmpty || passInicio.text!.isEmpty{
            print("entro aquiq")
            correoInicio.attributedPlaceholder = NSAttributedString(string: "Correo electrónico", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            passInicio.attributedPlaceholder = NSAttributedString(string: "Contraseña", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
        }else{
            print("entro aqui2")
            //let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/iniciarsesion.php")
            let url = NSURL(string: "http://aguitech.com/samemoon/cobradores/iniciarsesion.php")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            let body = "correo=\(correoInicio.text!)&pass=\(passInicio.text!)"
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
                            print(json)
                            let id = parseJson["id_usuario"]
                            
                            if id != nil {
                                let preferences = NSUserDefaults.standardUserDefaults()
                                
                                let arrayUsuarioKey = "arrayUsuario"
                                
                                _ = preferences.setObject(parseJson, forKey: arrayUsuarioKey)
                                
                                _ = preferences.synchronize()
                                
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                
                                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeView") as! HomeController
                                self.presentViewController(nextViewController, animated:true, completion:nil)
                                
                                
                            }else{
                                
                                let alerta = UIAlertController(title: "Datos incorrectos",
                                    message: "Usuario ó Password incorrecto",
                                    preferredStyle: UIAlertControllerStyle.Alert)
                                let accion = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                                    alerta.dismissViewControllerAnimated(true, completion: nil)
                                })
                                alerta.addAction(accion)
                                self.presentViewController(alerta, animated: true, completion: nil)
                            }
                            
                            
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


}
