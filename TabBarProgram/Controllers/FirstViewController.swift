//
//  FirstViewController.swift
//  TabBarProgram
//
//  Created by Miguel Vega on 22/10/21.
//

import UIKit

class FirstViewController: UIViewController {
  
  struct Constants {
    static let postsURL = URL(string: "https://jsonplaceholder.typicode.com/posts")
  }
  
  let searchVC = UISearchController()
  let tableView = UITableView()
  
  private var posts: [Post] = []
  private var filteredPost: [Post] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    view.addSubview(tableView)
    title = "Home"
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.delegate = self
    tableView.dataSource = self
    
    searchVC.searchResultsUpdater = self
    searchVC.searchBar.placeholder = "Search posts"
    searchVC.obscuresBackgroundDuringPresentation = true
    //    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.searchController = searchVC
    
    fetch()
    
    var isSearchBarEmpty: Bool {
      return searchVC.searchBar.text?.isEmpty ?? true
    }
  }
  
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  func fetch() {
    URLSession.shared.request(url: Constants.postsURL, expecting: [Post].self) { result in
      switch result {
        case .success(let posts):
          DispatchQueue.main.async {
            self.posts = posts
            self.tableView.reloadData()
          }
        case .failure(let error):
          print(error)
      }
    }
  }
  
}


extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = posts[indexPath.row].title
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    print(posts[indexPath.row].title)
    let vc = FeaturesViewController()
    vc.title = posts[indexPath.item].title
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
}


extension FirstViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let text = searchController.searchBar.text else {
      return
    }
    print(text)
  }
  
}

extension URLSession {
  
  enum CustomError: Error {
    case invalidUrl
    case invalidData
  }
  
  func request<T:Codable>(
    url: URL?,
    expecting: T.Type,
    completion: @escaping (Result<T, Error>) -> Void) {
      guard let url = url else {
        completion(.failure(CustomError.invalidUrl))
        return
      }
      let task = dataTask(with: url) { data, _, error in
        guard let data = data else {
          if let error = error {
            completion(.failure(error))
          } else {
            completion(.failure(CustomError.invalidData))
          }
          return
        }
        
        do {
          let result = try JSONDecoder().decode(expecting, from: data)
          completion(.success(result))
        } catch {
          completion(.failure(error))
        }
        
      }
      task.resume()
    }
}
