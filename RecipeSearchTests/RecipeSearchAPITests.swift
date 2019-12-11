//
//  RecipeSearchAPITests.swift
//  RecipeSearchTests
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import XCTest
@testable import RecipeSearch

class RecipeSearchAPITests: XCTestCase {

    func testSearchChristmasCpploes() {
        //arrange
        //convert string to a url friendly string
        let searchQuery = "christmas cookies".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! //q
        
        let expectation = XCTestExpectation(description: "searches found")
        
        let recipeEndpointURL = "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKey.appId)&app_key=\(SecretKey.appKey)&from=0&to=50"
        
        let request = URLRequest(url: URL(string: recipeEndpointURL)!)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                XCTFail("appError: \(appError)")
            case .success(let data):
                expectation.fulfill()
                XCTAssertGreaterThan(data.count, 800000, "data should be greater than \(data.count)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    //write an async test to check 50 elements in array
    
    func testFetchRecipes() {
        //arrange
        let expectedRecipeCount = 50
        
        let expecation = XCTestExpectation(description: "recipes found")
        let searchQuery = "christmas cookies"
        
        //act
        RecipeSearchAPI.fetchRecipe(for: searchQuery) { (result) in
            
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
            case .success(let recipes):
                expecation.fulfill()
                XCTAssertEqual(recipes.count, expectedRecipeCount, "")
            }
        }
        
        wait(for: [expecation], timeout: 5.0)
    }
    
}
