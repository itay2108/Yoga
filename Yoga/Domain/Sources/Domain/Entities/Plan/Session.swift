//
//  Session.swift
//  Domain
//
//  Created by Itay Gervash on 16/07/2025.
//

import Core
import Foundation

public struct Session: Sendable {
    public let index: Int
    public let length: Int
    public let quoteAuthor: String
    public let quote: String
    public let chapterName: String
    public let chapter: Int
    public let difficulty: SessionDifficulty

    public init(
        index: Int,
        length: Int,
        quoteAuthor: String,
        quote: String,
        chapterName: String,
        chapter: Int,
        difficulty: SessionDifficulty
    ) {
        self.index = index
        self.length = length
        self.quoteAuthor = quoteAuthor
        self.quote = quote
        self.chapterName = chapterName
        self.chapter = chapter
        self.difficulty = difficulty
    }
}

public extension Session {
    public init(
        index: Int,
        length: Int,
        quoteAuthor: String,
        quote: String,
        chapterName: String,
        chapter: Int,
        difficulty: String
    ) throws {
        guard let difficulty = SessionDifficulty(rawValue: difficulty) else {
            throw NSError.error(description: "Unexpectedly failed to parse difficulty with value : \(difficulty)")
        }

        self.index = index
        self.length = length
        self.quoteAuthor = quoteAuthor
        self.quote = quote
        self.chapterName = chapterName
        self.chapter = chapter
        self.difficulty = difficulty
    }
}
