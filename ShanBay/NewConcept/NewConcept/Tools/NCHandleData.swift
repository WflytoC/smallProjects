//
//  NCHandleData.swift
//  NewConcept
//
//  Created by wcshinestar on 3/30/16.
//  Copyright © 2016 com.onesetp.WflytoC. All rights reserved.

//此此处方法会造成消耗大量内存

import UIKit

class NCHandleData: NSObject {
    
    /**
     
     当应用启动时，如果单词与课文数据文件没有被解析，则开始解析，并解析结果存入文件中
     
     */
    static func loadDataFromFile() -> Void {
        
        let manager = NSFileManager.defaultManager()
        var content: String?
            
        //文章标题
        var titles = [String]()
        let titlePath = NCTools.getFilePath("titles")
            
        //判断文章标题是否被解析
        if !manager.fileExistsAtPath(titlePath) {
            
                let path = NCTools.getFilePathInBundle("newConcept")
                content = try? String(contentsOfFile: path)
                
                //解析文章标题
                if let content = content {
                    let scanner = NSScanner(string: content)
                    var title: NSString?
                    while !scanner.atEnd {
                        
                        scanner.scanUpToString("Lesson ", intoString: nil)
                        scanner.scanUpToString("First listen", intoString: &title)
                        let components = title!.componentsSeparatedByString("\n")
                        let title = components[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                        titles.append(title)
                    }
                    titles.removeLast()
                    NSKeyedArchiver.archiveRootObject(titles, toFile: NCTools.getFilePath("titles"))
                }
                
            }
        
        //文章正文
        var contexts = [String]()
        let contextsPath = NCTools.getFilePath("contexts")
        
            
        //判断文章正文是否被解析
        if !manager.fileExistsAtPath(contextsPath) {
            
            if let _ = content {
                
            } else {
                
                let path = NCTools.getFilePathInBundle("newConcept")
                content = try? String(contentsOfFile: path)
            }
            
            //解析文章正文
            
            
            if let content = content {
                let scanner = NSScanner(string: content)
                var context: NSString?
                
                while !scanner.atEnd {
                    
                    scanner.scanUpToString("听录音，然后回答以下问题。", intoString: nil)
                    scanner.scanUpToString("New words ", intoString: &context)
                    let sub = context!.rangeOfString("?")
                    let data = context!.substringFromIndex(sub.location + 1)
                    print(data)
                    contexts.append(data)
                }
                NSKeyedArchiver.archiveRootObject(contexts, toFile: NCTools.getFilePath("contexts"))
            }
            
          }
        
        //解析单词表
        let wordsPath = NCTools.getFilePath("words")
        if !manager.fileExistsAtPath(wordsPath) {
            
            let path = NCTools.getFilePathInBundle("nce4_words")
            content = try? String(contentsOfFile: path)
            
            var datas = [String: String]()
            if let content = content {
                
                let arr = content.componentsSeparatedByString("\n")
                let _ = arr.map({ (item) -> Void in
                    
                    let words = item.componentsSeparatedByString("\t")
                    if words.count > 1 {
                        let key = words[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                        datas[key] = words[1]
                    }
                    
                })
            }
            
            NSKeyedArchiver.archiveRootObject(datas, toFile: NCTools.getFilePath("words"))
        }
        
        
        
    }//函数结束
    
    
    
}//类结束
