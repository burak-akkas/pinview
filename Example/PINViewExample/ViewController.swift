//
//  ViewController.swift
//  PINViewExample
//
//  Created by Burak Akkas on 4.05.2018.
//  Copyright © 2018 Burak Akkas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pinView: PINView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set the delegate
        pinView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Focus to keyboard
        pinView.focus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - PINView delegate
extension ViewController: PINViewDelegate {
    func PINChanged(to string: String) {
        debugPrint("PIN changed to", string)
    }
    
    func PINFilled(with string: String) {
        debugPrint("PIN filled with", string)
    }
}
