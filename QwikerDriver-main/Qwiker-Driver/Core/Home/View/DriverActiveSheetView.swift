//
//  DriverActiveSheetView.swift
//  Qwiker-Driver
//
//  Created by Le Vu Phuoc 01.6.2023.
//

import SwiftUI

struct DriverActiveSheetView: View {
    @Binding var showDriverActivateSheet: Bool
    @EnvironmentObject var homeVM: HomeViewModel
    var isActive: Bool {
        homeVM.user?.isActive ?? false
    }
    var body: some View {
        BottomSheetView(maxHeightForBounds: 3) {
            title
            priority
            activeUnActiveButton
        }
        .onTapGesture {
            showDriverActivateSheet.toggle()
        }
    }
}

struct DriverActiveSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .bottom) {
            Color.gray.ignoresSafeArea()
            DriverActiveSheetView(showDriverActivateSheet: .constant(false))
        }
        .environmentObject(dev.homeViewModel)
    }
}


extension DriverActiveSheetView{
    private var title: some View{
        Text("Bạn đang \(isActive ? "hoạt động" : "nghỉ ngơi")")
            .font(.title.weight(.medium))
    }
    private var priority: some View{
        VStack(spacing: 15){
            Text("+5")
                .font(.title3)
                .padding()
                .background(Color.primaryGreen, in: Circle())
            Text("Ưu tiên cao hơn")
                .font(.title3.weight(.medium))
            Text("Mức độ ưu tiên càng cao, càng mất ít thời gian để tìm đơn hàng")
                .font(.poppinsRegular(size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private var activeUnActiveButton: some View{
        PrimaryButtonView(showLoader: false, title: isActive ? "Nghỉ ngơi" : "Hoạt động", bgColor: isActive ? .gray.opacity(0.8) : .primaryBlue, fontColor: .white) {
            homeVM.updateDriverActiveState(!isActive){
                withAnimation(.easeInOut){
                    showDriverActivateSheet.toggle()
                }
            }
        }
        .padding(.top)
    }
}
