//
//  NewsData.swift
//  NYTNews
//
//  Created by Владимир Коваленко on 26.02.2021.
//

import Foundation
struct NewsData: Codable {
    let results: [News]
}
struct News: Codable {
    enum CodingKeys:  String, CodingKey{
        case url
        case title
        case section
        case pubDate = "published_date"
        case multimedia
    }
    let url: String
    let title: String
    let section: String
    let pubDate: String
    let multimedia : [Multimedia]
}
struct Multimedia: Codable {
    let url: String
    let format: String
}
