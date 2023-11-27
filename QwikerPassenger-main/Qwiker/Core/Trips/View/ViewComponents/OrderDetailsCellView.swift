//
//  OrderDetailsCellView.swift
//  Qwiker
//
//  Created by Le Vu Phuoc 10.6.2023.
//

import SwiftUI

struct OrderDetailsCellView: View{
    let trip: RequestedTrip?
    var body: some View{
        VStack {
            
            HStack(spacing: 20){
                Image(systemName: "info.circle")
                VStack(alignment: .leading){
                    Text("Chi tiết đơn hàng")
                        .font(.poppinsMedium(size: 16))
                        .foregroundColor(.black)
                    if let tripCoast = trip?.tripCost{
                        Text("Giá đơn là \(tripCoast.toCurrency())")
                            .font(.poppinsRegular(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .foregroundColor(.gray)
            }
            
            Divider().padding(.horizontal, -16)
        }
    }
}

struct OrderDetailsCellView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailsCellView(trip: dev.mockTrip)
    }
}
