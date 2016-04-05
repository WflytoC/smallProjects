//
//  NCTools.swift
//  NewConcept
//
//  Created by wcshinestar on 3/30/16.
//  Copyright © 2016 com.onesetp.WflytoC. All rights reserved.
//

import UIKit

class NCTools: NSObject {
    
    
    /**
     
     获取指定文件名的路径
     
     - parameter fileName 文件名
     
     - returns: 文件路径
     
     */
    static func getFilePath(fileName: String) -> String {
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0].stringByAppendingString("/\(fileName).plist")
    }
    
    /**
     
     获取bundle下指定文件名的路径
     
     - parameter fileName 文件名
     
     - returns: 文件路径
     
     */
    static func getFilePathInBundle(fileName: String) -> String {
        let bundlePath = NSBundle.mainBundle().resourcePath!.stringByAppendingString("/NewConcept.bundle")
        let bundle = NSBundle(path: bundlePath)
        return bundle!.pathForResource(fileName, ofType: "txt")!
        
    }
    
    /**
     
     判断字符是否是字母
     
     - parameter char 判断的字符
     
     - returns: 是否是字母
     
     */
    static func judgeIsChar(char: String) -> Bool {
        
        let pattern = "^[A-Za-z]$"
        
        let reg = NSPredicate(format: "SELF MATCHES %@", pattern)
        
        if reg.evaluateWithObject(char) {
            
            return true
        }
        
        return false
    }

  }


















