//
//  AspectVGrid.swift
//  SoloSet
//
//  Created by Wombat on 5/7/25.
//


//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Wombat on 5/6/25.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View
{
    var items: [Item]
    var aspectRatio: CGFloat = 1.0
    var content: (Item) -> ItemView
    var minCardSize: CGFloat = 62.0
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View
    {
        GeometryReader
        {
            geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio)
           
            if (gridItemSize < minCardSize)
            {
                ScrollView
                {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: max(gridItemSize, minCardSize)), spacing: 0)], spacing: 0) {
                        ForEach(items)
                        {
                            item in
                            content(item)
                                .aspectRatio(aspectRatio, contentMode: .fit)
                        }
                    }
                }
            }
            else
            {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: max(gridItemSize, minCardSize)), spacing: 0)], spacing: 0) {
                    ForEach(items)
                    {
                        item in
                        content(item)
                            .aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
            }
        }
    }
    
    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat
    {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat
        {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            
            if (rowCount * height < size.height)
            {

                return (size.width / columnCount).rounded(.down)
            }
            
            columnCount += 1
                
        } while columnCount < count
                    
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
    
}
