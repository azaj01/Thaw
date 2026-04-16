//
//  LayoutBarNewItemsBadgeView.swift
//  Project: Thaw
//
//  Copyright (Ice) © 2023–2025 Jordan Baird
//  Copyright (Thaw) © 2026 Toni Förster
//  Licensed under the GNU GPLv3

import Cocoa

/// A draggable badge that controls where newly detected items will be placed.
final class LayoutBarNewItemsBadgeView: LayoutBarArrangedView {
    private enum Metrics {
        static let height: CGFloat = 24
        static let cornerRadius: CGFloat = 12
        static let horizontalPadding: CGFloat = 10
        static let borderWidth: CGFloat = 1
    }

    private static var textAttributes: [NSAttributedString.Key: Any] {
        [
            .font: NSFont.systemFont(ofSize: 11, weight: .semibold),
            .foregroundColor: NSColor.labelColor,
        ]
    }

    override var kind: Kind {
        .newItemsBadge
    }

    init() {
        let title = NSAttributedString(
            string: String(localized: "New Items"),
            attributes: Self.textAttributes
        )
        let textWidth = ceil(title.size().width)
        let badgeWidth = textWidth + (Metrics.horizontalPadding * 2)
        let size = CGSize(width: badgeWidth, height: Metrics.height)
        super.init(frame: CGRect(origin: .zero, size: size))
        unregisterDraggedTypes()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draggingImage() -> NSImage? {
        bitmapImage()
    }

    override func draw(_: NSRect) {
        guard !isDraggingPlaceholder else {
            return
        }

        let pillPath = NSBezierPath(roundedRect: bounds, xRadius: Metrics.cornerRadius, yRadius: Metrics.cornerRadius)
        NSColor.controlAccentColor.withAlphaComponent(0.14).setFill()
        pillPath.fill()

        NSColor.controlAccentColor.withAlphaComponent(0.45).setStroke()
        pillPath.lineWidth = Metrics.borderWidth
        pillPath.stroke()

        let title = NSAttributedString(
            string: String(localized: "New Items"),
            attributes: Self.textAttributes
        )
        let titleSize = title.size()
        let titleOrigin = CGPoint(
            x: bounds.midX - (titleSize.width / 2),
            y: bounds.midY - (titleSize.height / 2)
        )
        title.draw(at: titleOrigin)
    }

    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)

        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setData(Data(), forType: .layoutBarItem)

        let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
        draggingItem.setDraggingFrame(bounds, contents: draggingImage())

        beginDraggingSession(with: [draggingItem], event: event, source: self)
    }

    private func bitmapImage() -> NSImage? {
        guard let rep = bitmapImageRepForCachingDisplay(in: bounds) else {
            return nil
        }
        cacheDisplay(in: bounds, to: rep)
        let image = NSImage(size: bounds.size)
        image.addRepresentation(rep)
        return image
    }
}
