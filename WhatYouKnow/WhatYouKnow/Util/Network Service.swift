//
//  Network Service.swift
//  WhatYouKnow
//
//  Created by Borislav on 2.05.22.
//

import Foundation

class NetworkService{
    static var sharedObj = NetworkService()
              
      let urlRequest = URLRequest(url: URL(string: "https://raw.githubusercontent.com/statsing99/JsonDATA/main/asd.json")!)
        
      let session = URLSession.shared
      
      
    
      func getQuestions(onSucess: @escaping(Questions) -> Void)
      {
        let task =  session.dataTask(with: urlRequest) { (data, respone, error) in
          DispatchQueue.main.async {
              
              guard error == nil,
                    let data = data else {
                  print("No data received", error ?? URLError(.badServerResponse))
                  return
              }
                    do
                      {
                      let decodeddata = try JSONDecoder().decode(Questions.self, from: data)
                      print(decodeddata.count)
                      onSucess(decodeddata)
                      }
                      catch let parserError{
                          print("Parsing error", parserError, String(describing: String(data: data, encoding: .utf8)))
                      }
                  }
              
        }
          task.resume()
    }
}
