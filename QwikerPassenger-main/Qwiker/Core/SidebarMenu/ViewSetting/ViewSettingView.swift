import SwiftUI
import MessageUI

struct SupportView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Liên hệ hỗ trợ")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Nếu bạn cần hỗ trợ hoặc có bất kỳ câu hỏi nào, vui lòng liên hệ với chúng tôi qua các phương thức sau:")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding()
                
                VStack(spacing: 16) {
                    PhoneSupportView()
                    EmailSupportView()
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Hỗ trợ", displayMode: .inline)
        }
    }
}

struct PhoneSupportView: View {
    var body: some View {
        Button(action: {
            if let phoneURL = URL(string: "tel://0374592290"), UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }
        }) {
            SupportOptionView(imageName: "phone.fill", title: "Gọi điện thoại", description: "Gọi hotline hỗ trợ")
        }
    }
}

struct EmailSupportView: View {
    @State private var isShowingMailView = false
    
    var body: some View {
        Button(action: {
            self.isShowingMailView.toggle()
        }) {
            SupportOptionView(imageName: "envelope.fill", title: "Gửi Email", description: "Gửi email cho chúng tôi")
        }
        .sheet(isPresented: $isShowingMailView) {
            MailComposeViewControllerWrapper(
                isShowing: self.$isShowingMailView,
                toRecipients: ["phuoc2037@gmail.com"],
                subject: "Hỗ trợ ứng dụng"
            )
        }
    }
}

struct SupportOptionView: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.system(size: 40))
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

struct MailComposeViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let toRecipients: [String]
    let subject: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = context.coordinator
        mailComposeVC.setToRecipients(toRecipients)
        mailComposeVC.setSubject(subject)
        return mailComposeVC
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        // Nothing to update here
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailComposeViewControllerWrapper
        
        init(_ parent: MailComposeViewControllerWrapper) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
        }
    }
}

@available(iOS 15.0, *)
struct SupportView_Previews_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            SupportView()
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            
            SupportView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
        }
    }
}



struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}

//@available(iOS 15.0, *)
//struct SupportView_Previews_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        Group {
//            SupportView()
//                .preferredColorScheme(.light)
//                .previewDisplayName("Light Mode")
//
//            SupportView()
//                .preferredColorScheme(.dark)
//                .previewDisplayName("Dark Mode")
//        }
//    }
//}

