//
//  ViewController.swift
//  NYTNews
//
//  Created by Владимир Коваленко on 26.02.2021.
//
import UIKit
import SnapKit
import Kingfisher
class NewsListController: UIViewController{
    private var networkService = NetworkService()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .none
        tableView.rowHeight = 100
        tableView.register(NewsListCell.self, forCellReuseIdentifier: NewsListCell.reuseIdentifier)
        return tableView
    }()
    private var results = [News]()
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.delegate = self
        networkService.performRequest()
        view.backgroundColor = .white
        setUpView()
        navigationItem.title = "News"
    }
    private func setUpView(){
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
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListCell.reuseIdentifier, for: indexPath) as! NewsListCell
        let mainTitle = results[indexPath.row].title
        let clearDate = results[indexPath.row].pubDate
        let range = clearDate.index(clearDate.startIndex, offsetBy: 0)..<clearDate.index(clearDate.endIndex, offsetBy: -15)
        let publishDate = clearDate[range]
        let section = results[indexPath.row].section
        let coverUrlString = self.results[indexPath.row].multimedia[0].url
        DispatchQueue.global(qos: .background).async {
            if let coverUrl = URL(string: coverUrlString){
                    DispatchQueue.main.async {
                        cell.cover.kf.setImage(with: coverUrl)
                    }
            }
    }
        cell.mainTitle.text = mainTitle
        cell.publishDate.text = String(publishDate)
        cell.section.text = section
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !tableView.isEditing {
            let vc = DetailController()
            vc.url = results[indexPath.row].url
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
extension NewsListController: NetworkServiceDelegate {
    func didSearch(_ networkService: NetworkService, items: NewsData) {
            DispatchQueue.main.async {
                self.results = items.results
                self.tableView.reloadData()
            }
        }   
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in}
            alertController.addAction(cancel)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

