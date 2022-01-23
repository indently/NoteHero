//
//  ContentView.swift
//  NoteHero
//
//  Created by Federico on 23/01/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var notes = Notes()
    @State private var sheetIsShowing = false

    var body: some View {
        NavigationView {
            VStack {
                NoteView()
                    .sheet(isPresented: $sheetIsShowing) {
                        EditNoteView()
                    }
            }
            .navigationTitle("Note Hero")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            self.sheetIsShowing.toggle()
                        }
                    } label: {
                        Label("Add Note", systemImage: "plus.circle.fill")
                    }
                }
            }
        }
        .environmentObject(notes)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
