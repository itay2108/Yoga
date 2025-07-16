//
//  SessionDTO.swift
//  Domain
//
//  Created by Itay Gervash on 16/10/2025.
//

import Core
import Domain
import Foundation

struct SessionDTO: DTO {
    let length: Int
    let quoteAuthor: String
    let quote: String
    let chapterName: String
    let chapter: Int
    let difficulty: String

    func asSession(withIndex sessionIndex: Int) throws -> Session {
        try Session(
            index: sessionIndex,
            length: length,
            quoteAuthor: quoteAuthor,
            quote: quote,
            chapterName: chapterName,
            chapter: chapter,
            difficulty: difficulty
        )
    }
}
