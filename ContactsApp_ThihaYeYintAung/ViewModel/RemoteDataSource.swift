//
//  RemoteDataSource.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 18/9/22.
//

import Foundation
import os.log

class RemoteDataSource<T: Decodable> {
    let endpoint: URL?
    
    init(for endpoint: String = "https://reqres.in/api/users?per_page=10") {
        self.endpoint = URL(string: endpoint)
    }
    
    func fetchData() async throws -> T {
        guard let endpoint = endpoint else {
            throw URLError(URLError.badURL)
        }
        let session = URLSession.shared
        guard let (data, response) = try? await session.data(from: endpoint),
              let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            os_log(.debug, log: OSLog.default, "Failed to received valid response and/or data.")
            throw ContactError.missingData
        }

        do {
            // Decode the User into a data model.
            let jsonDecoder = JSONDecoder()
            let decodedData = try jsonDecoder.decode(T.self, from: data)
            
            return decodedData
        } catch {
            throw ContactError.wrongDataFormat(error: error)
        }
    }
}
