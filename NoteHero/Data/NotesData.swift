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
    var timeStamp: String
}

@MainActor class Notes : ObservableObject {
    private let NOTES_KEY = "NotesKey"
    var notes: [Note] {
        didSet {
            saveData()
            objectWillChange.send()
        }
    }
    
    init() {
        // Load saved data
        if let data = UserDefaults.standard.data(forKey: NOTES_KEY) {
            if let decodedNotes = try? JSONDecoder().decode([Note].self, from: data) {
                notes = decodedNotes
                return
            }
        }
        // Tutorial Note
        notes = [Note(title: "Test Note", content: "- Press on the \"Blue Plus\" to add a new note. \n- You can delete any note by swiping to the left!", timeStamp: formatDate(NSDate().timeIntervalSince1970))]
    }
    
    func addNote(title: String, content: String) {
        let tempNote = Note(title: title, content: content, timeStamp: formatDate(NSDate().timeIntervalSince1970))
        notes.insert(tempNote, at: 0)
        saveData()
    }
    
    // Save data
    private func saveData() {
        if let encodedNotes = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encodedNotes, forKey: NOTES_KEY)
        }
    }
}
