//
//  TestResponderViewController.swift
//  AZLExtendExampleSwift
//
//  Created by lizihong on 2021/9/1.
//  Copyright © 2021 azusalee. All rights reserved.
//

import UIKit

class TestResponderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let button = UIButton.init(frame: self.view.bounds)
        button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    
    @objc
    func buttonDidTap(_ sender:UIButton) {
        var nextResponder:UIResponder? = sender
        while nextResponder != nil {
            print(nextResponder)
            nextResponder = nextResponder?.next
        }
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
