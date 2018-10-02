//
//  ViewController.swift
//  Rating Control
//
//  Created by Ilgar Ilyasov on 10/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func updateRating(_ ratingControl: CustomControl) {
        if ratingControl.value == 1 {
            navigationItem.title = "User Rating: 1 star"
        } else {
            navigationItem.title = "User Rating: \(ratingControl.value) stars"
        }
    }
    
}

