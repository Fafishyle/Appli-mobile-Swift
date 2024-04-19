//
//  PenduViewController.swift
//  pendu
//
//  Created by Finaritra Randriamitandrina on 19/03/2024.
//

import UIKit

class PenduViewController: UIViewController {
    
    
    var mots : [String] = [ //tableau de mot à faire deviner
        "ORDINATEUR" ,
        "BANANE" ,
        "POUSSIN",
        "GUITARE",
        "FLUTE"
    ]
    var secret : String = ""
    var first = 0 , last = 0 // premier et dernier charactere du mot caché

    var lettresATrouver = 0 //nombre de lettre à trouver
    var etape = 0 //numero d'étape
    
    var niveau = 1 //niveau de jeu par défaut

    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var vignette: UIImageView! //l'image principal
    @IBOutlet weak var mot: UILabel! //l'affichage du mot
    @IBOutlet var boutons: [UIButton]!
    
    func finPartie(_ chaine: String) { //pas de valeur de retour
        message.text = chaine
        for b in boutons{//pour tout les bouton
            b.isEnabled = false //désactive le bouton b du clavier à la fin de partie
        }
    }
    
    @IBAction func clic(_ sender: UIButton) { //le bouton clavier
        let lettre = sender.titleLabel!.text! //Attention! meme si elle n'est composée que d'1 seule lettre, c'est quand même un string
        print("la  lettre \(lettre) a été cliqué")
        sender.isEnabled = false // il n'est plus cliquable car on a déjà cliqué dessus
        var motCache : [Character] = [] //convertir mot (affiché sur écran) en tableau de charactere pour faciliter les indices
        var trouve : Bool = false // vrai si la lettre cliqué est présent dans le mot caché
        for l in mot.text! {
            motCache.append(l) //converesion character
        }
        var i = 0
        //for(i,l) in secret.enumerated() ou on peut faire i = clef et l est valeur
        for l in secret{
            if i < first || i > last { //on saute le cas où des lettres sont déjà dévoilé :: le first et last
                i += 1
                continue
            }
            if lettre == String(l) { //la lettre du mot secret est égale à la lettre tapée
                motCache[i] = l // on devoile la lettre courante
                trouve = true //trouver une occurence de la lettre
                print("Vous avez cliqué sur une bonne lettre !")
                lettresATrouver -= 1 //On décrémente le nombre de lettre à trouver
                if lettresATrouver == 0 {
                    print("Vous avez gagné !")
                    finPartie("GAGNE !")
                }
                
            }
            i += 1
        }
        if !trouve{ //la lettre est absente du mot secret
            etape+=1
            print("on passe à l'étape du gibet de potence")
            vignette.image = UIImage(named: "pendu\(etape)") //Constructeur d'image
            if etape == 11 {
                print("Vous avez perdu !")
                finPartie("PERDU !")
                
                
            }
        }
        mot.text = ""
        // Pour réafficher sur l'écran
        for l in motCache{
            mot.text! += String(l)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("le niveau de jeu est \(niveau)")
        secret = mots.randomElement()! // mot à faire deviner au hasard
        print("Le mot secret est \(secret)")
        mot.text = "" //on efface le mot caché
        switch niveau {
        case 1 : first = 1 ; last = secret.count - 2
        case 2 : first = 1 ; last = secret.count - 1
        case 3 : first = 0 ; last = secret.count - 1
        default: break
        }
        var i = 0
        for l in secret { //on parcourt toute les lettres du mot secret
            
            //gestion de la difficutlé du mot : on affiche la lettre ou non
            if i >= first && i <= last{
                mot.text! += "-" // on remplace la lettre l par un trait
            }
            else{
                mot.text! += String(l)
            }
            i += 1
        }
        lettresATrouver = last - first + 1
        print ("Le nombre de lettre à deviner est \(lettresATrouver)")

        // Do any additional setup after loading the view.
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
