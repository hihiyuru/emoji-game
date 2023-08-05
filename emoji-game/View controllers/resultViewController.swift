//
//  resultViewController.swift
//  emoji-game
//
//  Created by 徐于茹 on 2023/8/5.
//

import UIKit

class resultViewController: UIViewController {
    
    var heartsAcount: Int!

    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        showResult()
        
    }
    
    func showResult() {
        if heartsAcount > 0 {
            resultImageView.image = UIImage(named: "win")
            resultLabel.text = "LEVEL UP"
        } else {
            resultImageView.image = UIImage(named: "lose")
            resultLabel.text = "You LOSE!"
        }
    }
}
