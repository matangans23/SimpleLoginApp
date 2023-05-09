//
//  ContentView.swift
//  SimpleLoginApp
//
//  Created by Matan Gans on 5/8/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "star.fill")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Welcome to my first iOS app!")
                    .font(.system(size:24, weight: .bold, design: .rounded))
                    .padding(10)
                
                NavigationLink(destination: SigninPage()) {
                    Text("Sign In")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(30)
                        .padding(.top, 200)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AppViewModel()
        ContentView()
            .environmentObject(viewModel)
    }
}
