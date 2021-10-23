//
//  ViewController.swift
//  TabBarProgram
//
//  Created by Miguel Vega on 22/10/21.
//

import UIKit

class ViewController: UIViewController {
  
  private let button: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 260, height: 52))
    button.setTitle("Get started", for: .normal)
    button.backgroundColor = .systemBackground
    button.setTitleColor(.label, for: .normal)
    button.layer.cornerRadius = 6
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .systemBlue
    view.addSubview(button)
    button.addTarget(self,
                     action: #selector(didTapButton),
                     for: .touchUpInside)
  }
  
  @objc func didTapButton() {
    let tabBarVC = UITabBarController()
    
    let vc1 = UINavigationController(rootViewController: FirstViewController())
    let vc2 = UINavigationController(rootViewController: SecondViewController())
    let vc3 = UINavigationController(rootViewController: ThirdViewController())
    let vc4 = UINavigationController(rootViewController: FourthViewController())
    let vc5 = UINavigationController(rootViewController: FifthViewController())
    
    vc1.title = "Home"
    vc2.title = "About"
    vc3.title = "Services"
    vc4.title = "Portfolio"
    vc5.title = "Settings"
    
    tabBarVC.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
    
    guard let items = tabBarVC.tabBar.items else {
      return
    }
    
    let images = ["house", "bell", "person.circle", "star", "gear"]
    
    for x in 0..<items.count {
      items[x].image = UIImage(systemName: images[x])
    }
    
    tabBarVC.modalPresentationStyle = .fullScreen
    present(tabBarVC, animated: true, completion: nil)
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    button.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height - 52 / 2 - 35)
  }
  
}

