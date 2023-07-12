//
//  EditorView.swift
//  NorgEditor
//
//  Created by Carey Janecka on 7/7/23.
//

import SwiftUI

/// NorgRow represents a single line in a norg document.
struct NorgRow : Identifiable {
    let id: Int // Line number
    let type: NorgRowType
    let body: String
    let nesting: Int // Level of indentation?
}

/// Document editor for Neorg (.norg) files. Maintains it's own EditorViewModel for state.
struct EditorView: View {
    @State private var content: String = """
* Heading
  - ( ) An unfinished todo item
  - (x) A completed todo item
"""

    @State var isEditing = false
    @State var rows: [NorgRow] = [
        NorgRow(id: 0, type: .heading, body: "First heading", nesting: 0)
    ]
    @State var editingRow: Int = 0
    
    var body: some View {
            VStack {
                ForEach(rows) { (row) in
                    EditorRowView(text: row.body, edit: editingRow == row.id)
                }
            }
            .padding()
            .navigationTitle("My Note")
            .toolbar {
                ToolbarItemGroup {
                    Toggle(isOn: $isEditing) {
                        Image(systemName: "bold")
                    }
                }
            }
            .onTapGesture {
                isEditing = false
            }
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView()
    }
}
