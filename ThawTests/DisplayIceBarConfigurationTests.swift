//
//  DisplayIceBarConfigurationTests.swift
//  Project: Thaw
//
//  Copyright (Ice) © 2023–2025 Jordan Baird
//  Copyright (Thaw) © 2026 Toni Förster
//  Licensed under the GNU GPLv3

@testable import Thaw
import XCTest

final class DisplayIceBarConfigurationTests: XCTestCase {
    // MARK: - Default Configuration Tests

    func testDefaultConfiguration() {
        let config = DisplayIceBarConfiguration.defaultConfiguration

        XCTAssertFalse(config.useIceBar)
        XCTAssertEqual(config.iceBarLocation, .dynamic)
        XCTAssertFalse(config.alwaysShowHiddenItems)
    }

    // MARK: - Initialization Tests

    func testCustomInitialization() {
        let config = DisplayIceBarConfiguration(
            useIceBar: true,
            iceBarLocation: .mousePointer,
            alwaysShowHiddenItems: true
        )

        XCTAssertTrue(config.useIceBar)
        XCTAssertEqual(config.iceBarLocation, .mousePointer)
        XCTAssertTrue(config.alwaysShowHiddenItems)
    }

    // MARK: - With Methods Tests

    func testWithUseIceBar() {
        let original = DisplayIceBarConfiguration.defaultConfiguration
        let modified = original.withUseIceBar(true)

        XCTAssertTrue(modified.useIceBar)
        XCTAssertEqual(modified.iceBarLocation, original.iceBarLocation)
        XCTAssertEqual(modified.alwaysShowHiddenItems, original.alwaysShowHiddenItems)
    }

    func testWithUseIceBarDoesNotMutateOriginal() {
        let original = DisplayIceBarConfiguration.defaultConfiguration
        _ = original.withUseIceBar(true)

        XCTAssertFalse(original.useIceBar)
    }

    func testWithIceBarLocation() {
        let original = DisplayIceBarConfiguration.defaultConfiguration
        let modified = original.withIceBarLocation(.iceIcon)

        XCTAssertEqual(modified.iceBarLocation, .iceIcon)
        XCTAssertEqual(modified.useIceBar, original.useIceBar)
        XCTAssertEqual(modified.alwaysShowHiddenItems, original.alwaysShowHiddenItems)
    }

    func testWithIceBarLocationDoesNotMutateOriginal() {
        let original = DisplayIceBarConfiguration.defaultConfiguration
        _ = original.withIceBarLocation(.mousePointer)

        XCTAssertEqual(original.iceBarLocation, .dynamic)
    }

    func testWithAlwaysShowHiddenItems() {
        let original = DisplayIceBarConfiguration.defaultConfiguration
        let modified = original.withAlwaysShowHiddenItems(true)

        XCTAssertTrue(modified.alwaysShowHiddenItems)
        XCTAssertEqual(modified.useIceBar, original.useIceBar)
        XCTAssertEqual(modified.iceBarLocation, original.iceBarLocation)
    }

    func testWithAlwaysShowHiddenItemsDoesNotMutateOriginal() {
        let original = DisplayIceBarConfiguration.defaultConfiguration
        _ = original.withAlwaysShowHiddenItems(true)

        XCTAssertFalse(original.alwaysShowHiddenItems)
    }

    // MARK: - Chained With Methods

    func testChainedWithMethods() {
        let config = DisplayIceBarConfiguration.defaultConfiguration
            .withUseIceBar(true)
            .withIceBarLocation(.iceIcon)
            .withAlwaysShowHiddenItems(true)

        XCTAssertTrue(config.useIceBar)
        XCTAssertEqual(config.iceBarLocation, .iceIcon)
        XCTAssertTrue(config.alwaysShowHiddenItems)
    }

    // MARK: - Equatable Tests

    func testEquatableIdentical() {
        let config1 = DisplayIceBarConfiguration(
            useIceBar: true,
            iceBarLocation: .mousePointer,
            alwaysShowHiddenItems: false
        )
        let config2 = DisplayIceBarConfiguration(
            useIceBar: true,
            iceBarLocation: .mousePointer,
            alwaysShowHiddenItems: false
        )

        XCTAssertEqual(config1, config2)
    }

    func testEquatableDifferentUseIceBar() {
        let config1 = DisplayIceBarConfiguration.defaultConfiguration
        let config2 = config1.withUseIceBar(true)

        XCTAssertNotEqual(config1, config2)
    }

    func testEquatableDifferentLocation() {
        let config1 = DisplayIceBarConfiguration.defaultConfiguration
        let config2 = config1.withIceBarLocation(.iceIcon)

        XCTAssertNotEqual(config1, config2)
    }

    func testEquatableDifferentAlwaysShow() {
        let config1 = DisplayIceBarConfiguration.defaultConfiguration
        let config2 = config1.withAlwaysShowHiddenItems(true)

        XCTAssertNotEqual(config1, config2)
    }

    // MARK: - Codable Tests

    func testEncodeDecode() throws {
        let original = DisplayIceBarConfiguration(
            useIceBar: true,
            iceBarLocation: .iceIcon,
            alwaysShowHiddenItems: true
        )

        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let data = try encoder.encode(original)
        let decoded = try decoder.decode(DisplayIceBarConfiguration.self, from: data)

        XCTAssertEqual(decoded, original)
    }

    func testEncodeDecodeDefaultConfiguration() throws {
        let original = DisplayIceBarConfiguration.defaultConfiguration

        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let data = try encoder.encode(original)
        let decoded = try decoder.decode(DisplayIceBarConfiguration.self, from: data)

        XCTAssertEqual(decoded, original)
    }

    func testDecodeFromJSON() throws {
        let json = """
        {
            "useIceBar": true,
            "iceBarLocation": 2,
            "alwaysShowHiddenItems": false
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(DisplayIceBarConfiguration.self, from: json)

        XCTAssertTrue(decoded.useIceBar)
        XCTAssertEqual(decoded.iceBarLocation, .iceIcon)
        XCTAssertFalse(decoded.alwaysShowHiddenItems)
    }

    // MARK: - All Locations Tests

    func testAllIceBarLocations() {
        for location in IceBarLocation.allCases {
            let config = DisplayIceBarConfiguration.defaultConfiguration.withIceBarLocation(location)
            XCTAssertEqual(config.iceBarLocation, location)
        }
    }
}
