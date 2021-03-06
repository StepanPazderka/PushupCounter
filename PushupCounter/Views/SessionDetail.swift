//
//  SessionDetail.swift
//  PushupCounter
//
//  Created by Steve on 15/08/2020.
//  Copyright © 2020 Stepan Pazderka. All rights reserved.
//

import CoreData
import SwiftUI


struct SessionDetail: View {
    /**
        Creates a callout based on number of pushups
     */
    func callout(pushupCount: Int) -> String {
        if (pushupCount == 0) {
            return ["Is this a joke for you?", "What?", "Are you serious?"].randomElement()!
        }
        else if (pushupCount < 5) {
            return ["At least you tried", "I bet you can do better 🙂"].randomElement()!
        }
        else if (pushupCount < 10) {
            return ["Nice one, keep it up"].randomElement()!
        }
        return "Wow!"
    }
    
    let session: Session
    @State var count: Int = 0
    
    
    var body: some View {
        return VStack {
            Text("\(callout(pushupCount: count))")
            Text("\(count)")
                .font(.largeTitle)
        }
        .onAppear() {
            self.count = self.session.value(forKey: "count") as? Int ?? 0
        }
    }
}

struct SessionDetail_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let session = Session(context: moc)
        session.date = Date()
        session.count = 20
        session.id = UUID()
        
        return NavigationView {
            SessionDetail(session: session)
        }
    }
}
