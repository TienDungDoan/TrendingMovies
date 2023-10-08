//
//  ServerCredentials.swift
//  TrendingMovies
//
//  Created by Tien Dung Doan on 03/10/2023.
//

import Foundation

fileprivate let MiliSecondsToExpiration : TimeInterval = 1 * 60 * 60 * 1000

protocol ServerCredentialPersistence: Codable {
    static var defaultsKey: String { get }
    static func fromDefaults() -> Self?
    static func saveToDefaults(credentials: Self)
    static func invalidate()
}

extension ServerCredentialPersistence {
    static func fromDefaults() -> Self? {
        guard let data = UserDefaults.standard.data(forKey: Self.defaultsKey) else { return nil }
        return try! JSONDecoder().decode(Self.self, from: data)
    }

    static func saveToDefaults(credentials: Self) {
        let data = try! JSONEncoder().encode(credentials)
        UserDefaults.standard.set(data, forKey: Self.defaultsKey)
    }

    static func invalidate() {
        UserDefaults.standard.set(nil, forKey: Self.defaultsKey)
    }
}

protocol ServerCredentials: Codable {
    var accessToken: String { get }
    var isExpired: Bool { get }
    var isValid: Bool { get }
}

extension ServerCredentials {
    var isValid: Bool {
        return !isExpired // we can add more check valid on here, at this time only expire
    }
}

struct DefaultCredentials: ServerCredentials, ServerCredentialPersistence {

    static var defaultsKey: String { return "DefaultCredentials" }
    
    var accessToken: String
    var authenticationTime: TimeInterval
    var expiresIn: TimeInterval
    var isExpired: Bool {
        let nowEpochSeconds = Date().millisecondsSince1970
        return authenticationTime + expiresIn * 1000 < nowEpochSeconds
    }
    
    static func fromDefaults() -> DefaultCredentials? {
        if let credentialsFromSession = _fromSession() {
            return credentialsFromSession
        }
        
        guard let data = UserDefaults.standard.data(forKey: defaultsKey) else { return nil }
        let credentialsFromDefault = try? JSONDecoder().decode(DefaultCredentials.self, from: data)
        // Save the credential from default to session.
        if credentialsFromDefault != nil {
            ApplicationSession.defaults.credentials = credentialsFromDefault
        }
        return credentialsFromDefault
    }
    
    
    private static func _fromSession() -> DefaultCredentials? {
        return ApplicationSession.defaults.credentials // Get credential from Session
    }
    
    static func saveToDefaults(credentials: DefaultCredentials) {
        _clearOldCredentials()
        guard let data = try? JSONEncoder().encode(credentials) else {
            print("Decode credentials")
            return
        }
        UserDefaults.standard.set(data, forKey: defaultsKey)
    }
    
    public static func _clearOldCredentials() {
        UserDefaults.standard.set(nil, forKey: defaultsKey)
    }
}

extension Date {
    var millisecondsSince1970: TimeInterval {
        return TimeInterval((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}

class ApplicationSession {
    static let defaults: ApplicationSession = ApplicationSession()
    var credentials: DefaultCredentials?
}
