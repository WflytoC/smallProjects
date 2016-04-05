//
//  NCDetailController.swift：文章详情
//  NewConcept
//
//  Created by wcshinestar on 3/29/16.
//  Copyright © 2016 com.onesetp.WflytoC. All rights reserved.
//

import UIKit

private let NCNavBarHeight: CGFloat = 76

class NCDetailController: UIViewController {

    var chapter: Int?
    var navContent: UIView?
    var textView: NCTextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        self.navigationController!.navigationBar.hidden = true
        buildNav()
        buildTextView()
        //NCSheetView().showWordInView(self.view, word: "OK")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        
        textView.frame = CGRectMake(0, NCNavBarHeight, self.view.frame.width, self.view.frame.height)
    }
    
    
}

//控制器成为QJSliderBar的代理
extension NCDetailController: QJSliderBarDelegate {
    
        func itemSelectedWithSliderBar(sliderBar: QJSlideBar, selectedIndex: Int) {
            self.textView.filterWordsFromLevel(selectedIndex)
        }
    }

//构建UI界面
extension NCDetailController {
    
    //隐藏状态条
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //自定义导航栏
    func buildNav() {
        
        let navContent = UIView(frame: CGRectMake(0,0,self.view.frame.width,NCNavBarHeight))
        navContent.backgroundColor = NCConfig.NCNavBarColor
        self.view.addSubview(navContent)
        self.navContent = navContent
        
        let backButton = UIButton(frame: CGRectMake(18,0,44,44))
        backButton.setTitle("返 回", forState: .Normal)
        backButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        backButton.addTarget(self, action: #selector(NCDetailController.backPrevious), forControlEvents: .TouchUpInside)
        navContent.addSubview(backButton)
        
        let queryButton = UIButton(frame: CGRectMake(NCConfig.kScreenWidth - 120,0,120,44))
        queryButton.setTitle("显示所有单词", forState: .Normal)
        queryButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        queryButton.addTarget(self, action: #selector(NCDetailController.showAllWords), forControlEvents: .TouchUpInside)
        navContent.addSubview(queryButton)
        
        let levels = QJSlideBar(frame: CGRectMake(0, 44, self.view.frame.width, 32), itemWidth: 64, names: ["0","1","2","3","4","5","6"])
        levels.delegate = self
        levels.backgroundColor = UIColor(red: 0.247, green: 0.737, blue: 0.961, alpha: 1.0)
        navContent.addSubview(levels)
        
    }
    
    //自定义文本框：
    func buildTextView() {
        
        let textView = NCTextView(frame: CGRectMake(0, NCNavBarHeight, self.view.frame.width, self.view.frame.height - NCNavBarHeight))
        self.view.addSubview(textView)
        self.textView = textView
        self.textView!.userInteractionEnabled = true
        self.textView!.showsVerticalScrollIndicator = false
        self.textView!.editable = false
        self.textView!.selectable = false
        self.textView!.tapToGetWord()
        
        
        if let chapter = chapter {
            
            dispatch_async(dispatch_get_global_queue(0, 0), {
                
                NCHandleAttributes.sharedInstance.getTextAttributes(chapter)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.textView!.attributedText = NCHandleAttributes.sharedInstance.attrsString
                    self.textView!.filterWordsFromLevel(0)
                })
                
            })
            
            
        }
        
    }
    

    func backPrevious() {
        
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    /**
     
     显示所有列表单词
     
     */
    func showAllWords() {
        
        self.textView.filterWordsFromLevel(6)
    }

}
