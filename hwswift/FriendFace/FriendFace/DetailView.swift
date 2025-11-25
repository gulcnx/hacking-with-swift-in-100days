//
//  DetailView.swift
//  FriendFace
//
//  Created by gülçin çetin on 22.09.2025.
//

import SwiftUI

struct DetailView: View {
    var user: User
    
    var body: some View {
        VStack {
            Text("About \(user.name)⬇️")
            Text(user.about).padding()

            Text("\(user.name) has \(user.friends.count) many friends ⭐️" ).font(.headline).padding()
            
            ForEach(user.friends) { friend in
                VStack{
                    Text(friend.name).font(.headline)
                }
            }
        }
        
    }
}

