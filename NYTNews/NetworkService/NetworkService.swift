//
//  NetworkService.swift
//  NYTNews
//
//  Created by Владимир Коваленко on 26.02.2021.
//

import Foundation
protocol NetworkServiceDelegate {
    func didSearch(_ networkService : NetworkService, items: NewsData)
    func didFailWithError (error: Error )
}
struct NetworkService {
    private let url = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key="
    private let api = "vGSpbl3YoujqnGKPnYn3d4QFb3PID4VA"
    public var delegate : NetworkServiceDelegate?
    public func performRequest(){
            // create url
            let urlString = "\(url)\(api)"
            if let url = URL(string: urlString) {// it is optional cos it can be an error
              // create url session
                let session = URLSession(configuration: .default)
                // GIVE THE session a task
                let task = session.dataTask(with: url) { (data, response, error) in
                       if error != nil {
                        self.delegate?.didFailWithError(error: error!)
                             return
                         }
                         if let safeData = data {
                            if  let items = self.parseJSON(safeData){
                               self.delegate?.didSearch(self , items: items)
                            }
                         }
                     }
                // start the task
                task.resume()
                }

            }
   private  func parseJSON(_ searchData: Data) -> NewsData? {
            let decoder = JSONDecoder()// create decoder
            do {
                //decoding
          let decodeData = try decoder.decode(NewsData.self, from: searchData)
                let results = decodeData.results
                let searchItems  = NewsData(results: results)
                return searchItems
            }catch{
               delegate?.didFailWithError(error: error)
                return nil
                }
            }
}
        


