//
//  ActiveToggleView.swift
//  Qwiker-Driver
//
// Created by Le Vu Phuoc 01.6.2023.
//

import SwiftUI

struct ActiveToggle: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @State private var activeState: Bool = false
    var body: some View {
        HStack{
            Text("Hoạt động")
            if let user = homeVM.user{
                Toggle(isOn: $activeState) {}
                    .labelsHidden()
                    .tint(.primaryBlue)
                    .onAppear{
                        activeState = user.isActive
                    }
            }else{
                ProgressView()
            }
            
        }
        .padding(5)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
        }
        .onChange(of: activeState) { newValue in
            if newValue != homeVM.user?.isActive{
                homeVM.updateDriverActiveState(newValue){}
            }
        }
    }
}

struct ActiveToggle_Previews: PreviewProvider {
    static var previews: some View {
        ActiveToggle()
            .environmentObject(dev.homeViewModel)
    }
}
