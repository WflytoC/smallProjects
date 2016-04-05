//
//  NCSheetView.swift
//  NewConcept
//
//  Created by wcshinestar on 4/1/16.
//  Copyright © 2016 com.onesetp.WflytoC. All rights reserved.
//

import UIKit
import AVFoundation

//每个子项的高度
private let kItemHeight: CGFloat = 32.0
//每个子项的宽度
private let kItemWidth: CGFloat = NCConfig.kScreenWidth / 3.0 * 2.0

class NCSheetView: UIView {

    private  var  word: String?
    lazy private var index: Int = {
        
        let result = (self.word! as NSString).rangeOfString("(")
        return result.location
    }()
    
    private var wordLabel: UILabel?
    private var readBtn: UIButton?
    private var dictBtn: UIButton?
    private var okBtn: UIButton?
    private var supView: UIView?
    
    
    init() {
        
        super.init(frame: CGRectMake(0, 0, NCConfig.kScreenWidth, NCConfig.kScreenHeight))
        
        supView = UIView(frame: CGRectMake(NCConfig.kScreenWidth / 6.0,NCConfig.kScreenHeight,kItemWidth, kItemHeight * 3.0))
        supView!.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(supView!)
        
        wordLabel = UILabel(frame: CGRectMake(0.0, 0.0, kItemWidth, kItemHeight))
        wordLabel!.textAlignment = .Center
        
        supView!.addSubview(wordLabel!)
        
        dictBtn = UIButton(frame: CGRectMake(0, 1.0 * kItemHeight, kItemWidth / 2.0, kItemHeight))
        dictBtn!.setTitle("查看词典", forState: .Normal)
        supView!.addSubview(dictBtn!)
        dictBtn!.addTarget(self, action: #selector(NCSheetView.queryWord(_:)), forControlEvents: .TouchUpInside)
        
        readBtn = UIButton(frame: CGRectMake(kItemWidth / 2.0, kItemHeight, kItemWidth / 2.0, kItemHeight))
        readBtn!.setTitle("朗读", forState: .Normal)
        supView!.addSubview(readBtn!)
        readBtn!.addTarget(self, action: #selector(NCSheetView.readWord(_:)), forControlEvents: .TouchUpInside)
        
        okBtn = UIButton(frame: CGRectMake(0.0, 2.0 * kItemHeight, kItemWidth, kItemHeight))
        okBtn!.setTitle("知道啦", forState: .Normal)
        supView!.addSubview(okBtn!)
        okBtn!.addTarget(self, action: #selector(NCSheetView.confirm(_:)), forControlEvents: .TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //触摸视图关闭该单词视图
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        disappearSheet()
    }
    
    
    /**
     
     在指定视图上展示单词视图
     
     - parameter view 该视图的根视图
     - parameter word 需要展示的单词
     
     - returns: 无返回值
 
    */
    func showWordInView(view: UIView,word: String) -> Void {
        
        view.addSubview(self)
        self.word = word
        wordLabel!.text = self.word
        
        UIView.animateWithDuration(1.0) {
            
            
            self.supView!.frame = CGRectMake(NCConfig.kScreenWidth / 6.0, NCConfig.kScreenHeight - 3.0 * kItemHeight, kItemWidth, kItemHeight * 3.0)
            
            
        }
        
    }
    
    /**
     
     使用系统自带的词典查看单词
     
     */
    func queryWord(sender: UIButton) {
        
        
        let reference = UIReferenceLibraryViewController(term: (self.word! as NSString).substringToIndex(self.index))
        (self.superview!.nextResponder() as! UIViewController).presentViewController(reference, animated: true, completion: nil)
        removeFromSuperview()
    }
    
    /**
 
     使用语音朗读单词
     
    */
    func readWord(sender: UIButton) {
        
        let speecher = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: (self.word! as NSString).substringToIndex(self.index))
        speecher.speakUtterance(utterance)
    }
    
    /**
 
     确定按钮关闭视图
     
    */
    func confirm(sender: UIButton) {
        
        disappearSheet()
    }
    
    
    /**
 
     关闭单词视图
     
    */
    func disappearSheet() {
        
        UIView.animateWithDuration(1.0, animations: {
            
            self.supView!.frame = CGRectMake(NCConfig.kScreenWidth / 6.0, NCConfig.kScreenHeight, kItemWidth, kItemHeight * 3.0)
        }) { (Bool) in
            
            self.removeFromSuperview()
        }
    }

}


