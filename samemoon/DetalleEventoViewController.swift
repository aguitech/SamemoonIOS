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
    
    var id_usuario = 0
    
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
    
    let preferences = NSUserDefaults.standardUserDefaults()
    let currentLevelKey = "arrayUsuario"
    
    
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
        if preferences.objectForKey(currentLevelKey) == nil {
        } else {
            let array_usuario = preferences.objectForKey(currentLevelKey)
            
            id_usuario = (array_usuario!["id_usuario"]!!.integerValue)!
        }
        
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
    
    @IBAction func tomarFotillo(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
            
            
            
            if (self.imagePicked.image == nil || imagePicked.image == nil){
                print("Doesn’t contain a value.")
                
                
            } else {
                
                print("test")
                
                var imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
                var compressedJPGImage = UIImage(data: imageData!)
                UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
                
                var alert = UIAlertView(title: "Wow",
                                        message: "Your image has been saved to Photo Library!",
                                        delegate: nil,
                                        cancelButtonTitle: "Ok")
                alert.show()

            
                print("Si existe.")
            }
            
            
            
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
    
    
    @IBAction func agregarFoto(sender: AnyObject) {
        if id_usuario == 100{
            //if nombreMascota.text!.isEmpty || edadRaza.text!.isEmpty || descripcionAdopta1.text!.isEmpty || ubicacionMazcota.text!.isEmpty || nombreContacto.text!.isEmpty || numeroContacto.text!.isEmpty || correoContacto.text!.isEmpty {
            print("entroerror")
            
            
        }else{
            
            print(id_usuario);
            print(idevento);
            
            
            var bodyGet = "id_usuario=\(id_usuario)&id_evento=\(idevento!)"
            bodyGet = bodyGet.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
            
            //let _params: String = "prueba=algo"
            //let _url: String = "http://hyperion.init-code.com/zungu/app/mascota_adoptar.php"
            let _url: String = "http://aguitech.com/samemoon/cobradores/app_guardar_foto.php"
            let myUrl = NSURL(string:"\(_url)?\(bodyGet)")!
            let request = NSMutableURLRequest(URL:myUrl)
            request.HTTPMethod = "POST";
            
            
            let param = [
                "nuevo": "asd",
                "id_usuario": "dsadsa",
                "id_evento": "dsadsa"
                
            ]
            /*
             let param = [
             "nombre"  : self.nombreMascota.text!,
             "edad"    : self.edadRaza.text!,
             "ubicacion" : self.ubicacionMazcota.text!,
             "id_usuario": id_usuario,
             "nombre_usuario": nombreContacto.text!,
             "numero_usuario": numeroContacto.text!,
             "correo_usuario": correoContacto.text!
             ]
             */
            
            let boundary = generateBoundaryString()
            
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let imageData = UIImageJPEGRepresentation(resizeImage(self.imagePicked.image!), 1)
            
            if(imageData==nil)  { return; }
            
            request.HTTPBody = createBodyWithParameters(param as? [String : String], filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
            
            
            SwiftLoading().showLoading()
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                // You can print out response object
                print("******* response = \(response)")
                
                // Print out reponse body
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("****** response data = \(responseString!)")
                
                do {
                    //let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
                    
                    //print(json)
                    SwiftLoading().hideLoading()
                    dispatch_async(dispatch_get_main_queue(),{
                        SwiftLoading().hideLoading()
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        
                        //let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("MascotaAgregada") as! MascotaAgregadaViewController
                        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeView") as! HomeController
                        self.presentViewController(nextViewController, animated:false, completion:nil)
                    });
                    
                }catch
                {
                    print(error)
                }
                
            }
            
            task.resume()
            
        }
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
        
        
        
        
        
        
        if (self.imagePicked.image == nil || imagePicked.image == nil){
            print("No Existe.")
            
            
        } else {
            
            print("Si existe")
            
            var imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
            var compressedJPGImage = UIImage(data: imageData!)
            UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
            
            var alert = UIAlertView(title: "Wow",
                                    message: "Your image has been saved to Photo Library!",
                                    delegate: nil,
                                    cancelButtonTitle: "Ok")
            alert.show()
            
            
            print("Si existe.")
        }
        
        
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
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        let random = arc4random_uniform(1000000) + 1
        let filename = "foto\(random).jpg"
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    func resizeImage(image:UIImage) -> UIImage
    {
        var actualHeight:Float = Float(image.size.height)
        var actualWidth:Float = Float(image.size.width)
        
        let maxHeight:Float = 1000.0 //your choose height
        let maxWidth:Float = 1000.0  //your choose width
        
        var imgRatio:Float = actualWidth/actualHeight
        let maxRatio:Float = maxWidth/maxHeight
        
        if (actualHeight > maxHeight) || (actualWidth > maxWidth)
        {
            if(imgRatio < maxRatio)
            {
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            }
            else if(imgRatio > maxRatio)
            {
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            }
            else
            {
                actualHeight = maxHeight;
                actualWidth = maxWidth;
            }
        }
        
        let rect:CGRect = CGRectMake(0.0, 0.0, CGFloat(actualWidth) , CGFloat(actualHeight) )
        UIGraphicsBeginImageContext(rect.size)
        image.drawInRect(rect)
        
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData:NSData = UIImageJPEGRepresentation(img, 0.8)!
        UIGraphicsEndImageContext()
        
        return UIImage(data: imageData)!
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
