//
//  JeuViewController.swift
//  Tri
//
//  Created by Finaritra Randriamitandrina on 05/03/2024.
//

import UIKit

class JeuViewController: UIViewController {
    var objetTouch = -1
    var poubelleSurvol = -1 //numéro (tag) de la poubelle survolée
    var positionDepart = CGPoint(x:0,y:0) //coordonées de départ de l'objet touché
    var nombreDechetARanger = 0 //nombre de dechet à ranger. ATTENTION il est initialisé dans le viewDidload()
    
    @IBOutlet var déchets: [UIImageView]!
    
    @IBOutlet var poubelles: [UIImageView]!
    
   
    //premier contact
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t = touches.randomElement()! //touches est un genre de Set qui est l'équivalent d'un Array
        let p = t.location(in: view) // la position du touch sur la vue d'ensemble "view"
        print("Vous avez touchez le point x=\(p.x) et y=\(p.y)")
        var i = 0
        for d in déchets {
            if d.frame.contains(p){
              print("Vous avez touché l'objet numéro \(i)")
                objetTouch = i //On mémorise le numéro de l'objet touché
                positionDepart = d.center //on mémorise la position de départ de l'objet (pour quand il retourne au point de départ)
                return //On quitte la fonction quand on touche 1 objet
            }
            i += 1
        }
        objetTouch = -1 //On a fait toute la boucle, aucun objet n'a été touché
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t = touches.randomElement()!
        let p = t.location(in: view)
        if objetTouch == -1 { // Si aucun objet touché
            return
        }
        déchets[objetTouch].center = p //on déplace l'objet pour lui faire suivre le doigt = c'est le centre de l'objet qui se place sur le p (doigt)
        
        // Si le doigt survole la poubelle, la poubelle passe à l'état highlighted
        for g in poubelles {
            if g.frame.contains(p){
                g.isHighlighted = true
                poubelleSurvol = g.tag
                return
            } else {
                g.isHighlighted = false
                poubelleSurvol = -1
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //si aucun objet touché, on fait rien
        if objetTouch == -1 { //si on ne touche pas d'objet
            return
        }
        if poubelleSurvol == -1 { //si on ne survole pas de poubelle
            déchets[objetTouch].center = positionDepart
            return
        }
        if déchets[objetTouch].tag == poubelles[poubelleSurvol].tag {
            //si on est dans la bonne poubelle
            déchets[objetTouch].isHidden = true //On fait disparaitre l'objet
            poubelles[poubelleSurvol].isHighlighted = false
            nombreDechetARanger -= 1 //on a 1 dechet de moins à ranger
            //si on a finit de trier
            if nombreDechetARanger == 0 {
                // L'alerte bravo reussie
                let alert = UIAlertController(title: "bravo", message: "Vous avez trié tous les objets", preferredStyle: .alert)
                alert.addAction(UIAlertAction(
                    title: NSLocalizedString("OK", comment: "Default action"),
                    style: .default,
                    handler: { _ in
                        print("Le jeu est fini") //Code effectué quand on clique sur le bouton
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            // Si c'est pas la bonne poubelle
            déchets[objetTouch].center = positionDepart
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nombreDechetARanger = déchets.count
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
