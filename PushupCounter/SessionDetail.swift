//
//  SessionDetail.swift
//  PushupCounter
//
//  Created by Steve on 15/08/2020.
//  Copyright © 2020 Stepan Pazderka. All rights reserved.
//

import CoreData
import SwiftUI
//
//enum Callout: String {
//    case 0: ["Really?", "Am I a joke to you?"]
//}

struct SessionDetail: View {
    let session: Session
    @State var count: Int = 0
    
    
    var body: some View {
        return VStack {
            Text("Wow!")
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
