//
//  JSON+Extensions.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//

import Foundation

public extension JSONDecoder {
    /// Attempts to read from a file in the specified bundle, and decode it's contents
    /// - Parameters:
    ///   - jsonFileName: the file name to look up
    ///   - type: the data type to decode from the file
    /// - Returns: an optional object with the passed data type if the file is found and the decode is successful
    func readFromBundle<T: Decodable>(bundle: Bundle = Bundle.main, jsonFileName: String, type: T.Type) -> T? {
        if let path = bundle.path(forResource: jsonFileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try decode(type, from: data)
                return result
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        return nil
    }

    /// Attempts to read from a file in the document directory, and decode its contents
    /// - Important: The default path is a String represntation of the object type by default. Hence, in case there are multiple file with the same objects type - a unique file path must be specified.
    /// - Parameter path: the string URL to representing the path of the file in the document directory. Is
    /// - Returns: a decoded object from the contents of the file (if found).
    func readFromDocumentDirectory<T: Decodable>(fileWithPath path: String = String(describing: T.self)) throws -> T {
        return try readFromDocumentDirectory(fileWithPath: path, dataType: T.self)
    }

    /// Attempts to read from a file in the document directory, and decode its contents
    /// - Important: The default path is a String represntation of the object type by default. Hence, in case there are multiple file with the same objects type - a unique file path must be specified.
    /// - Parameter path: the string URL to representing the path of the file in the document directory. Is
    /// - Returns: a decoded object from the contents of the file (if found).
    func readFromDocumentDirectory<T: Decodable>(fileWithPath path: String = String(describing: T.self), dataType: T.Type) throws -> T {

        guard let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            throw NSError.error(description: "Could not find document directory")
        }

        let dataURL = documentsDirectory.appendingPathComponent(path)

        let jsonData = try Data(contentsOf: dataURL)
        let data = try self.decode(dataType, from: jsonData)
        return data
    }

    func readFromDocumentDirectory<T: Decodable>(dataURL: URL, dataType: T.Type) throws -> T {
        let jsonData = try Data(contentsOf: dataURL)
        let data = try self.decode(dataType, from: jsonData)
        return data
    }

    convenience init(keyDecodingStrategy: KeyDecodingStrategy = .useDefaultKeys, dateDecodingStrategy: DateDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = keyDecodingStrategy
        self.dateDecodingStrategy = dateDecodingStrategy
    }

    static var snakeCaseIso8601: JSONDecoder {
        return .init(keyDecodingStrategy: .convertFromSnakeCase, dateDecodingStrategy: .iso8601)
    }
}

public extension JSONEncoder {

    /// Attempts to write an encoded version of the passed Encodable object to the specified path in the document directory
    /// - Parameters:
    ///   - data: the object to encode and write
    ///   - path: the file where the object will be stored.
    /// - Important: The default path is a String represntation of the object type by default. Hence, in case there should be multiple file with the same objects type - a unique file path must be specified.
    @discardableResult
    func storeInDocumentDirectory<T: Encodable>(_ data: T, toPath path: String = String(describing: T.self)) throws -> URL {
        self.outputFormatting = .prettyPrinted
        let jsonData = try self.encode(data)

        guard let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            throw NSError.error(description: "Could not find document directory")
        }

        let fileURL = documentsDirectory.appendingPathComponent(path)
        try jsonData.write(to: fileURL, options: .atomic)
        return fileURL
    }

    convenience init(keyEncodingStrategy: KeyEncodingStrategy = .useDefaultKeys, dateEncodingStrategy: DateEncodingStrategy) {
        self.init()
        self.keyEncodingStrategy = keyEncodingStrategy
        self.dateEncodingStrategy = dateEncodingStrategy
    }
}
