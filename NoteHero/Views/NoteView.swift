//
//  NoteView.swift
//  NoteHero
//
//  Created by Federico on 23/01/2022.
//

import SwiftUI

struct NoteView: View {
    @EnvironmentObject var notes: Notes
    
    var body: some View {
        List {
            ForEach(notes.notes) { note in
                VStack(alignment: .leading) {
                    Text(note.title)
                        .foregroundColor(.blue)
                        .font(.headline)
                    Text(note.content)
                        .font(.body)
                        .lineLimit(3)
                        .padding(.vertical)
                
                    HStack {
                        Spacer()
                        Text("\(note.timeStamp)")
                            .foregroundColor(.gray)
                            .italic()
                    }
                }  
            }
            .onDelete(perform: deleteNote)
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        notes.notes.remove(atOffsets: offsets)
    }
        
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
            .environmentObject(Notes())
    }
}
