//
//  DetalleTiendaViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 09/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class DetalleEventoViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    
    
    var idt:Int?
    //var veterinaria:Int?
    //BUSCAR VETERINARIA
    var idevento:Int?

    
    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBOutlet weak var tituloMoonie: UILabel!
    @IBOutlet weak var fechaHoraEvento: UILabel!
    @IBOutlet weak var usuariosInvitados: UILabel!
    /*
     @IBOutlet weak var tituloMoonie: UILabel!
     @IBOutlet weak var fechaHora: UILabel!
     
     @IBOutlet weak var nombreTienda: UILabel!
     @IBOutlet weak var precioTienda: UILabel!
     
    @IBOutlet weak var btnAgregar: UIButton!
    @IBOutlet weak var btnCancelar: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tituloVeterinaria: UILabel!
    @IBOutlet weak var imageTienda: UIImageView!
    
    
    
    @IBOutlet weak var nombreTienda: UILabel!
    @IBOutlet weak var precioTienda: UILabel!
    
    */
    //@IBOutlet weak var nombreTIenda: UILabel!
    //@IBOutlet weak var precioTienda: UILabel!
    var Array:[String: String] = [String: String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        searchBar.backgroundImage = UIImage()
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.grayColor().CGColor
        searchBar.layer.cornerRadius = 20
        
        precioTienda.layer.borderColor = UIColor.grayColor().CGColor
        precioTienda.layer.borderWidth = 1
        precioTienda.layer.cornerRadius = 6
        
        btnCancelar.layer.borderColor = UIColor.grayColor().CGColor
        btnCancelar.layer.borderWidth = 1
        btnCancelar.layer.cornerRadius = 6
        
        btnAgregar.layer.cornerRadius = 6
        
        
        */
        //print(idt);
        print("idEVENTO");
        print(idevento!);
        if (idevento != nil){
            cargarDatos()
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func accederCamara(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
            
            
        }
        
        
        
    }
    @IBAction func guardarFoto(sender: AnyObject) {
        var imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        var compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        var alert = UIAlertView(title: "Wow",
                                message: "Your image has been saved to Photo Library!",
                                delegate: nil,
                                cancelButtonTitle: "Ok")
        alert.show()
    }
    
    
    @IBAction func agregarCarrito(sender: UIButton) {
    }
    
    @IBAction func abrirLibreria(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicked.image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        //self.dismiss(animated:true, completion: nil)
        //dismiss(animated:true, completion: nil)
    }
    func cargarDatos(){
        //let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/tienda.php?idt=\(idt!)")
        //let url = NSURL(string: "http://aguitech.com/samemoon/cobradores/ios_evento_detalle.php")
        //let url = NSURL(string: "http://aguitech.com/samemoon/cobradores/app_tienda.php")
        let url = NSURL(string: "http://aguitech.com/samemoon/cobradores/ios_detalle_evento.php?idevento=\(idevento!)")
        

        //print("\(id_usuario)")
        
        print(url!);
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                //print("errores")
                print(error)
                
            }else{
                //print("dentro X")
                
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    //self.Array = jsonResult as! NSDictionary as! [String : String]
                    //self.Array = jsonResult as! NSArray as! [String : String]
                    self.Array = jsonResult as! NSDictionary as! [String : String]
                    
                    
                    
                    //print(jsonResult);
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.tituloMoonie.text = self.Array["evento"]
                        self.fechaHoraEvento.text = self.Array["fecha"]
                        self.usuariosInvitados.text = self.Array["hora"]
                        
                        //print(self.Array["id_evento"]);
                        
                        /*
                        
                        
                        let imagenPatrocinador = "http://hyperion.init-code.com/zungu/imagen_tienda/\(self.Array["imagen"]!)"
                        
                        if let url = NSURL(string: imagenPatrocinador) {
                            if let data = NSData(contentsOfURL: url) {
                                self.imageTienda.image = UIImage(data: data)
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
}
