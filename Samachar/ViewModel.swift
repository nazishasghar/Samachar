//
//  ViewModel.swift
//  Samachar
//
//  Created by Nazish Asghar on 24/06/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let call = try? newJSONDecoder().decode(Call.self, from: jsonData)

import Foundation

// MARK: - Call
struct News: Codable ,Hashable{
    var articles: [Article]
}

// MARK: - Article
struct Article: Codable,Hashable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?

}

// MARK: - Source
struct Source: Codable ,Hashable{
    let id: String?
    let name: String
}



class NetworkCall : ObservableObject{
    
    @Published var headlineItems = [Article]()
    @Published var country : String = "in"
    @Published var query : String = "apple"
    @Published var searchItem = [Article]()
}
extension NetworkCall {
   
    func fetchHeadline() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=610f3044f4c54d95b5f807c9c7233a2c") else {
            print("Invalid")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(News.self, from: data)
                    DispatchQueue.main.async {
                        self.headlineItems = result.articles
                    }
                    print("got data")
                }
                else{
                    print("")
                }
            } catch (let error) {
                print(error)
            }
        }.resume()
    }
}

extension NetworkCall {
    func searchNews() {

        guard let url = URL(string: "https://newsapi.org/v2/everything?q=\(query)&apiKey=610f3044f4c54d95b5f807c9c7233a2c") else {
            print("Invalid")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            do{
                if let data =  data {
                    let result = try JSONDecoder().decode(News.self, from: data)
                    DispatchQueue.main.async {
                        self.searchItem = result.articles
                    }
                    print("got data")
                }
                else {
                    print("no data")
                }
            }
            catch(let error){
                print(error)
            }
        }.resume()
    }
}
