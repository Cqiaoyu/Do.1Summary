//
//  TransformController.swift
//  EffectControl
//
//  Created by LJ on 15/7/29.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

import UIKit


protocol TransformControllerDelegate{
    func tranfromDidChange(tranform:CGAffineTransform,sender:AnyObject)
}

struct Vact2D {
    var x: Float
    var y: Float
    var xCG:CGFloat{
        return CGFloat(x)
    }
    var yCG:CGFloat{
        return CGFloat(y)
    }
}

class TransformController: UIViewController {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ratationSlider: UISlider!
    @IBOutlet weak var xTranslationSlider: UISlider!
    @IBOutlet weak var yTranslationSlider: UISlider!
    @IBOutlet weak var xScaleSlider: UISlider!
    @IBOutlet weak var yScaleSlider: UISlider!
    
    var backgroundView:UIVisualEffectView?
    var currentTranform:CGAffineTransform?
    var delegate:TransformControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        println(currentTranform?.a)
        println(currentTranform?.b)
        println(currentTranform?.c)
        println(currentTranform?.d)
        println(currentTranform?.tx)
        println(currentTranform?.ty)
        if currentTranform != nil {
            applyTransformToSliders(currentTranform!)
        }
        backgroundView = prepareVisualEffectView()
        view.addSubview(backgroundView!)
        applyEqualSizeContraits(view, v2: backgroundView!, includeTop: false)
        view.backgroundColor = UIColor.clearColor()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func disMissAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil);
    }
    @IBAction func applyTransformAction(sender:AnyObject){
        let transform = transformFromSliders()
        
        currentTranform = transform
        delegate?.tranfromDidChange(transform, sender: self)
    }
    //添加effect
    func prepareVisualEffectView() -> UIVisualEffectView{
        
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.contentView.backgroundColor = UIColor.clearColor()

        
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        let vibranceEffectView = UIVisualEffectView(effect: vibrancyEffect)
        
        vibranceEffectView.contentView.addSubview(containerView)
        blurEffectView.contentView.addSubview(vibranceEffectView)
        
        containerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blurEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
        vibranceEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
        applyEqualSizeContraits(vibranceEffectView.contentView, v2: containerView, includeTop: true)
        applyEqualSizeContraits(blurEffectView.contentView, v2: vibranceEffectView, includeTop: true)
        
        return blurEffectView

        
    }
    //等于约束
    func applyEqualSizeContraits(v1:UIView,v2:UIView,includeTop:Bool){
        
        v1.addConstraint(NSLayoutConstraint(item: v1, attribute: .Left, relatedBy: .Equal, toItem: v2, attribute: .Left, multiplier: 1, constant: 0))
        v1.addConstraint(NSLayoutConstraint(item: v1, attribute: .Right, relatedBy: .Equal, toItem: v2, attribute: .Right, multiplier: 1, constant: 0))
        v1.addConstraint(NSLayoutConstraint(item: v1, attribute: .Bottom, relatedBy: .Equal, toItem: v2, attribute: .Bottom, multiplier: 1, constant: 0))
        if includeTop {
            v1.addConstraint(NSLayoutConstraint(item: v1, attribute: .Top, relatedBy: .Equal, toItem: v2, attribute: .Top, multiplier: 1, constant: 0))
        }
        
    }
    //根据当前transform改变slider的状态
    func applyTransformToSliders(transform:CGAffineTransform){
        let accecptTransform =  accecptCGAffineTransform(transform)
        ratationSlider.value = accecptTransform.rotation
        xScaleSlider.value = accecptTransform.scale.x
        yScaleSlider.value = accecptTransform.scale.y
        xTranslationSlider.value = accecptTransform.translation.x
        yTranslationSlider.value = accecptTransform.translation.y
    }
    func transformFromSliders() -> CGAffineTransform{
        let scale = Vact2D(x: xScaleSlider.value, y: yScaleSlider.value)
        let translation = Vact2D(x: xTranslationSlider.value, y: yTranslationSlider.value)
        
        return constructTransform(ratationSlider.value, scale: scale, translation: translation)
        
    }
    func constructTransform(rotation:Float,scale:Vact2D,translation:Vact2D) -> CGAffineTransform{
        let rotationTransform = CGAffineTransformMakeRotation(CGFloat(rotation))
        let scaleTransform = CGAffineTransformScale(rotationTransform, scale.xCG, scale.yCG)
        let translationTransform = CGAffineTransformTranslate(scaleTransform, translation.xCG, translation.yCG)
        return translationTransform
        
    }
    func accecptCGAffineTransform(transform:CGAffineTransform) -> (rotation:Float,scale:Vact2D,translation:Vact2D){
        let rotation = Float(atan2(Double(transform.b), Double(transform.a)))
        let translation = Vact2D(x: Float(transform.tx), y: Float(transform.ty))
        let scaleX = sqrt(Double(transform.a * transform.a + transform.c * transform.c))
        let scaleY = sqrt(Double(transform.b * transform.b + transform.d * transform.d))
        let scale = Vact2D(x: Float(scaleX), y: Float(scaleY))
        return (rotation,scale,translation)
    }
}
