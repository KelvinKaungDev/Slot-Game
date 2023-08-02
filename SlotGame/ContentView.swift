//
//  ContentView.swift
//  SlotGame
//
//  Created by Kelvin Gao  on 2/8/2566 BE.
//

import SwiftUI

enum Check : Int, Identifiable {
    var id : Int {
        rawValue
    }
    
    case success, fail;
}

struct ContentView: View {
    var hexagon = Hexagon()
    @State public var characters = ["one", "two", "three"]
    @State public var number = [0,1,2]
    @State public var count = 0
    @State private var status : Check?
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center, spacing: 80) {
                HStack {
                    Image("game")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("Slot Machine")
                        .font(.system(size: 35))
                        .fontWeight(.black)
                        .shadow(color: .orange,radius: 1,y: 3)
                        .foregroundColor(.white)
                    Image("game")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: .infinity, height: 50, alignment: .center)
                
                VStack {
            
                    HStack(spacing: 60) {
                        hexagon
                            .fill(Color.white.opacity(0.4))
                            .frame(width: 100, height: 120, alignment: .center)
                            .overlay(
                                Image(characters[number[0]])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 100)
                            )
                        hexagon
                            .fill(Color.white.opacity(0.4))
                            .frame(width: 100, height: 120, alignment: .center)
                            .overlay(
                                Image(characters[number[1]])                                 .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 100)
                            )
                    }
                    
                    hexagon
                        .fill(Color.white.opacity(0.4))
                        .frame(width: 100, height: 120, alignment: .center)
                        .overlay(
                            Image(characters[number[2]])                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 100)
                        )
                    
                    HStack(spacing: 60) {
                        hexagon
                            .fill(Color.white.opacity(0.4))
                            .frame(width: 100, height: 120, alignment: .center)
                            .overlay(
                                Image(characters[number[0]])                                 .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 100)
                            )
                        hexagon
                            .fill(Color.white.opacity(0.4))
                            .frame(width: 100, height: 120, alignment: .center)
                            .overlay(
                                Image(characters[number[2]])                                 .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 100)
                            )
                    }
                }
                
                Button {
                    number[0] = Int.random(in: 0...characters.count - 1)
                    number[1] = Int.random(in: 0...characters.count - 1)
                    number[2] = Int.random(in: 0...characters.count - 1)
                    
                    count += 1
                    
                    let repeted = repeatElement(number[0], count: number.count)
                    let allEqual = number.elementsEqual(repeted)
                    
                    if allEqual {
                        self.status = .success
                        count = 0
                    } else if count > 5 {
                        self.status = .fail
                        count = 0
                    }
                    
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.white))
                        .overlay(
                            Text("Spin")
                                .font(.system(size: 25))
                                .fontWeight(.black)
                                .foregroundColor(.black)
                        )
                        .frame(width: 150, height: 50)
                }
            }
            .alert(item: $status) { alert -> Alert in
                switch alert {
                case .success:
                    return Alert(title: Text("You Win"), message: Text("You Win"))
                case .fail:
                    return Alert(title: Text("You Lost"), message: Text("You Lost"))
                }
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
