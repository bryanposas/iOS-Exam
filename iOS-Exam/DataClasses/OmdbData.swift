//
//  OmdbData.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation

typealias OmdbDataCompletion = (_ movieResult: MovieResult?) -> ()

protocol OmdbDataProtocol {
    func getMovies(completionBlock: @escaping OmdbDataCompletion)
}

class OmdbData: OmdbDataProtocol {
    func getMovies(completionBlock: @escaping OmdbDataCompletion) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjOTY1ZWQ3OWE3ZWQ2MTM2MWNkYjUxYzRlMjQ1MzRlYyIsInN1YiI6IjY0ZDAxZjllNWNkMTZlMDBjNzU1MmViOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SBG-PRnLzkfBMs3NrLoWDhSkBD8xyIzR-KGtVzaYcAg"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&year=2023")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            completionBlock(self.handleResponse(data: data, response: response, error: error))
        })
        
        dataTask.resume()
    }
    
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) -> MovieResult? {
        if let error = error {
            printLog(error.localizedDescription)
            handleError(error)
        } else {
            if let httpResponse = response as? HTTPURLResponse {
                switch (httpResponse.statusCode) {
                case 200:
                    return parseResponse(data)
                default: break
                }
            }
        }
        
        return nil
    }
    
    private func handleError(_ error: Error) {
        printLog(error.localizedDescription)
    }
    
    private func parseResponse(_ data: Data?) -> MovieResult? {
        do {
            guard let data = data, let movieResult = try SimpleJSONParser<MovieResult>().parse(data) as? MovieResult else { return nil }
            return movieResult
        } catch {
            printLog(error.localizedDescription)
        }
        
        return nil
    }
}
