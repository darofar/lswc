//
//  WebViewController.swift
//  Pokedex
//
//  Created by Santiago Pavón on 1/12/14.
//  Copyright (c) 2014 UPM. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    // Race a mostrar, o nil para mostrar la pagina Home
    var race: Race?
    

    @IBOutlet weak var webView: UIWebView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // URL a mostrar
        var str: String
        if race != nil {
            
            // Poner nombre de la raza como titulo de la Navigation Bar
            title = race?.name
            
            // Cargar la URL de la raza
            str = "http://es.pokemon.wikia.com/wiki/\(race!.name)"
        } else {
            
            // Poner Pokedex como titulo de la Navigation Bar
            title = "Pokedex"
            
            // Cargar la pagina principal
            str = "http://es.pokemon.wikia.com"
        }
        
        // Escapar caracteres conflictivos
        if let str2 = str.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            
            if let url = NSURL(string: str2) {
                
                let req = NSURLRequest(URL: url)
                
                webView.loadRequest(req)
            }
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
