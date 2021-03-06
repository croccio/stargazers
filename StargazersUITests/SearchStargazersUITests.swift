//
//  SearchStargazers.swift
//  github-service-Unit-Tests
//
//  Created by Antonio Scardigno on 05/09/21.
//

import XCTest
import MVP
import Stargazers
import RxBlocking
@testable import Stargazers

class SearchStargazersUITests: XCTestCase {

    let ownerTextFieldCriteria = "Owner"
    let repositoryTextFieldCriteria = "Repository"
    let serchButtonCriteria = "Search Stargazers"
    
    let searchStargazersViewModel: SearchStargazersViewModel = ViewModelProvider.get()
    
    override func setUpWithError() throws {
        continueAfterFailure = false

        XCUIApplication().launch()

    }

    func test_search_success() throws {
        
        let app = XCUIApplication()
        
        let ownerTextField = app.textFields[ownerTextFieldCriteria]
        XCTAssert(ownerTextField.exists)
        ownerTextField.tap()
        ownerTextField.typeText("croccio\n")
        
        let repositoryTextField = app.textFields[repositoryTextFieldCriteria]
        XCTAssert(repositoryTextField.exists)
        repositoryTextField.tap()
        repositoryTextField.typeText("Android-Auto-Store\n")
        
        let searchSearchButton = app.buttons[serchButtonCriteria]
        XCTAssert(searchSearchButton.exists)
        searchSearchButton.tap()
        
        let _ = searchStargazersViewModel
            .stargazers
            .toBlocking()
        
        XCTAssert(app.tables.tableRows.count == searchStargazersViewModel.stargazers.value.count)
        
    }
    
    func test_search_notFound() throws {
        
        let app = XCUIApplication()
        
        let ownerTextField = app.textFields[ownerTextFieldCriteria]
        XCTAssert(ownerTextField.exists)
        ownerTextField.tap()
        ownerTextField.typeText("croasdfafasdfdsfccio\n")
        
        let repositoryTextField = app.textFields[repositoryTextFieldCriteria]
        XCTAssert(repositoryTextField.exists)
        repositoryTextField.tap()
        repositoryTextField.typeText("Android-Auasdfadsfasfasdfasdfto-Store\n")
        
        let searchSearchButton = app.buttons[serchButtonCriteria]
        XCTAssert(searchSearchButton.exists)
        searchSearchButton.tap()
        
        let _ = searchStargazersViewModel
            .stargazers
            .toBlocking()
        
        addUIInterruptionMonitor(withDescription: "Not found".localized()) { (alert) -> Bool in
          alert.buttons["Ok"].tap()
          return true
        }
        
    }
    
    func test_search_clearStargazerOnRepositoryChange() throws {
        
        let app = XCUIApplication()
        
        let ownerTextField = app.textFields[ownerTextFieldCriteria]
        XCTAssert(ownerTextField.exists)
        ownerTextField.tap()
        ownerTextField.typeText("croccio\n")
        
        let repositoryTextField = app.textFields[repositoryTextFieldCriteria]
        XCTAssert(repositoryTextField.exists)
        repositoryTextField.tap()
        repositoryTextField.typeText("Android-Auto-Store\n")
        
        let searchSearchButton = app.buttons[serchButtonCriteria]
        XCTAssert(searchSearchButton.exists)
        searchSearchButton.tap()
        
        let _ = searchStargazersViewModel
            .stargazers
            .toBlocking()
        
        repositoryTextField.tap()
        repositoryTextField.typeText("mod\n")
        
        XCTAssert(searchStargazersViewModel.stargazers.value.count == 0)
        XCTAssert(app.tables.tableRows.count == searchStargazersViewModel.stargazers.value.count)
        
    }
    
    func test_search_clearStargazerOnOwnerChange() throws {
        
        let app = XCUIApplication()
        
        let ownerTextField = app.textFields[ownerTextFieldCriteria]
        XCTAssert(ownerTextField.exists)
        ownerTextField.tap()
        ownerTextField.typeText("croccio\n")
        
        let repositoryTextField = app.textFields[repositoryTextFieldCriteria]
        XCTAssert(repositoryTextField.exists)
        repositoryTextField.tap()
        repositoryTextField.typeText("Android-Auto-Store\n")
        
        let searchSearchButton = app.buttons[serchButtonCriteria]
        XCTAssert(searchSearchButton.exists)
        searchSearchButton.tap()
        
        let _ = searchStargazersViewModel
            .stargazers
            .toBlocking()
        
        ownerTextField.tap()
        ownerTextField.typeText("mod\n")
        
        XCTAssert(searchStargazersViewModel.stargazers.value.count == 0)
        XCTAssert(app.tables.tableRows.count == searchStargazersViewModel.stargazers.value.count)
        
    }
    
    func test_search_ownerField() throws {
        
        let app = XCUIApplication()
        
        let searchSearchButton = app.buttons[serchButtonCriteria]
        XCTAssert(searchSearchButton.exists)
        searchSearchButton.tap()
        
        addUIInterruptionMonitor(withDescription: "error_insert_owner".localized()) { (alert) -> Bool in
            alert.buttons["ok".localized()].tap()
          return true
        }
    }
    
    func test_search_repositoryField() throws {
        
        let app = XCUIApplication()
        
        let searchSearchButton = app.buttons[serchButtonCriteria]
        XCTAssert(searchSearchButton.exists)
        searchSearchButton.tap()
        
        addUIInterruptionMonitor(withDescription: "error_insert_repository".localized()) { (alert) -> Bool in
          alert.buttons["ok".localized()].tap()
          return true
        }
    }
    
}
