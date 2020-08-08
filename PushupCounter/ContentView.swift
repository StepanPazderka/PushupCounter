//
//  ContentView.swift
//  PushupCounter
//
//  Created by Steve on 04/08/2020.
//  Copyright © 2020 Stepan Pazderka. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Session.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Session.date, ascending: false)]) var sessions: FetchedResults<Session>
    
    @State private var showingTrainingScreen = false

    func ConvertDate(date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .long
        return formatter1.string(from: date)
    }
    
    var body: some View {
        VStack {
            Section {
                NavigationView {
                    List {
                        ForEach(sessions, id: \.self) { session in
                            HStack {
                                Text("\(session.count)")
                                Text("\(self.ConvertDate(date: session.date!))").font(.system(size: 10))
                            }
                        }
                    }
                }
                .navigationBarTitle("Pushup Counter")
            }
            Spacer()
            Section {
                Button(action: {
                    self.showingTrainingScreen.toggle()
                }) {
                    Text("Test").padding()
                }
            }
        }
        .sheet(isPresented: $showingTrainingScreen) {
                Training().environment(\.managedObjectContext, self.moc)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
