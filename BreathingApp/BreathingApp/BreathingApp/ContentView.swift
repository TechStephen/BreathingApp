//
//  ContentView.swift
//  BreathingApp
//
//  Created by Stephen Schmitz on 8/5/21.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
    }
}

struct ContentView: View {
    
    @State var progressValue: Float = 0.00
    @State var isActive: Bool = false
    @State var arr: Array = ["Breathe in...", "Hold...", "Breathe Out...", "Hold..."]
    @State var number: Int = 0
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Spacer()
                HStack{
                    Text("Breathing App")
                        .underline()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .tracking(4)
                }
                Spacer()
                ProgressBar(progress: self.$progressValue)
                    .frame(width: 150, height: 150)
                Spacer()
                Text("\(arr[number])")
                    .animation(.easeInOut)
                Spacer()
                Button(action: {
                    isActive.toggle()
                }, label: {
                    Text("    Start Breathing")
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .background(
                            Capsule()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        )
                        
                })
                Spacer()
                
                    
            }
        }.onReceive(timer, perform: { _ in
            guard isActive else {return}
            if(progressValue < 1.00){
                progressValue += 0.01
            } else {
                progressValue = 0.00
                number += 1
                if(number > 3){
                    number = 0
                }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
