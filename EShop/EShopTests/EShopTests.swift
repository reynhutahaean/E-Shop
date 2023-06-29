//
//  EShopTests.swift
//  EShopTests
//
//  Created by Reynaldo Cristinus Hutahaean on 29/06/23.
//

import XCTest

final class EShopTests: XCTestCase {

    func testFetchCategories() async throws {
        let model = ShopModel()
        
        let mockService = MockAPIRepo()
        mockService.categories = [Category(id: 1, name: "Clothes", image: URL(string: "https://example.com/image1.jpg")!)]
        
        model.service = mockService
        
        try await model.fetchAllCategories()
        
        XCTAssertFalse(model.categories.isEmpty, "Categories array is empty")
        
        if let firstCategory = model.categories.first {
            XCTAssertEqual(firstCategory.name, "Clothes")
        } else {
            XCTFail("No categories found")
        }
    }
    
    func testSaveData() {
        let dataToSave = [Product(id: 1, title: "Shirt", price: 1000, description: "Test desc", category: Category(id: 1, name: "Clothes", image: URL(string: "https://example.com/image1.jpg")!))]
        
        let dataManager = DataManager.Defaults()
        dataManager.setDataObject(object: dataToSave, key: "TestKey")
        
        let savedData = UserDefaults.standard.data(forKey: "TestKey")
        
        XCTAssertTrue((savedData != nil), "Data should be saved successfully")
    }
}
