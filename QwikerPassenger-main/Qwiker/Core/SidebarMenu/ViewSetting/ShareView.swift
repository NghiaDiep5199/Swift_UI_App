import SwiftUI

struct ShareAppView: View {
    @State private var isAnimated = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Chia sẻ ứng dụng")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                ShareButton(title: "Chia sẻ ứng dụng", action: {
                    // Hiển thị màn hình chia sẻ ứng dụng
                    shareApp()
                })
                .scaleEffect(isAnimated ? 1.1 : 1.0) // Hiệu ứng sị xò
                .animation(.easeInOut(duration: 0.5)) // Thời gian và kiểu hiệu ứng
                .onAppear {
                    // Bắt đầu animation khi màn hình xuất hiện
                    withAnimation {
                        isAnimated.toggle()
                    }
                }
            }
            .padding()
            .navigationBarTitle("Chia Sẻ Ứng Dụng", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Hàm hiển thị màn hình chia sẻ ứng dụng
    private func shareApp() {
        let appURL = URL(string: "https://apps.apple.com/your-app-id")!
        let activityViewController = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}

struct ShareButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
        }
    }
}

struct ShareAppView_Previews: PreviewProvider {
    static var previews: some View {
        ShareAppView()
    }
}
