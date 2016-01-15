//
//  ViewController.swift
//  VideoHelpScreenDemo
//
//  Created by mac on 15/01/16.
//  Copyright © 2016 Inwizards. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer



extension UINavigationController {
    public override func shouldAutorotate() -> Bool {
        return visibleViewController!.shouldAutorotate()
    }
}

class ViewController: UIViewController,UIScrollViewDelegate {

    
    @IBOutlet weak var TITLE: UILabel!
    @IBOutlet weak var btnLoginLogout: UIButton!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var HeaderLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var logoImage: UIImageView!
    var moviePlayer : MPMoviePlayerController!
    
    override func shouldAutorotate() -> Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.PlayVideo()
        self.loadCustomiseUI()
        self.navigationController?.navigationBarHidden = true
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "moveToNextPage", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    // Mark: Function Call For Video Play.
    func PlayVideo(){
        let path = NSBundle.mainBundle().pathForResource("video", ofType:"mp4")
        let url = NSURL.fileURLWithPath(path!)
        self.moviePlayer = MPMoviePlayerController(contentURL: url)
        if let player = self.moviePlayer {
            player.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-49)
            player.view.sizeToFit()
            player.scalingMode = MPMovieScalingMode.Fill
            player.fullscreen = true
            player.controlStyle = MPMovieControlStyle.None
            player.movieSourceType = MPMovieSourceType.File
            player.repeatMode = MPMovieRepeatMode.One
            player.play()
            player.view.sendSubviewToBack(self.view)
            self.view.addSubview(player.view)
        }
    }
    func loadCustomiseUI(){
        let contentView = UIView(frame: CGRectMake(0, self.view.frame.size.height-149, self.view.frame.size.width,100))
        contentView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        self.view.addSubview(contentView)
        self.view.addSubview(pageControl)
        TitleLbl.text = "This is test status message of video help screen.by inwizards Inc."
        HeaderLbl.text = "WELCOME"
        self.view.addSubview(TitleLbl)
        self.view.addSubview(HeaderLbl)
        self.scrollView.frame = CGRectMake(0,self.view.frame.size.height-150, self.view.frame.size.width,100)
        self.view.addSubview(scrollView)
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 4, self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        self.view.addSubview(pageControl)
        self.scrollView.pagingEnabled = true
        self.scrollView.scrollEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.view.addSubview(TITLE)
        self.view.addSubview(logoImage)
    }
    
    func moveToNextPage (){
        let pageWidth:CGFloat = CGRectGetWidth(self.scrollView.frame)
        let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        var slideToX = contentOffset + pageWidth
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
        }
        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.scrollView.frame)), animated: true)
    }
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        if Int(currentPage) == 0{
            HeaderLbl.text = "WELCOME"
            TitleLbl.text = "This is test status message of video help screen."
        }else if Int(currentPage) == 1{
            HeaderLbl.text = "TITLE 1"
            TitleLbl.text = "Enter your Help title here for display on screen."
        }else if Int(currentPage) == 2{
            HeaderLbl.text = "TITLE 2"
            TitleLbl.text = "Enter your Help title here for display on screen."
        }else{
            HeaderLbl.text = "TITLE 3"
            TitleLbl.text = "Enter your Help title here for display on screen."
        }
    }
}

