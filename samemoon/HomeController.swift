//
//  HomeController.swift
//  zungu
//
//  Created by Giovanni Aranda on 02/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit


var tipo:Int = 1

class HomeController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var buscador: UISearchBar!
    @IBOutlet weak var nombrePatrocinio: UILabel!
    @IBOutlet weak var imagenPatrocinio: UIImageView!
    @IBOutlet weak var nombreVeterinario: UILabel!
    @IBOutlet weak var correoPatrocinio: UILabel!
    @IBOutlet weak var telefonoPatrocinio: UILabel!
    
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var buttonVerMas: UIButton!
    @IBOutlet weak var viewMapaLista: UIView!
    @IBOutlet weak var buttonADD: UIButton!
    
    @IBOutlet weak var tableVeterinarias: UITableView!
    //@IBOutlet weak var tableVeterinarias: UITableView!
    var ArrayCount:Int = 0
    var ArrayList:[[String: String]] = [[String: String]]()
    var ArrayPatrocinador:[String: String] = [String: String]()
    var susX = 0
    var tipo:Int = 0
    
    @IBAction func cambiarTipo(sender: UIButton) {
        tipo_ = sender.tag
        
        cargarDatos()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargarDatos()
        // Do any additional setup after loading the view.
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    func cargarDatos(){
        let url = NSURL(string: "http://aguitech.com/samemoon/cobradores/ios_eventos.php?tipo=\(tipo_)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    
                    
                    self.susX = 0
                    if let items = jsonResult as? [[String: String]]{
                        
                        for item in items{
                            self.ArrayList.append((item))
                        }
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.tableVeterinarias.reloadData()
                        return
                    })
                    
                }
            }
        }
        
        task.resume()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.ArrayList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableVeterinarias.dequeueReusableCellWithIdentifier("CellEventos", forIndexPath: indexPath) as! MealTableViewCell
        
        var titulo:String
        var subtitulo:String
        var km:String
        if ArrayList.count == 0{
            titulo = "Sin Nombre"
            subtitulo = "Subtitulo"
            km = "0km"
        }else{
            
            titulo = String(ArrayList[susX]["evento"]!)
            subtitulo = String(ArrayList[susX]["fecha"]!)
            km = "2km"
            
            
        }
        
        cell.titleLabel?.text = titulo
        cell.doctorLabel?.text = subtitulo
        cell.kmLabel?.text = km
        
        susX += 1
        
        if self.susX == self.ArrayList.count
        {
            susX = 0
        }
        
        return cell
    }
    
    
    @IBAction func goDetalle(sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("DetalleEvento") as! DetalleEventoViewController
        nextViewController.idevento = Int(ArrayPatrocinador["id_evento"]!)!
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("DetalleEvento") as! DetalleEventoViewController
        nextViewController.idevento = Int(ArrayList[indexPath.row]["id_evento"]!)!
        self.presentViewController(nextViewController, animated:true, completion:nil)
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
