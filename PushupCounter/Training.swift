//
//  Training.swift
//  PushupCounter
//
//  Created by Steve on 04/08/2020.
//  Copyright © 2020 Stepan Pazderka. All rights reserved.
//

import SwiftUI

struct Training: View {
    @Environment(\.managedObjectContext) var moc
//    @Environment(\.isPresented) private var isPresented
    @State private var counter: Int = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            Section {
                Text("\(counter)")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                Button(action: {
                    self.counter += 1
                }) {
                    Circle()
                    .frame(width: 250, height: 250)
                }
            }
            Spacer()
            Section {
                Button(action: {
                    self.finishTraining()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Finish Training")
                }
            }
            .padding(.bottom, 20)
        }
        .navigationBarTitle("Training")
    }
    
    func finishTraining() {
        let currentDate = Date()
        
        let TrainingSession     = Session(context: self.moc)
        TrainingSession.count   = Int32(self.counter)
        TrainingSession.date    = currentDate
        TrainingSession.id      = UUID()
        
        try? self.moc.save()
    }
}

struct Training_Previews: PreviewProvider {
    static var previews: some View {
        Training()
    }
}
