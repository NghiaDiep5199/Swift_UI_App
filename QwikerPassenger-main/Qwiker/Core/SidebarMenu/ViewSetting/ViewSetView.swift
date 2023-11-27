import SwiftUI
import AVFoundation
import UIKit

struct SettingsView: View {
    @AppStorage("username") private var username = ""
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("soundEnabled") private var soundEnabled = true
    @AppStorage("selectedTheme") private var selectedTheme = 0
    
    // Khởi tạo màu nền mặc định
    @State private var backgroundColor: Color = .white
    @State private var isSaveSuccessful = false // Biến để kiểm tra xem việc lưu đã thành công hay chưa
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Thông tin cá nhân")) {
                    TextField("Tên người dùng", text: $username)
                }
                
                Section(header: Text("Cài đặt thông báo")) {
                    Toggle("Bật thông báo", isOn: $notificationsEnabled)
                    Toggle("Bật âm thanh", isOn: $soundEnabled)
                }
                
                Section(header: Text("Chọn chủ đề")) {
                    Picker("Chủ đề", selection: $selectedTheme) {
                        Text("Chủ đề 1").tag(0)
                        Text("Chủ đề 2").tag(1)
                        Text("Chủ đề 3").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .background(backgroundColor)
            .navigationBarTitle("Cài đặt")
            .navigationBarItems(trailing: Button("Lưu") {
                // Lưu cài đặt và tên người dùng vào UserDefaults
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(selectedTheme, forKey: "selectedTheme")
                UserDefaults.standard.set(notificationsEnabled, forKey: "notificationsEnabled")
                UserDefaults.standard.set(soundEnabled, forKey: "soundEnabled")
                
                // Kiểm tra trạng thái âm thanh và cập nhật nó
                if soundEnabled {
                    enableSound()
                } else {
                    disableSound()
                }
                
                // Hiển thị thông báo đã cập nhật thành công
                isSaveSuccessful = true
            })
        }
        .onAppear {
            // Cập nhật màu nền ban đầu dựa trên giá trị đã chọn
            updateBackgroundColor()
            
            // Kiểm tra trạng thái âm thanh và cập nhật nó khi màn hình xuất hiện
            if soundEnabled {
                enableSound()
            } else {
                disableSound()
            }
        }
        .onChange(of: selectedTheme) { newTheme in
            // Cập nhật màu nền dựa trên chủ đề mới được chọn
            updateBackgroundColor()
        }
        .alert(isPresented: $isSaveSuccessful) {
            Alert(title: Text("Thành Công"), message: Text("Cài đặt của bạn đã được lưu thành công."), dismissButton: .default(Text("OK")))
        }
    }
    
    private func updateBackgroundColor() {
        switch selectedTheme {
        case 0:
            backgroundColor = .white
        case 1:
            backgroundColor = .black
        case 2:
            backgroundColor = Color.pink // Màu hồng
        default:
            backgroundColor = .white
        }
    }
    
    private func enableSound() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Không thể bật âm thanh: \(error.localizedDescription)")
        }
    }
    
    private func disableSound() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Không thể tắt âm thanh: \(error.localizedDescription)")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
