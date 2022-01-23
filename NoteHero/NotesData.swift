//
//  NotesData.swift
//  NoteHero
//
//  Created by Federico on 23/01/2022.
//

import Foundation
import SwiftUI

struct Note : Codable, Identifiable {
    let id = UUID()
    var title: String
    var content: String
    var timeStamp: Double
}

@MainActor class Notes : ObservableObject {
    var notes: [Note] {
        didSet {
            saveNote()
            objectWillChange.send()
        }
    }
    private let NOTES_KEY = "NotesKey"
    
    init() {
        // Load saved data
        if let data = UserDefaults.standard.data(forKey: NOTES_KEY) {
            if let decodedNotes = try? JSONDecoder().decode([Note].self, from: data) {
                notes = decodedNotes
                return
            }
        }
        // A test note
        notes = [Note(title: "Test Note", content: "You should write some content in here, and it can be long as 100 characters.", timeStamp: 1231231231.0)]
    }
    
    func addNote(title: String, content: String) {
        let timeStamp = NSDate().timeIntervalSince1970
        let tempNote = Note(title: title, content: content, timeStamp: timeStamp)
        notes.insert(tempNote, at: 0)
        saveNote()
    }
    
    private func saveNote() {
        if let encodedNotes = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encodedNotes, forKey: NOTES_KEY)
        }
    }
}
