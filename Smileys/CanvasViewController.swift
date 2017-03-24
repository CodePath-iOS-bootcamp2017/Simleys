//
//  CanvasViewController.swift
//  Smileys
//
//  Created by Satyam Jaiswal on 3/23/17.
//  Copyright © 2017 Satyam Jaiswal. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    
    var newlyCreatedFace: UIImageView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFaceOriginalCenter: CGPoint!    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began{
            self.trayOriginalCenter = trayView.center
        }else if sender.state == .changed{
            self.trayView.center = CGPoint(x: self.trayView.center.x, y: self.trayView.center.y + translation.y)
        }else if sender.state == .ended{
            let velocity = sender.velocity(in: view)
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.trayView.center = self.trayDown
                }, completion: nil)
                
                self.arrowImageView.transform = self.arrowImageView.transform.rotated(by: CGFloat(M_PI))
            }else{
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.trayView.center = self.trayUp
                }, completion: nil)
                self.arrowImageView.transform = self.arrowImageView.transform.rotated(by: CGFloat(M_PI))
            }
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        print("didPanFace called")
        if sender.state == .began{
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            UIView.animate(withDuration: 0.2, animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            })
        }else if sender.state == .changed{
            let translation = sender.translation(in: view)
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }else if sender.state == .ended{
            UIView.animate(withDuration: 0.2, animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
