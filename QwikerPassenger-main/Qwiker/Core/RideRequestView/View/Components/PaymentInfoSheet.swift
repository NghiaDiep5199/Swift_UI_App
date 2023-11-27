//
//  PaymentInfoSheet.swift
//  Qwiker
//
//  Created by Богдан Зыков on 28.10.2022.
//


import SwiftUI
import PassKit

struct PaymentInfoSheet: View {
    let card: Card? = Card()
    @State private var showInputCardSheet: Bool = false
    @State private var selectedRideType: RideType = .economy
    @Binding var showPaymentInfoSheet: Bool
    @State private var distanceInMeters: Double = 0.0
    @State private var totalPrice: Double = 0.0
    @State private var showRideTypeSelector: Bool = false
    @State private var currentPaymentMethod: PaymentMetodType = .cash
    let products = [
        Product(name: "Econom", price: RideType.economy.price(for: 5000)),
        Product(name: "Comfort", price: RideType.comfort.price(for: 5000)),
        Product(name: "Bisness", price: RideType.bisness.price(for: 5000)),
        Product(name: "Sport", price: RideType.sport.price(for: 5000))
    ]


    var body: some View {
        ZStack{
            Color.primaryBg.ignoresSafeArea()
            VStack(spacing: 0){
                headerView
                cardSection
                divider
                cashButton
                //PaymentButton
                PaymentButton(products: products)
                    .frame(minWidth: 100,maxWidth: .infinity,maxHeight: 45)
                    .padding()
                Spacer()
                submitButton
            }
        }
        .frame(height: getRect().height / 2.5)
        .sheet(isPresented: $showInputCardSheet) {
            Text("InputCardSheet")
        }
    }
}

struct PaymentInfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        PaymentInfoSheet(showPaymentInfoSheet: .constant(true))
    }
}

extension PaymentInfoSheet{
    private var headerView: some View{
        Text("Payment methods")
            .font(.poppinsMedium(size: 20))
            .foregroundColor(.white)
            .hCenter()
            .frame(height: 60)
            .background(Color.primaryBlue)
    }
    
    private var cardSection: some View{
        Group{
            if let card = card{
                    Button {
                        currentPaymentMethod = .card
                    } label: {
                        HStack{
                            Label(title: {
                                Text(card.getLastFourCharactersForCardNumber)
                            }, icon: {
                                Text("VISA")
                            })
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .cornerRadius(5)
                            Spacer()
                            if currentPaymentMethod == .card{
                                Image(systemName:"checkmark")
                                    .font(.subheadline.bold())
                                    .foregroundColor(.black)
                            }
                        }
                    }
                
            }else{
                Button {
                    showInputCardSheet.toggle()
                } label: {
                    HStack{
                        Text("Add card")
                            .font(.headline)
                        Spacer()
                        Image(systemName:"chevron.forward")
                            .imageScale(.small)
                    }
                    .foregroundColor(.black)
                }
            }
        }
        .padding()
    }
    
    private var cashButton: some View{
        Button {
            currentPaymentMethod = .cash
        } label: {
            HStack{
                Text("Cash")
                    .font(.headline)
                    
                Spacer()
                if currentPaymentMethod == .cash{
                    Image(systemName:"checkmark")
                        .font(.subheadline.bold())
                }
            }
            .foregroundColor(.black)
            .padding()
        }
    }
    
    
//    private var applePayButton: some View{
//        Button {
//            currentPaymentMethod = .applePay
//            PaymentButton(products: products)
//        } label: {
//            HStack{
//                Text("Apple Pay")
//                    .font(.headline)
//                Spacer()
//                if currentPaymentMethod == .applePay{
//                    Image(systemName:"checkmark")
//                        .font(.subheadline.bold())
//                        .foregroundColor(.black)
//                }
//            }
//            .foregroundColor(.black)
//            .padding()
//        }
//    }
    
