//
//  ActorPreviewTableViewController.swift
//  Actor
//
//  Created by Danny Fonseca on 27/5/15.
//  Copyright (c) 2015 Javier De La Rubia. All rights reserved.
//

import UIKit

private let API_URL = "http://www.myapifilms.com/imdb"

class ActorPreviewTableViewController: UITableViewController {
    
    // Parametro de entrada: el nombre del actor/actriz a buscar
    var actorSearchTerm: String!
    
    // Array con la info de actores encontrada tras la busqueda.
    var actors = [AnyObject]()
    
    // Almacen de images de actores.
    // La clave es un String con el URL, y el valor es un objeto UIImage.
    var images = [String:UIImage]()
    
    // URL Session para descargar datos
    var session: NSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if actorSearchTerm == nil {
            actorSearchTerm = "Harrison"
        }
        
        var config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config)

        
        
        getActorsWithOffset(0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        images = [:] //liberamos memoria de imagenes, que es lo que realmente consume.
    }
    
    // MARK: - Descargar info de actores
    
    private func getActorsWithOffset(offset: Int) {
        
        // Construye la query que hay que añadir a la URL.
        // Con esta query solo se bajan 10 actores.
        if let pageURL = "\(API_URL)?name=\(actorSearchTerm)&limit=10&offset=\(offset)&lang=es-es".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            
            // Descargamos un JSON con los datos.
            if let url = NSURL(string: pageURL) {
                
                self.title = "Buscando ..."
                incrNetActivity()
                
                let task = session.dataTaskWithURL(url) {(data: NSData!, res: NSURLResponse!, error: NSError!) in
                    dispatch_async(dispatch_get_main_queue(), {
                        if error == nil && (res as! NSHTTPURLResponse).statusCode == 200 {
                            // Extraer el array de datos del JSON
                            var err: NSError?
                            if let result = NSJSONSerialization.JSONObjectWithData(data, options: .allZeros, error: &err) as? [AnyObject] {
                                //para debug del JSON
                                //println(result)
                                self.actors += result
                                self.tableView.reloadData()
                                // Mientras sea un array sigo bajando paginas.
                                self.getActorsWithOffset(offset + 10)
                            }
                            self.title = self.actorSearchTerm
                        } else {
                            self.title = "Error en la conexión"
                        }
                        self.decrNetActivity()
                    })
                }
                task.resume()
                return
            }
        }
        self.title = "Error en el termino de búsqueda"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Actor Preview Cell", forIndexPath: indexPath) as! ActorPreviewCell
        
        cell.actorNameLabel.text = ""
        cell.bioLabel.text = ""
        cell.actorImage.image = nil
        
        
        if let dic = actors[indexPath.row] as? [String:AnyObject] {
            if let name = dic["name"] as? String {
                cell.actorNameLabel.text = name
            }
            if let bio = dic["bio"] as? String {
                cell.bioLabel.text = bio
            }
            if let urlPhoto = dic["urlPhoto"] as? String {
                if let image = images[urlPhoto] {
                    cell.actorImage.image = image
                } else {
                    if let url = NSURL(string: urlPhoto) {
                        let task = session.dataTaskWithURL(url) {(data: NSData!, res: NSURLResponse!, error: NSError!) in
                            if error == nil && (res as! NSHTTPURLResponse).statusCode == 200 {
                                if let newImage = UIImage(data: data) {
                                    dispatch_async(dispatch_get_main_queue(), {
                                        // Guardar la imagen
                                        self.images[urlPhoto] = newImage
                                        
                                        // Poner la nueva imagen en la fila de la tabla y actualizar la tabla
                                        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? ActorPreviewCell {
                                            cell.actorImage.image = newImage;
                                        }
                                    })
                                }
                            }
                            dispatch_async(dispatch_get_main_queue(), {
                                self.decrNetActivity()
                            })
                        }
                        incrNetActivity()
                        task.resume()
                    }
                }
            } else {
                //agregar una foto nuestra. una ?
            }
        }
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Show an Actor" {
            if let aptvc = segue.destinationViewController as? ActorTableViewController {
                if let row = tableView.indexPathForCell(sender as! UITableViewCell)?.row {
                    aptvc.idIMDB  = (actors[row]["idIMDB"] as? String)!
                    aptvc.name = (actors[row]["name"] as? String)!
                }
            }
            
        }         
    }
    
    
    // MARK: - Network Activity
    
    /**
    *  Contador usado para saber cuantas veces hemos ejecutado:
    *    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    *  Esta sentencia activa el indicador de actividad en la red.
    *  Mientras este contador sea mauor que cero no pararemos el indicador.
    */
    private var netActivityCredit = 0
    
    /**
    *  Activa el indicador de actividad de red.
    */
    private func incrNetActivity() {
        ++netActivityCredit
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    /**
    *  Desactiva el indicador de actividad de red.
    */
    private func decrNetActivity() {
        --netActivityCredit
        if netActivityCredit < 1 {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }

}
