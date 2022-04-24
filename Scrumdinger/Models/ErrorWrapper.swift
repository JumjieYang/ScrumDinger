//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by Junjie Yang on 2022-04-23.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
