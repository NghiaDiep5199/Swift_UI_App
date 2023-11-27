//
//  DriverArrivalView.swift
//  Qwiker
//
//  Created by Le Vu Phuoc 10.6.2023.
//

import SwiftUI

struct DriverArrivalView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject var homeVM: HomeViewModel
    var body: some View {
        ExpandedView(minHeight: getRect().height / 4, maxHeight: getRect().height / 1.2) { minHeight, rect, offset in
            SheetWithScrollView{
                title
                actionButtonsSection
                tripInfoSection
                bottomActionButtons
            }
        }
        .alert("Hủy đơn đặt hàng", isPresented: $isPresented) {
            Button("Yes", role: .destructive){
                homeVM.cancelTrip()
            }
        } message: {
            Text("Bạn có chắc chắn muốn hủy đơn đặt hàng?")
        }
    }
}

struct DriverArrivalView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .bottom) {
            Color.gray
            DriverArrivalView()
        }
        .ignoresSafeArea()
        .environmentObject(dev.homeViewModel)
    }
}


extension DriverArrivalView{
    private var title: some View{
        VStack(spacing: 10) {
            Text("Taxi của bạn ở đây")
                .font(.title2.bold())
            if let trip = homeVM.trip{
                HStack{
                    Text(trip.carInfo)
                        .font(.poppinsRegular(size: 18))
                    Text(trip.carNumber ?? "")
                        .font(.title3.bold())
                }
            }
        }
    }
    
    private var actionButtonsSection: some View{
        HStack{
            Spacer()
            CircleButtonWithTitle(title: "Gọi", imageName: "phone.fill", action: {})
            Spacer()
            CircleButtonWithTitle(title: "Nhắn tin", imageName: "text.bubble.fill", action: {})
            Spacer()
            CircleButtonWithTitle(title: "On my way", imageName: "figure.walk", action: {})
            Spacer()
        }
        .padding(.vertical, 10)
    }
 @ViewBuilder
    private var tripInfoSection: some View{
        if let trip = homeVM.trip{
            TripDetailsInfoView(trip: trip)
        }
    }
    
    private var bottomActionButtons: some View{
        HStack{
            Spacer()
            CircleButtonWithTitle(title: "Huỷ chuyến", imageName: "xmark") {
                isPresented.toggle()
            }
            Spacer()
            CircleButtonWithTitle(title: "Chia sẻ lộ trình", imageName: "arrowshape.turn.up.right.fill") {
            }
            Spacer()
            CircleButtonWithTitle(title: "An toàn", imageName: "shield.lefthalf.filled") {
            }
            Spacer()
        }
        .padding(.top)
    }
}
