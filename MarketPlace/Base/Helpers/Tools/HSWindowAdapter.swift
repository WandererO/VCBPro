//
//  HSWindowAdapter.swift
//  MarketPlace
//
//  Created by tanktank on 2022/6/2.
//

let baseWidth:CGFloat = 375
let baseHeight:CGFloat = 812

import Foundation
class HSWindowAdapter: NSObject{
    

    class func calculateWidth(input: CGFloat) -> CGFloat{
        
        return CGFloat(SCREEN_WIDTH)/baseWidth * input
    }
    
    class func calculateHeight(input: CGFloat) -> CGFloat{
        
        return CGFloat(SCREEN_HEIGHT)/baseHeight * input
    }
}
