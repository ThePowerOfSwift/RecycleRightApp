//
//  HomeScreen.swift
//  RecycleRight
//
//  Created by Bhadra Rupesh on 12/7/21.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                Rectangle()
                    .foregroundColor(Color(hue: 0.312, saturation: 0.203, brightness: 0.987))
                    .background(Color(hue: 0.312, saturation: 0.203, brightness: 0.987))
                    .frame(width: geometry.size.width,
                        height: geometry.size.height)
                Rectangle()
                    .foregroundColor(Color(red: 0.624, green: 0.859, blue: 0.505))
                    .background(Color(red: 0.624, green: 0.859, blue: 0.505))
                    .frame(width: geometry.size.width,
                           height: geometry.size.height*0.18)
                    .offset(x: 0, y: geometry.size.height * -0.09)
                    .shadow(radius: 10)
               
                NavigationLink(destination: TitleScreen()
                    .navigationBarTitle("")
                    .navigationBarHidden(true))
                {
                    Image("backbutton")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .offset(x: geometry.size.width * 0.08, y: geometry.size.height * 0.01)
                
                VStack {
                
                    HStack {
                        Spacer()
                        Text("Home")
                            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        .offset(y: geometry.size.height * 0.01)
                        Spacer()
                    }

                    Link(destination: URL(string: "recycle://")!)
                    {
                        Text("SCAN ITEM")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                        .font(.title2)
                        .padding()
                        .background(Color(red: 0.624, green: 0.859, blue: 0.505))
                        .cornerRadius(10)
                        .offset(y: geometry.size.height * 0.28)
                        .shadow(color: Color(red: 0.40, green: 0.40, blue: 0.40), radius: 3)
                    
                    NavigationLink(destination: StatsScreen()
                        .navigationBarTitle("")
                        .navigationBarHidden(true))
                    {
                        Text("MY WASTE")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                        .font(.title2)
                        .padding()
                        .background(Color(red: 0.624, green: 0.859, blue: 0.505))
                        .cornerRadius(10)
                        .offset(y: geometry.size.height * 0.45)
                        .shadow(color: Color(red: 0.40, green: 0.40, blue: 0.40), radius: 3)
                        
                }
            }
            
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
