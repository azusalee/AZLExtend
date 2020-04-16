//
//  UIImage+AZLProcess.h
//  ALExampleTest
//
//  Created by yangming on 2018/7/12.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//圖片處理分類
@interface UIImage (AZLProcess)

///從本地圖片生成對應size的UIImage(這裡的size按dp計算)
+ (UIImage *)azl_imageFromFilePath:(NSString *)path size:(CGSize)pointSize;
///從圖片data生成對應size的UIImage(這裡的size按dp計算)
+ (UIImage *)azl_imageFromData:(NSData *)imgData size:(CGSize)pointSize;
///生成純色圖片，size為1x1的t圖片
+ (UIImage *)azl_imageFromColor:(UIColor *)color;
///生成純色圖片，指定圖片的size
+ (UIImage *)azl_imageFromColor:(UIColor *)color withSize:(CGSize)size;
///從view生成截圖
+ (UIImage *)azl_imageFromView:(UIView *)view;


///生成對應size的UIImage(這裡的size按dp計算)
- (UIImage *)azl_imageFromSize:(CGSize)size;
///生成對應width的UIImage(height會按比例縮放)
- (UIImage *)azl_imageFromWidth:(CGFloat)width;
///裁剪圖片(這裡的size按dp計算)
- (UIImage *)azl_imageClipFromRect:(CGRect)clipRect;
///裁剪圓形圖片(內切圓/橢圓)
- (UIImage *)azl_imageClipCircleFromRect:(CGRect)clipRect;
///生成灰度圖
- (UIImage *)azl_grayImage;
///灰度渐隐
- (UIImage *)azl_grayAlphaImage;
///生成模糊圖
- (UIImage *)azl_imageFromBoxBlur:(CGFloat)blur;
///生成馬賽克圖
- (UIImage *)azl_imageFromMosaicLevel:(NSUInteger)level;
///旋轉圖片(rotateAngle是角度，如90，45)
- (UIImage *)azl_imageFromRotate:(CGFloat)rotateAngle;
///生成水平翻轉圖
- (UIImage *)azl_imageFromMirrorHorizon;
///生成垂直翻轉圖
- (UIImage *)azl_imageFromMirrorVertical;
///生成變色圖片
- (UIImage *)azl_imageWithGradientTintColor:(UIColor *)tintColor;

///獲取圖片上某一像素的色值
- (UIColor *)azl_colorFromPoint:(CGPoint)point;

///獲取圖片的不透明像素所佔比例
- (double)azl_getNoAlphaPixelRate;

///返回一張alpha值翻轉的圖（返回圖片只有alpha通道的值）
- (UIImage *)azl_reverseAlpha;

///边缘描边图
- (UIImage *)azl_sobelBorderImage;


@end
