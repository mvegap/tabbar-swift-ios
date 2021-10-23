//
//  SecondViewController.swift
//  TabBarProgram
//
//  Created by Miguel Vega on 22/10/21.
//

import UIKit

class SecondViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "About"
  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.navigationBar.prefersLargeTitles = true
  }

  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.navigationBar.prefersLargeTitles = false
  }
  
}
