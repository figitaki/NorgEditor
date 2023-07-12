//
//  EditorRowView.swift
//  NorgEditor
//
//  View responsible for displaying a single line from a norg document.
//
//  Created by Carey Janecka on 7/10/23.
//

import Foundation
import SwiftUI

struct EditorRowView : View {
    @State var text = ""
    @State var edit: Bool

    var displayFont = Font.system(size: CGFloat(13.0))
            .monospaced()

    var body: some View {
        if edit {
            TextEditor(text: $text)
                .font(displayFont)
                .disabled(edit)
                .toolbar {
                    ToolbarItemGroup {
                    }
                }
                .navigationTitle("My Note")
        } else {
            Text(text)
        }
    }
}
