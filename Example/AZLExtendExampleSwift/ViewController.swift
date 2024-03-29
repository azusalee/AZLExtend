//
//  ViewController.swift
//  AZLExtendExampleSwift
//
//  Created by lizihong on 2021/7/19.
//  Copyright © 2021 azusalee. All rights reserved.
//

import UIKit
import AZLExtendSwift

class ViewController: UIViewController {
    @IBOutlet weak var oriImageView: UIImageView!
    
    @IBOutlet weak var afterImageView: UIImageView!
    
    let oriImage = UIImage(named: "test_image")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.oriImageView.image = self.oriImage
        self.afterImageView.image = self.oriImage
        
        self.oriImageView.isUserInteractionEnabled = true
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(imageDidTap(gesture:)))
        self.oriImageView.addGestureRecognizer(tapGes)
        
//        let controller = TestResponderViewController()
//        self.addChild(controller)
//        self.view.addSubview(controller.view)

//        DispatchQueue.main.asyncAfter(deadline: .now()+3) { 
//            let snapImage = UIImage.azl_imageFrom(view: self.view)
//            let imageView = UIImageView.init(frame: self.view.bounds)
//            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            imageView.contentMode = .top
//            imageView.image = snapImage
//            self.view.addSubview(imageView)
//        }
        
    }
    
    @objc
    func imageDidTap(gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: self.oriImageView)
        
        let scale = self.oriImageView.image!.size.width/self.oriImageView.bounds.size.width
        let newPoint = CGPoint.init(x: point.x*scale, y: point.y*scale)
        let tapColor = self.oriImageView.image?.azl_color(point: newPoint)
        //let tapColor = self.oriImageView.azl_color(point: point)
        
        self.oriImageView.layer.shadowColor = tapColor?.cgColor
        self.oriImageView.layer.shadowOffset = CGSize.init(width: 10, height: 10)
        self.oriImageView.layer.shadowOpacity = 0.5
        self.oriImageView.layer.shadowRadius = 8
        print(tapColor)
    }

    @IBAction func buttonDidTap(_ sender: Any) {
        let actionSheet = UIAlertController.init(title: "选择处理方式", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction.init(title: "缩小", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_scaleImage(size: CGSize.init(width: 272, height: 140))
        }))
        actionSheet.addAction(UIAlertAction.init(title: "放大", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_scaleImage(size: CGSize.init(width: 544*2, height: 281*2))
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "裁剪", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_clipImage(rect: CGRect.init(x: 50, y: 50, width: 200, height: 100))
        }))
        actionSheet.addAction(UIAlertAction.init(title: "圆裁剪", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_clipCircleImage(rect: CGRect.init(x: 50, y: 50, width: 200, height: 100))
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "灰度", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_grayImage()
        }))
        actionSheet.addAction(UIAlertAction.init(title: "灰度渐隐", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_grayAlphaImage()
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "模糊", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_boxBlurImage(blur: 0.5)
        }))
        actionSheet.addAction(UIAlertAction.init(title: "马赛克", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_mosaicImage(level: 8)
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "旋转", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_rotateImage(rotateAngle: 90)
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "水平翻转", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_mirrorImage(isVertical: false)
        }))
        actionSheet.addAction(UIAlertAction.init(title: "垂直翻转", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_mirrorImage(isVertical: true)
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "变色", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_tintImage(color: .red, blendMode: .multiply)
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "圆角裁剪", style: .default, handler: { (action) in
            self.afterImageView.image = self.oriImage?.azl_clipCornerImage(radius: 20)
        }))
        
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

