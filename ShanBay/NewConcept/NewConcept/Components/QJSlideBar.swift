//
//  QJSlideBar.swift
//  NewConcept
//
//  Created by wcshinestar on 3/29/16.
//  Copyright © 2016 com.onesetp.WflytoC. All rights reserved.
//

import UIKit

private let baseIndex = 1000


@objc protocol QJSliderBarDelegate: NSObjectProtocol {
    
    
    /**
     
     当slide-bar的子项选中时，调用该方法
     
     */
    func itemSelectedWithSliderBar(sliderBar: QJSlideBar,selectedIndex: Int)
}

class QJSlideBar: UIView {
    
    var realItemWidth: CGFloat = 0.0 //每个子项的宽度
    var normalColor = UIColor.whiteColor()//子项未选中的颜色
    var selectedColor = UIColor.whiteColor()//子项选中的颜色
    var scrollView: UIScrollView?
    var currentSelected: Int = 0//当前选中项
    var indicator: UIView?//选中项下的指示器
    weak var delegate: QJSliderBarDelegate!
    
    init(frame: CGRect,itemWidth:CGFloat,names: [String]) {
        super.init(frame: frame)
        
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        self.addSubview(scrollView)
        
        self.scrollView = scrollView
        self.realItemWidth = itemWidth
        
        let width = frame.width
        
        if self.realItemWidth * CGFloat(names.count) < width {
            
            self.realItemWidth = width / CGFloat(names.count)
        }
        
        self.scrollView!.contentSize = CGSizeMake(realItemWidth * CGFloat(names.count), frame.height)
        
        
        
        for i in 0 ..< names.count {
            
            let item = UIButton(frame: CGRectMake(CGFloat(i) * self.realItemWidth,0.0,self.realItemWidth,frame.height))
            item.tag = baseIndex + i
            item.setTitle(names[i], forState: .Normal)
            self.scrollView!.addSubview(item)
            item.addTarget(self, action: #selector(QJSlideBar.itemSelect(_:)), forControlEvents: .TouchUpInside)
            
            if i == 0 {
                
                item.setTitleColor(UIColor.blueColor(), forState: .Normal)
            } else {
                
                item.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            }
            
        }
        
        let indicator = UIView(frame: CGRectMake(0,frame.height - 2,self.realItemWidth,3))
        indicator.backgroundColor = UIColor.blueColor()
        self.scrollView!.addSubview(indicator)
        self.indicator = indicator
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    /**
     
     子项选中时，调用该方法
 
    */
    func itemSelect(sender: UIButton) {
        let index = sender.tag - baseIndex
        if index != currentSelected {
            
            (scrollView!.viewWithTag(currentSelected + baseIndex)! as! UIButton).setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            sender.setTitleColor(UIColor.blueColor(), forState: .Normal)
            currentSelected = index
            UIView.animateWithDuration(0.25, animations: {
                self.indicator!.frame.origin.x = CGFloat(index) * self.realItemWidth
            })
        }
        
        if ((delegate?.respondsToSelector(#selector(QJSliderBarDelegate.itemSelectedWithSliderBar(_:selectedIndex:)))) != nil) {
            
            delegate?.itemSelectedWithSliderBar(self, selectedIndex: currentSelected)
        }
    }
    
}
