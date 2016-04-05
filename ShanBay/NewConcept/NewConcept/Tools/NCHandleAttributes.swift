//
//  NCHandleAttributes.swift
//  NewConcept
//
//  Created by wcshinestar on 3/31/16.
//  Copyright © 2016 com.onesetp.WflytoC. All rights reserved.
//

import UIKit

class NCHandleAttributes: NSObject {

    lazy var  contexts:[String] = {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(NCTools.getFilePath("contexts")) as! [String]
    }()
    
    lazy var words: [String: String] = {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(NCTools.getFilePath("words")) as! [String: String]
    }()
    
    var attrsString: NSAttributedString?
    
    static let sharedInstance = NCHandleAttributes()
    
    
    /**
     
     将指定课时的课文渲染成NSAttributedString,并对出现在单词列表中的单词进行标注
     
     - parameter chapter 第几课
     
     - returns: 无返回值
     
     */
    func getTextAttributes(chapter: Int)  {
        
        let context = contexts[chapter].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        //设置文章段落样式
        let para = NSMutableParagraphStyle()
        para.firstLineHeadIndent = 20
        para.tailIndent = -10
        para.lineBreakMode = .ByWordWrapping
        para.alignment = .Justified
        para.lineHeightMultiple = 1.2
        para.hyphenationFactor = 1.0
        
        
        let attributedString = NSMutableAttributedString(string: context, attributes: [NSFontAttributeName: UIFont(name:"Avenir", size: 16)!,NSParagraphStyleAttributeName: para])
        
        
        //遍历列表中的单词，为文章添加标记
        for (key, value) in words {
            
            let pattern = key
            let reg = try? NSRegularExpression(pattern: pattern, options: [.CaseInsensitive])
            if let reg = reg {
                
                let matches = reg.matchesInString(context, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, (context as NSString).length))
                for match in matches {
                    
                    let range = match.range
                    
                    let leftJudge = (range.location - 1) < 0 ? false : NCTools.judgeIsChar((context as NSString).substringWithRange(NSMakeRange(range.location - 1, 1)))
                    let rightJudge = (range.location + range.length) >= (context as NSString).length ? false : NCTools.judgeIsChar((context as NSString).substringWithRange(NSMakeRange(range.location + range.length, 1)))

                    if  !leftJudge && !rightJudge {
                        
                        attributedString.addAttribute("level", value: value, range: range)
                    }
                    
                    
                }
            }
            
        }
        
        //创建attributedString
        self.attrsString = attributedString
    }
    
}
