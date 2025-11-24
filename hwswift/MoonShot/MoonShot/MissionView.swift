//
//  MissionView.swift
//  MoonShot
//
//  Created by gülçin çetin on 14.08.2025.
//

import SwiftUI

struct CrewScrollView: View {
    let crew : [MissionView.CrewMember]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(crew, id: \.role){ crewMember in
                    NavigationLink{
                        AstronautView(astronaut: crewMember.astronaut)
                    }label: {
                        HStack{
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104 , height: 72)
                                .cornerRadius(10)
                                .padding(.bottom , 5)

                            
                            VStack(alignment: .leading){
                                Text(crewMember.astronaut.name)
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .padding(.leading , 5)
                                
                                Text(crewMember.role)
                                    .font(.headline)
                                    .foregroundStyle(.white.opacity(0.5))
                                    .padding(.leading , 5)
                            }
                        }
                        .padding()
                    }
                    
                }
            }
        }
    }
}

struct MissionView: View {
    
    struct CrewMember{
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        //Challange 2
        let divider =  Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
        
        ScrollView{
            VStack{
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding([.top , .bottom] ,10)
                
                //Challange 1
                Text(mission.formattedLaunchDate)
                    .font(.callout.bold())
                
                divider
                VStack(alignment:.leading){
                    Text("Mission Highlight")
                        .font(.largeTitle )
                        .bold()
                        .padding(.bottom , 5)
                 
                    Text(mission.description)
                    
                    divider
                    
                    Text("Crew")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom , 7)
                    
                }
                .padding(.horizontal)
            
                CrewScrollView(crew: crew)
                
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission:Mission, astronauts: [String: Astronaut]){
        self.mission = mission
        
        self.crew = mission.crew.map{ member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            }else{
                fatalError("Missing \(member.name)")
            }
            
        }
    }
}

#Preview {
    let missions:[Mission] = Bundle.main.decode("missions.json")
    let astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    
    NavigationStack{
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
