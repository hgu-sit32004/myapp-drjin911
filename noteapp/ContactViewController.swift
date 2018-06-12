//
//  ContactViewController.swift
//  noteapp
//
//  Created by student24 on 2018. 5. 8..
//  Copyright © 2018년 student24. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       
        scrollView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
        
        
        scrollView.contentSize = CGSize(width: 768, height: 1500)
    }
}
