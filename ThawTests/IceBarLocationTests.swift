//
//  IceBarLocationTests.swift
//  Project: Thaw
//
//  Copyright (Ice) © 2023–2025 Jordan Baird
//  Copyright (Thaw) © 2026 Toni Förster
//  Licensed under the GNU GPLv3

@testable import Thaw
import XCTest

final class IceBarLocationTests: XCTestCase {
    // MARK: - Raw Value Tests

    func testDynamicRawValue() {
        XCTAssertEqual(IceBarLocation.dynamic.rawValue, 0)
    }

    func testMousePointerRawValue() {
        XCTAssertEqual(IceBarLocation.mousePointer.rawValue, 1)
    }

    func testIceIconRawValue() {
        XCTAssertEqual(IceBarLocation.iceIcon.rawValue, 2)
    }

    // MARK: - Init from Raw Value Tests

    func testInitFromRawValueZero() {
        XCTAssertEqual(IceBarLocation(rawValue: 0), .dynamic)
    }

    func testInitFromRawValueOne() {
        XCTAssertEqual(IceBarLocation(rawValue: 1), .mousePointer)
    }

    func testInitFromRawValueTwo() {
        XCTAssertEqual(IceBarLocation(rawValue: 2), .iceIcon)
    }

    func testInitFromInvalidRawValue() {
        XCTAssertNil(IceBarLocation(rawValue: 3))
        XCTAssertNil(IceBarLocation(rawValue: -1))
        XCTAssertNil(IceBarLocation(rawValue: 100))
    }

    // MARK: - Identifiable Tests

    func testIdMatchesRawValue() {
        for location in IceBarLocation.allCases {
            XCTAssertEqual(location.id, location.rawValue)
        }
    }

    // MARK: - CaseIterable Tests

    func testAllCasesCount() {
        XCTAssertEqual(IceBarLocation.allCases.count, 3)
    }

    func testAllCasesContainsAllLocations() {
        XCTAssertTrue(IceBarLocation.allCases.contains(.dynamic))
        XCTAssertTrue(IceBarLocation.allCases.contains(.mousePointer))
        XCTAssertTrue(IceBarLocation.allCases.contains(.iceIcon))
    }

    // MARK: - Codable Tests

    func testEncodeDecode() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        for location in IceBarLocation.allCases {
            let data = try encoder.encode(location)
            let decoded = try decoder.decode(IceBarLocation.self, from: data)
            XCTAssertEqual(decoded, location)
        }
    }

    func testDecodeFromRawValueJSON() throws {
        let decoder = JSONDecoder()

        // JSON integers should decode to locations
        XCTAssertEqual(try decoder.decode(IceBarLocation.self, from: XCTUnwrap("0".data(using: .utf8))), .dynamic)
        XCTAssertEqual(try decoder.decode(IceBarLocation.self, from: XCTUnwrap("1".data(using: .utf8))), .mousePointer)
        XCTAssertEqual(try decoder.decode(IceBarLocation.self, from: XCTUnwrap("2".data(using: .utf8))), .iceIcon)
    }
}
