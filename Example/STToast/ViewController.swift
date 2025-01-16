//
//  ViewController.swift
//  STToast
//
//  Created by cnjsyyb on 01/16/2025.
//  Copyright (c) 2025 cnjsyyb. All rights reserved.
//

import UIKit
import STToastKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var config = StonkToastConfiguration.default()
        config.title = "title"
        config.subtitle = "23222323232323232434354546655665778888883232324343545466556657788888888323232434354546655665778888888832323243435454665566577888888883232324343545466556657788888888323232434354546655665778888888832323243435454665566577888888888888888"
//        config.timeTitle = "DEC 1"
        StonkToast(config: config).show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

