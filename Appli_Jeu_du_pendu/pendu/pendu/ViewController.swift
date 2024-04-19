//
//  ViewController.swift
//  pendu
//
//  Created by Finaritra Randriamitandrina on 19/03/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let b = sender as! UIButton
        print("Vous avez cliqué sur le bouton \(b.tag)")
        let d = segue.destination as! PenduViewController//désigner le controller destination
        d.niveau = b.tag //on définit le niveau de jeu avec l'étiquette du bouton qui a été cliqué (1,2 ou3)
    }


}

