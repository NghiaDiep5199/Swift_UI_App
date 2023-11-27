//
//  SideMenuOptionType.swift
//  Qwiker
//
//  Created by Le Vu Phuoc 10.6.2023.
//

import Foundation

enum SideMenuOptionViewType: Int, CaseIterable {
    case trips
    case promocode
    case settings
    case support
    case share
    
    var title: String {
        switch self {
        case .trips: return "Đơn hàng"
        case .promocode: return "Mã khuyến mãi"
        case .settings: return "Cài đặc"
        case .support: return "Hỗ trợ"
        case .share: return "Chia sẻ"
        }
    }
    
    var imageName: String {
        switch self {
        case .trips: return "list.bullet.circle.fill"
        case .promocode: return "bookmark.circle.fill"
        case .settings: return "gear.circle.fill"
        case .support: return "bubble.left"
        case .share: return "arrowshape.turn.up.forward.circle.fill"
        }
    }
}
