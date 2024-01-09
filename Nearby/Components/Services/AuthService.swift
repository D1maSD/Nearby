//
//  AuthService.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 05.01.2024.
//

import Foundation


class AuthService {
    static var shared = AuthService()

    var authToken: String?

    private init() {

    }

    func loginButtonPressed(_ email: String, _ password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let login = email
        let password = password

        let parameters = ["login": login, "password": password]

        guard let url = URL(string: "http://147.78.66.203:3210/auth/login") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {

                print(error?.localizedDescription ?? "No data")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let token = json["token"] as? String {
                        completion(.success(print("TOKEN \(token)")))
                        self.authToken = token
                        print("TOKEN \(token)")
                        self.getLocations()
                    }
                }
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }


    var locations = [Location]()
    func getLocations() -> [Location] {
        let urlTwo = URL(string: "http://147.78.66.203:3210/locations")!
        var requestTwo = URLRequest(url: urlTwo)
        requestTwo.httpMethod = "GET"

        guard let token = authToken else {
            print("Token is not exist")
            return [Location]()
        }
        print("140 TOKEN \(String(describing: token))")
        requestTwo.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")


        let taskTwo = URLSession.shared.dataTask(with: requestTwo) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            print("DATA \(data)")
            do {
                let locations = try JSONDecoder().decode([Location].self, from: data)
                self.locations = locations
                for location in locations {
                    if let latitude = Double(location.point.latitude), let longitude = Double(location.point.longitude) {
                        print("ID: \(location.id), Name: \(location.name), Latitude: \(latitude), Longitude: \(longitude)")
                    } else {
                        print("Error converting latitude/longitude to Double")
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }

        }
        taskTwo.resume()
        return locations
    }


    func registerButtonPressed(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let email = email
        let password = password

        let parameters = ["login": email, "password": password]

        guard let url = URL(string: "http://147.78.66.203:3210/auth/register") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("268 \(error.localizedDescription)")
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            print("data: \(data)"  )
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let token = json["token"] as? String {
                        completion(.success( print("TOKEN REGISTER \(token)")))
                        self.authToken = token
                        self.getLocations()
                    }
                }
            } catch let error {
                completion(.failure(error))
                print("286 \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    func getMenuItems(forLocationID id: Int, completion: @escaping (Result<[MenuItem], Error>) -> Void) {
        guard let token = authToken else {
            print("Token is not available")
            completion(.failure(NetworkError.tokenMissing))
            return
        }
        let urlString = "http://147.78.66.203:3210/location/\(id)/menu"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let menuItems = try JSONDecoder().decode([MenuItem].self, from: data)
                print("\(menuItems)")
                completion(.success(menuItems))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}





class LocationService {
    static var shared = LocationService()

    var authToken: String?

    private init() {

    }

    var locations = [Location]()
    func getLocations() -> [Location] {
        let urlTwo = URL(string: "http://147.78.66.203:3210/locations")!
        var requestTwo = URLRequest(url: urlTwo)
        requestTwo.httpMethod = "GET"

        guard let token = authToken else {
            print("Token is not exist")
            return [Location]()
        }
        print("140 TOKEN \(String(describing: token))")
        requestTwo.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")


        let taskTwo = URLSession.shared.dataTask(with: requestTwo) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            print("DATA \(data)")
            do {
                let locations = try JSONDecoder().decode([Location].self, from: data)
                self.locations = locations
                for location in locations {
                    if let latitude = Double(location.point.latitude), let longitude = Double(location.point.longitude) {
                        print("ID: \(location.id), Name: \(location.name), Latitude: \(latitude), Longitude: \(longitude)")
                    } else {
                        print("Error converting latitude/longitude to Double")
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }

        }
        taskTwo.resume()
        return locations
    }

}
