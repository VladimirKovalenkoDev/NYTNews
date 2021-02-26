//
//  ViewController.swift
//  NYTNews
//
//  Created by Владимир Коваленко on 26.02.2021.
//

import UIKit
import SnapKit
class NewsListController: UIViewController{
    private var networkService = NetworkService()
    private let tableView = UITableView()
    var results = [News]()
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.delegate = self
        networkService.performRequest()
        view.backgroundColor = .white
        setUpView()
        navigationItem.title = "News"
    }
    private func setUpView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .none
        tableView.register(NewsListCell.self, forCellReuseIdentifier: NewsListCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(88)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
extension NewsListController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListCell.reuseIdentifier, for: indexPath)
        let text = results[indexPath.row].short_url
        cell.textLabel?.text = text
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !tableView.isEditing {
            let vc = DetailController()
            vc.titlee = "somth"
            navigationController?.pushViewController(vc, animated: true)
        } else if tableView.indexPathsForSelectedRows != nil {
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = .none
        if tableView.indexPathsForSelectedRows == nil {
            navigationItem.leftBarButtonItem?.isEnabled = false
        }
    }
    
    
}
extension NewsListController: SearchManagerDelegate{
    func didSearch(_ searchManager: NetworkService, searchItems: NewsData) {
        DispatchQueue.main.async {
            self.results = searchItems.results
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
