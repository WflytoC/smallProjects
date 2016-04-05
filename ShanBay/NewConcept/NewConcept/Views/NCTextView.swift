//
//  NCTextView.swift
//  NewConcept
//
//  Created by wcshinestar on 3/31/16.
//  Copyright © 2016 com.onesetp.WflytoC. All rights reserved.
//

import UIKit

class NCTextView: UITextView {
    

    
    //添加点击获取单词
    func tapToGetWord() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(NCTextView.tapRecognized(_:)))
        self.addGestureRecognizer(tap)
    }
    
    /**
     
     对UITextView添加点击事件，获取点击的单词
 
    */
    
    func tapRecognized(tap: UITapGestureRecognizer) {
        
        var realWord: String?
        var realLevel: String = "(不在单词列表中)"
        
        let textView = tap.view as! UITextView
        let pos = tap.locationInView(textView)
        let tapPos = textView.closestPositionToPoint(pos)
        let wr = textView.tokenizer.rangeEnclosingPosition(tapPos!, withGranularity: .Word, inDirection: 1)
        
        let attributedText = self.attributedText.mutableCopy() as! NSMutableAttributedString
        attributedText.removeAttribute(NSBackgroundColorAttributeName, range: NSMakeRange(0, attributedText.length))
        
        if let _ = wr {
            
        } else {
            self.attributedText = attributedText.copy() as! NSAttributedString
            return
        }
        
            // 计算点击单词的NSRange
            let begin = textView.beginningOfDocument
            let word = textView.textInRange(wr!)
            let start = wr!.start
            let end = wr!.end
            let location = textView.offsetFromPosition(begin, toPosition: start)
            let length = textView.offsetFromPosition(start, toPosition: end)
            if let word = word {
                
                
                realWord = word
            } else {
                
                return
            }
        
        
        
        attributedText.enumerateAttribute("level", inRange: NSMakeRange(0, attributedText.length), options: [])
                { (value, r, stop) in
                    
        if let _ = value   {
            
        } else {
                    
            return
        }
                    
                    
        if r.location <= location && (r.location + r.length) >= (location + length) {
            
            
                realLevel = "(等级为\(Int((value as? String)!)!))"
                attributedText.addAttribute(NSBackgroundColorAttributeName, value: UIColor.redColor(), range: r)
                realWord = (textView.text as NSString).substringWithRange(r)
        }
            
        }
        
        
        
        self.attributedText = attributedText.copy() as! NSAttributedString
        NCSheetView().showWordInView(textView.superview!, word: realWord! + realLevel)
    
        
    }//处理单词结束
    
    
    /**
     
     根据单词等级过滤单词，对应单词添加下划线
     
     - parameter level 指定单词等级
     
     - returns: 无返回值
     
     */
    func filterWordsFromLevel(level: Int) {
        
        let attributedText = self.attributedText.mutableCopy() as! NSMutableAttributedString
        //删除上一次选择的单词
        attributedText.removeAttribute(NSUnderlineStyleAttributeName, range: NSMakeRange(0, attributedText.length))
        attributedText.enumerateAttribute("level", inRange: NSMakeRange(0, attributedText.length), options: [])
        { (value, r, stop) in
        
            if let value = value  as? String where Int(value) <= level {
                
                attributedText.addAttribute(NSUnderlineStyleAttributeName, value: 2 , range: r)
                attributedText.addAttribute(NSUnderlineColorAttributeName, value: UIColor.orangeColor(), range: r)
            }
            
        }
        
        self.attributedText = attributedText.copy() as! NSAttributedString
    }

}
