//
//  RehideStrategyTests.swift
//  Project: Thaw
//
//  Copyright (Ice) © 2023–2025 Jordan Baird
//  Copyright (Thaw) © 2026 Toni Förster
//  Licensed under the GNU GPLv3

@testable import Thaw
import XCTest

final class RehideStrategyTests: XCTestCase {
    // MARK: - Raw Value Tests

    func testSmartRawValue() {
        XCTAssertEqual(RehideStrategy.smart.rawValue, 0)
    }

    func testTimedRawValue() {
        XCTAssertEqual(RehideStrategy.timed.rawValue, 1)
    }

    func testFocusedAppRawValue() {
        XCTAssertEqual(RehideStrategy.focusedApp.rawValue, 2)
    }

    // MARK: - Init from Raw Value Tests

    func testInitFromRawValueZero() {
        XCTAssertEqual(RehideStrategy(rawValue: 0), .smart)
    }

    func testInitFromRawValueOne() {
        XCTAssertEqual(RehideStrategy(rawValue: 1), .timed)
    }

    func testInitFromRawValueTwo() {
        XCTAssertEqual(RehideStrategy(rawValue: 2), .focusedApp)
    }

    func testInitFromInvalidRawValue() {
        XCTAssertNil(RehideStrategy(rawValue: 3))
        XCTAssertNil(RehideStrategy(rawValue: -1))
        XCTAssertNil(RehideStrategy(rawValue: 100))
    }

    // MARK: - Identifiable Tests

    func testIdMatchesRawValue() {
        for strategy in RehideStrategy.allCases {
            XCTAssertEqual(strategy.id, strategy.rawValue)
        }
    }

    // MARK: - CaseIterable Tests

    func testAllCasesCount() {
        XCTAssertEqual(RehideStrategy.allCases.count, 3)
    }

    func testAllCasesContainsAllStrategies() {
        XCTAssertTrue(RehideStrategy.allCases.contains(.smart))
        XCTAssertTrue(RehideStrategy.allCases.contains(.timed))
        XCTAssertTrue(RehideStrategy.allCases.contains(.focusedApp))
    }
}
