//
//  ViewController.swift
//  IGImageCropper
//
//  Created by Arshad on 09/14/2021.
//  Copyright (c) 2021 Arshad. All rights reserved.
//

import UIKit
import IGImageCropper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showCropper(_ sender: Any) {
        
        let im = UIImage(named: "22_l",
                         in: Bundle(for: type(of:self)),
                         compatibleWith: nil)!
        let myViewController = IGCropViewController(image: im, cropInfo: nil)
        self.navigationController?.pushViewController(myViewController, animated: true)
    }
}

