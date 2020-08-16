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
    func callout(count: Int) -> String {
        if (count == 0) {
            return ["Is this a joke for you?", "What?", "Are you serious?"].randomElement()!
        }
        else if (count < 5) {
            return ["At least you tried"].randomElement()!
        }
        else if (count < 10) {
            return ["Nice one, keep it up"].randomElement()!
        }
        return "Wow!"
    }
    
    let session: Session
    @State var count: Int = 0
    
    
    var body: some View {
        return VStack {
            Text("\(callout(count: count))")
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
