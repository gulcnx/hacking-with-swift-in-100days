//
//  ContentView.swift
//  MoonShot
//
//  Created by gülçin çetin on 14.08.2025.
//
import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var showingGrid = true
    
    var body: some View {
        NavigationStack {
            //Challenge 3
                Group {
                    if showingGrid {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                ForEach(missions) { mission in
                                    NavigationLink {
                                        MissionView(mission: mission, astronauts: astronauts)
                                    } label: {
                                        missionCard(for: mission)
                                    }
                                }
                            }
                        }
                    } else {
                        List(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                missionCard(for: mission)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            .navigationTitle("MoonShot")
            .toolbar {
                Button("Change style") {
                    showingGrid.toggle()
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }

    func missionCard(for mission: Mission) -> some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    ContentView()
}
