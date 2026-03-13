import SwiftUI

struct ContentView: View {
    
    @StateObject private var camera = CameraManager()
    
    var body: some View {
        ZStack {
            
            CameraPreview(session: camera.session)
                .ignoresSafeArea()
            
            VStack {
                Text("Vision Camera Running")
                    .padding(8)
                    .background(.black.opacity(0.6))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
                Spacer()
            }
        }
        .onAppear {
            camera.start()
        }
    }
}
