//
//  DocumentViewModel.swift
//  NorgEditor
//
//  Created by Carey Janecka on 7/10/23.
//

import Foundation

extension DocumentView {
    
    /// DocumentViewModel manages the state of DocumentView
    @MainActor class DocumentViewModel : ObservableObject {
        @Published var document: NorgDocument
        
        init(document: NorgDocument) {
            self.document = document
        }
    }
}
