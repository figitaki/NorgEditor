//
//  NorgDocument.swift
//  NorgEditor
//
//  Representation of a Norg document. Contains all the logic for parsing a
//  document from a string representation using the tree-sitter grammar, and providing
//  the structure to consumers via an AttributedString interface etc.
//
//  Created by Carey Janecka on 7/7/23.
//

import Foundation
import SwiftTreeSitter
import TreeSitterNorg

/// Represents a list type in the norg document.
enum ListType {
    case unordered
    case ordered
}

enum HeaderType {
    case header1
    case header2
}

enum TodoStatus {
    case undone
    case done
    case pending
}

/// Represents the type of a row in a norg document.
///
/// This value is derived from the tree-sitter structure and range.
enum RowType {
    case heading(Int)
    case list(ListType)
    case todo(TodoStatus)
    case paragraph
}

enum ParserError: Error {
    case invalidNodeType(String)
}

struct NorgRow {
    let id: []

    /// Norg specific node type, maps directly to the tree-sitter node.
    let type: RowType
   
    /// Raw internal string representation of the line.
    private let content: String

    static func parseType(_ type: String?) throws -> RowType {
        guard let type = type else {
            throw ParserError.invalidNodeType("Unable to parse the node type")
        }
        switch (type) {
        case "heading": return .heading(1)
        default: return .paragraph
        }
    }
}

class NorgDocument: ObservableObject {
    private var contents: String
    
    /// Tree-sitter parser for norg file type.
    private var parser = Parser()
    
    /// Internal tree-sitter representation of the document. Can be null if the document is empty.
    private var tree: SwiftTreeSitter.Tree?
    
    @Published private(set) var attributedString: AttributedString

    init(contents: String) {
        self.contents = contents
        
        // Initialize a tree-sitter language with the TreeSitterNorg grammar.
        let norg = Language(language: tree_sitter_norg())
        
        // TODO: Error handling
        try! parser.setLanguage(norg)
        
        attributedString = AttributedString(contents)
    }
    
    func parse(contents: String) {
        print("parsing string")
        tree = parser.parse(contents)
    }
    
    func describing() -> String {
        if let rootNode = tree?.rootNode {
            return traverse(rootNode)
        }
        return ""
    }
    
    static func transform(_ tree: SwiftTreeSitter.Tree) -> []NorgRow {
        // TODO: convert the Tree into an array of rows
    }
}

/// Generates a string representation of the tree specified by the given root node.
/// - Parameters:
///   - node: Current node to append and recurse over.
///   - nesting: Level of recursion to properly indent any output.
/// - Returns: String representation of the tree with newline's and indentation.
func traverse(_ root: SwiftTreeSitter.Node, nesting: Int = 0) -> String {
    var string = ""
    string += "\n"
    for _ in 0...nesting {
        string += " "
    }
    string += root.nodeType ?? "undefined"
    if root.childCount == 0 {
        return string + ")"
    }
    for i in 0...root.childCount-1 {
        if let child = root.child(at:i) {
            if child.nodeType ?? "" != "paragraph" {
                string += " " + traverse(child, nesting: nesting + 1)
            }
        }
        
    }
    return "(" + string + ")"
}
