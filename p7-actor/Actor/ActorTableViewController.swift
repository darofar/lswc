//
//  ActorTableViewController.swift
//  Actor
//
//  Created by Javier De La Rubia on 27/5/15.
//  Copyright (c) 2015 Javier De La Rubia. All rights reserved.
//

import UIKit

private let API_URL = "http://www.myapifilms.com/imdb"

class ActorTableViewController: UITableViewController {
    
    var name = ""
    
    var idIMDB : String!
    
    var actor = [String:AnyObject]()
    var filmography = [AnyObject]()
    
    var images = [String:UIImage]()
    
    
    // URL Session para descargar datos
    var session: NSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config)
        getFilmography()
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section:    Int) -> String{
        return filmography[section]["section"] as! String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        images = [:] //liberamos memoria de imagenes, que es lo que realmente consume.
    }
    
    
    private func getFilmography() {
        
        // Construye la query que hay que añadir a la URL.
        // Con esta query solo se bajan 10 actores.
        if let pageURL = "\(API_URL)?idName=\(idIMDB)&lang=es-es&filmography=1".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            
            // Descargamos un JSON con los datos.
            if let url = NSURL(string: pageURL) {
                
                self.title = "Buscando ..."
                incrNetActivity()
                
                let task = session.dataTaskWithURL(url) {(data: NSData!, res: NSURLResponse!, error: NSError!) in
                    dispatch_async(dispatch_get_main_queue(), {
                        if error == nil && (res as! NSHTTPURLResponse).statusCode == 200 {
                            // Extraer el array de datos del JSON
                            var err: NSError?
                            if let result = NSJSONSerialization.JSONObjectWithData(data, options: .allZeros, error: &err) as? [String:AnyObject] {
                                //para debug del JSON
                                //println(result)
                                self.actor = result
                                if (self.actor["filmographies"] != nil) {
                                self.filmography = self.actor["filmographies"] as! [AnyObject]
                                }
                                self.tableView.reloadData()
                            }
                            self.title = self.name
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
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Film Cell", forIndexPath: indexPath) as! FilmCell
        
        if let dic = filmography[indexPath.section] as? [String: AnyObject] {
            if let films = dic["filmography"] as? [AnyObject] {
                if let film = films[indexPath.row]["title"] as? String {
                    cell.title!.text = film;
                }
                if let year = films[indexPath.row]["year"] as? String {
                    cell.year!.text = year;
                }
                
                
                
                if let idIMDB = films[indexPath.row]["IMDBId"] as? String {
                    if let image = images[idIMDB] {
                        cell.poster.image = image;
                    } else {
                        
                        if let urlFilm = "\(API_URL)?idIMDB=\(idIMDB)&lang=es-es&moviePhotos=P".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
                            
                            if let url = NSURL(string: urlFilm) {
                                let task = session.dataTaskWithURL(url) {
                                    (data: NSData!, res: NSURLResponse!, error: NSError!) in
                                    if error == nil && (res as! NSHTTPURLResponse).statusCode == 200 {
                                        
                                        var err: NSError?
                                        
                                
                                        if let result = NSJSONSerialization.JSONObjectWithData(data, options: .allZeros, error: &err) as? [String:AnyObject] {
                                            //para debug del JSON
                                            //println(result)
                                            
                                            
                                            if let urlPoster = result["urlPoster"] as? String {
                                                
                                                if let urlpos = NSURL(string: urlPoster) {
                                                    
                                                    
                                                    let taskPic = self.session.dataTaskWithURL(urlpos) {(data: NSData!, res: NSURLResponse!, error: NSError!) in
                                                        if error == nil && (res as! NSHTTPURLResponse).statusCode == 200 {
                                                            if let newImage = UIImage(data: data) {
                                                                dispatch_async(dispatch_get_main_queue(), {
                                                                    // Guardar la imagen
                                                                    self.images[idIMDB] = newImage
                                                                    
                                                                    // Poner la nueva imagen en la fila de la tabla y actualizar la tabla
                                                                    if let cellt = self.tableView.cellForRowAtIndexPath(indexPath) as? FilmCell {
                                                                        cellt.poster.image = newImage;
                                                                        
                                                                    }
                                                                })
                                                            }
                                                            
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), {
                                                            self.decrNetActivity()
                                                        })
                                                    }
                                                    
                                                    
                                                    self.incrNetActivity()
                                                    taskPic.resume()
                                                }
                                                
                                            }
                                            
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
                    }
                } else {
                }
            }
            
            
        }
        return cell
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filmography.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmography[section]["filmography"]!!.count
    }
    
    
    
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