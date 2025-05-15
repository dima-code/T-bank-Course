//
//  DemoAppForTestsTests.swift
//  DemoAppForTestsTests
//
//  Created by Dmitriy Toropkin on 05.05.2025.
//

import XCTest
@testable import DemoAppForTests

final class DemoAppForTestsTests: XCTestCase {

    private var sut: CoffeeService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CoffeeService()

    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {

    }

    func testPerformanceExample() throws {
        self.measure {

        }
    }
    
    func testLimit() async { // Заказ более 5 напитков
        // given
        let coffeeId = 1
        let quantity = 1000
        let customerName = "Anatoly"
        do {
            // when
            let order = try await sut.placeOrder(coffeeId: coffeeId, quantity: quantity, customerName: customerName)
            
            // then
            XCTFail("Expected error ordering more than five drinks")
        } catch {
            XCTAssertTrue(error is CoffeeError)
        }
    }
    
    func testNegativeNumber() async { // Заказ отрицательного числа напитков
        // given
        let coffeeId = 1
        let quantity = -1
        let customerName = "Anatoly"
        do {
            // when
            let order = try await sut.placeOrder(coffeeId: coffeeId, quantity: quantity, customerName: customerName)
            
            // then
            XCTFail("Expected error ordering negative number of drinks")
        } catch {
            XCTAssertTrue(error is CoffeeError)
        }
    }

    func testFullOrder() async throws { // Проверяем работу общей логики
        let order = try await sut.placeOrder(coffeeId: 1, quantity: 1, customerName: "Anatoly")
        
        let orderStatus = try await sut.getOrderStatus(orderId: order.id)
        XCTAssertEqual(orderStatus.status, OrderStatus.pending)
        
        _ = try await sut.cancelOrder(orderId: order.id)
        let cancelOrder = try await sut.getOrderStatus(orderId: order.id)
        XCTAssertEqual(cancelOrder.status, OrderStatus.cancelled)
    }
    
    func testCancelledTwice() async throws { // Отменяем заказ 2 раза
        let order = try await sut.placeOrder(coffeeId: 1, quantity: 1, customerName: "Anatoly")
        
        do {
            _ = try await sut.cancelOrder(orderId: order.id)
            _ = try await sut.cancelOrder(orderId: order.id)
            
            XCTFail("Expected error")
        } catch CoffeeError.orderAlreadyCancelled {
            
        }
    }
}