    private var submitButton: some View{
        PrimaryButtonView(title: "Continue", font: .poppinsRegular(size: 18), bgColor: .gray, fontColor: .primaryBlue, isBackground: false, border: true){
            withAnimation {
                showPaymentInfoSheet.toggle()
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    private var divider: some View{
        CustomDivider(verticalPadding: 0, lineHeight: 8)
    }
//    private func calculatePrice() {
//        totalPrice = selectedRideType.price(for: distanceInMeters)
//    }

}


enum PaymentMetodType: Int{
    case card, cash, applePay
    
    func getLastFourCharactersForCardNumber(_ number: String) -> String?{
        if self == .card{
           
        }
        return nil
    }
}

struct Card{
    var number: String = "12344433"
    var date: String = ""
    var cvv: String = ""
    
    var getLastFourCharactersForCardNumber: String{
        number.count > 4 ? String(number.suffix(4)) : "none"
    }
}
struct Product: Identifiable {
    var id = UUID()
    var name : String
    var price : Double
}
struct PaymentButton: UIViewRepresentable {
    
    var products: [Product]
    
    func makeCoordinator() -> PaymentManager {
        PaymentManager(products: products)
    }
    func makeUIView(context: Context) -> some UIView {
        context.coordinator.button
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        context.coordinator.products = products
    }
    
}
class PaymentManager: NSObject,PKPaymentAuthorizationControllerDelegate {

    
    
    var products : [Product]
    
    var button = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .automatic)
    
    init(products: [Product]) {
        self.products = products
        super.init()
        button.addTarget(self, action: #selector(callBack(_:)), for: .touchUpInside)
    }
    
    @objc func callBack(_ sender: Any) {
        startPayment(products: products )
    }
    func startPayment(products: [Product]) {
        var paymentController: PKPaymentAuthorizationController?
        
        var paymentSummaryItems = [PKPaymentSummaryItem]()
        
        var totalPrice: Double = 0
        products.forEach { product in
            let item = PKPaymentSummaryItem(label: product.name, amount: NSDecimalNumber(string: "\(product.price.rounded())"),type: .final)
            totalPrice += product.price.rounded()
            paymentSummaryItems.append(item)
        }
        
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "\(totalPrice)"),type: .final)
        paymentSummaryItems.append(total)
        
        
        let paymentRequest = PKPaymentRequest()
        
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.countryCode = "SA"
        paymentRequest.currencyCode = "SAR"
        paymentRequest.supportedNetworks = [.visa,.mada,.masterCard]
        paymentRequest.shippingType = .delivery
        paymentRequest.merchantIdentifier = "merchant.ApplePayButtonSession"
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.shippingMethods = shippingMethodCalculator()
        paymentRequest.requiredShippingContactFields = [.name,.phoneNumber]
        
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        
        paymentController?.delegate = self
        paymentController?.present()
        
        
        
    }
    func shippingMethodCalculator() -> [PKShippingMethod] {
        
        let today = Date()
        let calendar = Calendar.current
        
        let shippingStart = calendar.date(byAdding: .day, value: 5, to: today)
        let shippingEnd = calendar.date(byAdding: .day, value: 10, to: today)
        
        if let shippingEnd = shippingEnd, let shippingStart = shippingStart {
            
            let startComponents = calendar.dateComponents([.calendar,.year,.month,.day], from: shippingStart)
            
            let endComponents = calendar.dateComponents([.calendar,.year,.month,.day], from: shippingEnd)
            
            let shippingDelivery = PKShippingMethod(label: "Delivery", amount: NSDecimalNumber(string: "0.00"))
            
            shippingDelivery.dateComponentsRange = PKDateComponentsRange(start: startComponents, end: endComponents)
            shippingDelivery.detail = "Arrives by 5pm on July 29."
            shippingDelivery.identifier = "DELIVERY"
            
            return [shippingDelivery]
        }
        
        return []
        
    }
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment) async -> PKPaymentAuthorizationResult {
        .init(status: .success, errors: nil)
    }
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss()
    }
}
