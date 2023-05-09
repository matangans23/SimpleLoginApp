//
//  SigninPage.swift
//  SimpleLoginApp
//
//  Created by Matan Gans on 5/8/23.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) {
            [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) {
            [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
}

struct SigninPage: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                Text("Nice! You're signed in :)")
                    .foregroundColor(.red)
            }
            else {
                SignInView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            VStack {
                TextField("Email Address", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                Button(action: {
                    
                    viewModel.signIn(email: email, password: password)
                    
                }, label: {
                    Text("Sign In")
                        .frame(width: 100)
                })
                
                NavigationLink("Don't have an account? Sign Up instead", destination: SignUpView())
                    .padding()
            }
            .padding([.top], 200)
            .padding([.leading, .trailing], 20)
            
            Spacer()
            
        }
        .navigationTitle("Sign In")
    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            VStack {
                TextField("Email Address", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                Button(action: {
                    
                    viewModel.signUp(email: email, password: password)
                    
                }, label: {
                    Text("Sign Up")
                        .frame(width: 100)
                })
            }
            .padding([.top], 200)
            .padding([.leading, .trailing], 20)
            
            Spacer()
            
        }
        .navigationTitle("Create Account")
    }
}


struct SigninPage_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AppViewModel()
        SigninPage()
            .environmentObject(viewModel)
    }
}
