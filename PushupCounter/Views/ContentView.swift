//
//  ContentView.swift
//  PushupCounter
//
//  Created by Steve on 04/08/2020.
//  Copyright © 2020 Stepan Pazderka. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Session.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Session.date, ascending: false)]) var sessions: FetchedResults<Session>
    @State private var showingTrainingScreen = false
    
    func deleteSession(at offsets: IndexSet) {
        for offset in offsets {
            let session = sessions[offset]
            moc.delete(session)
            
            try? moc.save()
        }
    }
    
    func ConvertDate(date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .long
        return formatter1.string(from: date)
    }
    
    var body: some View {
        TabView {
            NavigationView {
                List {
                    ForEach(sessions, id: \.self) { session in
                        NavigationLink(destination: SessionDetail(session: session)) {
                            HStack {
                                Text("\(session.count)")
                                Text("\(self.ConvertDate(date: session.date!))").font(.system(size: 10))
                            }
                        }
                    }
                    .onDelete(perform: deleteSession)
                }
                .navigationBarTitle("Pushup Counter")
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                    self.showingTrainingScreen.toggle()
                }) {
                    Image(systemName: "plus")
                })
            }
            .sheet(isPresented: $showingTrainingScreen) {
                TrainingView().environment(\.managedObjectContext, self.moc)
            }
                
                
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Training Sessions")
            }
            NavigationView {
                Text("Here will be settings")
            }
            .tabItem {
                Image(systemName: "slider.horizontal.3")
                Text("Settings")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
