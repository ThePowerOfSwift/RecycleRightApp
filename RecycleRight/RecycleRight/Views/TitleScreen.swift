//
//  TitleScreen.swift
//  RecycleRight
//
//  Created by Bhadra Rupesh on 12/9/21.
//

import SwiftUI

/* https://stackoverflow.com/questions/56437335/go-to-a-new-view-using-swiftui/56437491#56437491
 exension View taken from above link
 */

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct TitleScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geometry in
                    Rectangle()
                        .foregroundColor(Color(hue: 0.312, saturation: 0.203, brightness: 0.987))
                        .background(Color(hue: 0.312, saturation: 0.203, brightness: 0.987))
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)

                    VStack {
                        Spacer()
                        
                        Text("RecycleRight")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding()
                            .offset(y: geometry.size.height * -0.55)
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink(destination: HomeScreen()
                                .navigationBarTitle("")
                                .navigationBarHidden(true))
                            {
                                Text("ENTER")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            .font(.title2)
                            .padding()
                            .background(Color(red: 0.624, green: 0.859, blue: 0.505))
                            .cornerRadius(10)
                            .offset(y: geometry.size.height * -0.32)
                            .shadow(color: Color(red: 0.40, green: 0.40, blue: 0.40), radius: 3)
                            
                        
                        Spacer()
        
                    }
                }
                
            }
        }
    }
}
}

struct TitleScreen_Previews: PreviewProvider {
    static var previews: some View {
        TitleScreen()
    }
}
