//
//  DocumentView.swift
//  NorgEditor
//
//  Created by Carey Janecka on 7/10/23.
//

import Foundation
import SwiftUI

struct DocumentView : View {
    @StateObject private var viewModel = DocumentViewModel(document: NorgDocument(contents: ""))

    var body: some View {
        NavigationStack {
            EditorView(editingRow: 0)
        }
    }
}
