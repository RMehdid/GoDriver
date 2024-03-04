import SwiftUI
import RealmSwift

/// Log in or register users using email/password authentication
struct LoginView: View {
    @State var email = ""
    @State var password = ""

    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            VStack(spacing: 64){
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                VStack(spacing: 32){
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled(true)
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                
                Spacer()
                
                if viewModel.loginUiState == .logginIn {
                    ProgressView()
                    Spacer()
                }
                
                VStack{
                    Button {
                        viewModel.login(email: email, password: password)
                    } label: {
                        HStack {
                            Spacer()
                            
                            Text("Login")
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .disabled(viewModel.loginUiState == .logginIn)
                    .background(Color.yaPink)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    Button {
                        viewModel.signUp(email: email, password: password)
                    } label: {
                        HStack {
                            Spacer()
                            
                            Text("Create Account")
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .disabled(viewModel.loginUiState == .logginIn)
                    .background(Color.yaPurple)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }.padding(20)
        }
    }
}

#Preview {
    LoginView()
}
