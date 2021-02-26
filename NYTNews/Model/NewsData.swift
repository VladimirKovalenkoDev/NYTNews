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
    let short_url: String
}
