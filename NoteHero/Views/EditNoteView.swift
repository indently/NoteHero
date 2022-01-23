//
//  EditNoteView.swift
//  NoteHero
//
//  Created by Federico on 23/01/2022.
//

import SwiftUI

struct EditNoteView: View {
    @State private var title = ""
    @State private var content = ""
    @EnvironmentObject var notes: Notes
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                TextField("Give your note a title", text: $title)
                ZStack {
                    TextEditor(text: $content)
                        .frame(height: 200)
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("\(content.count)/120")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                }
                HStack {
                    Spacer()
                    Button("Add note!") {
                        notes.addNote(title: title, content: content)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct EditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        EditNoteView()
            .environmentObject(Notes())
    }
}
