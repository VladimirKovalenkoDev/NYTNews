//
//  NewsListCell.swift
//  NYTNews
//
//  Created by Владимир Коваленко on 27.02.2021.
//

import UIKit
import SnapKit
class NewsListCell: UITableViewCell {
static let reuseIdentifier = "NewsListCell"
    public var mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Main title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    public var publishDate: UILabel = {
        let label = UILabel()
        label.text = "publish date"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    public var section: UILabel = {
        let label = UILabel()
        label.text = "section"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    public var cover: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpElements()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpElements(){
        addSubview(mainTitle)
        addSubview(publishDate)
        addSubview(section)
        addSubview(cover)
        cover.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        mainTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(cover.snp.right).offset(8)
            make.right.equalToSuperview()
        }
        section.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(78)
            make.left.equalTo(cover.snp.right).offset(8)
        }
        publishDate.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(78)
            make.right.equalToSuperview()
        }
    }
}
