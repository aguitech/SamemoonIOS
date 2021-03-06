//
//  PagoSPEIViewController.swift
//  zungu
//
//  Created by Hector Aguilar on 19/10/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//


import UIKit



class PagoSPEIViewController: UIViewController, UINavigationControllerDelegate {
    /*
    @IBOutlet weak var nombreTarjeta: UITextField!
    @IBOutlet weak var numeroTarjeta: UITextField!
    @IBOutlet weak var cantidadPago: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var cvvTarjeta: UITextField!
    @IBOutlet weak var mesTarjeta: UITextField!
    @IBOutlet weak var anioTarjeta: UITextField!
    @IBOutlet weak var pais: UITextField!
    @IBOutlet weak var estado: UITextField!
    @IBOutlet weak var codigoPostal: UITextField!
 */
    
    @IBOutlet weak var pais: UITextField!
    
    
    @IBOutlet weak var estado: UITextField!
    @IBOutlet weak var codigoPostal: UITextField!
    
    
    let id_usuario = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func guardarSPEI(sender: UIButton) {
        if(pais.text!.isEmpty || estado.text!.isEmpty || codigoPostal.text!.isEmpty) {
            print("entroerror")
            pais.attributedPlaceholder = NSAttributedString(string: "PAIS", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            estado.attributedPlaceholder = NSAttributedString(string: "ESTADO", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
            codigoPostal.attributedPlaceholder = NSAttributedString(string: "CP", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            
        }else{
            print("entro");
            let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/agregar_spei.php")
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
            
            let body = "id_usuario=\(id_usuario)&pais=\(pais.text!)&estado=\(estado.text!)&codigoPostal=\(codigoPostal.text!)"
            
            
            
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
