//
//  Training.swift
//  PushupCounter
//
//  Created by Steve on 04/08/2020.
//  Copyright © 2020 Stepan Pazderka. All rights reserved.
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var counter: Int = 0
    @Environment(\.presentationMode) var presentationMode
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        VStack {
            Spacer()
            Section {
                Text("\(counter)")
                    .fontWeight(.heavy)
                    .font(.system(size: 60))
                Button(action: {
                    self.counter += 1
                    self.animationAmount = 1.7
                }) {
                    Circle()
                    .frame(width: 250, height: 250)
                }
                .scaleEffect(animationAmount)
                
                .onChange(of: animationAmount) { value in
                          animationAmount = 1
                    print("Changed")
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
        
        do {
            try self.moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Training_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView()
    }
}
