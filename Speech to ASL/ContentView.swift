//
//  ContentView.swift
//  Speech to ASL
//
//  Created by Adrian Salgado Lopez on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    @State private var pressing = false
    @State private var audioRecorded = false
    @State private var aslReady = false
    @State private var home = true
    
    var body: some View {
        
        VStack {
            if home {
                RecordingButtonView(audioReady: $audioRecorded, aslReady: $aslReady)
                
                if audioRecorded && aslReady {
                    ASLButtonView(home: $home)
                }
            }
            else {
                
                ASLView(home: $home)
            }
        
        }
        .padding()
    }
}

struct RecordingButtonView: View {
    @Binding var audioReady: Bool
    @Binding var aslReady: Bool
    
    var body: some View{
        Button(action: {
            // Your custom logic when the button is tapped
            
            print("Recording....")
            
            // when model generates image and ready, toggle
            if !audioReady && !aslReady{
                audioReady.toggle()
                aslReady.toggle()
            }
        }) {
            Text("Record")
                .font(.system(size: 16))
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(150)
        }
        
    }
}

struct ASLButtonView: View {
    @Binding var home: Bool
    
    var body: some View {
        Button(action: {
            // Your custom logic when the button is tapped
            //  avaudiorecorder    - LOOK INTO AUDIO LIBRARY
            print("Viewing ASL....")
            home.toggle()
        }) {
            Text("View ASL")
                .font(.system(size: 16))
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct ASLView: View {
    @Binding var home: Bool
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        VStack {
            
            if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                HorizontalNotifyView()
            }else {
                
                Image("asl_placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding()
                
                HomeButtonView(home: $home)
            }
        }
    }
}

struct HomeButtonView: View {
    @Binding var home: Bool
    
    var body: some View {
        Button(action: {
            print("Going HOME")
            home.toggle()
        }) {
            Text("GO HOME")
                .font(.system(size: 16))
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct HorizontalNotifyView: View {
    
    var body: some View {
        Image("horizontal_flip_notify")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
            .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
