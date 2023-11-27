import SwiftUI

struct PromotionTile: View {
    var body: some View {
        VStack {
            Image("sale") // Thay "promotion_image" bằng tên hình ảnh mã khuyến mãi
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
            
            Text("Giảm giá 20% cho đơn hàng đầu tiên") // Nội dung mã khuyến mãi
                .font(.title2)
                .padding()
            
            Spacer() // Tạo khoảng trắng để đẩy nút quay lại lên dưới cùng
            Image("sale") // Thay "promotion_image" bằng tên hình ảnh mã khuyến mãi
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
            
            Text("Giảm giá 20% cho mọi đơn hàng") // Nội dung mã khuyến mãi
                .font(.title2)
                .padding()
        }
    }
}

struct SaleView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    PromotionTile()
                }
                
                Section {
                    // Các nội dung khác của ứng dụng có thể được thêm vào đây
                }
            }
            .listStyle(GroupedListStyle()) // Chỉnh kiểu danh sách
            
            .navigationBarTitle("Mã Khuyến Mãi") // Tiêu đề của trang
//            .navigationBarItems(leading: NavigationLink(destination: Text("Quay lại")) {
//                Text("Quay lại")
//            })
        }
    }
}
struct SaleView_Previews: PreviewProvider {
    static var previews: some View {
        SaleView()
    }
}
