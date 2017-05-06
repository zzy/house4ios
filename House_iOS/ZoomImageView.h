//
//  MoveImageView.h
//  MoveImage
//
//  Created by Zhongyu Zhang on 11-12-20.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomImageView : UIView
{
	UIImage* img;
	UIImageView* imgView;
    
	CGPoint gesturePoint; // 手势开始时起点
//    CGPoint centerPoint; // 现在截取的图片内容的原点
    
//	CGFloat offsetX, offsetY; // 移动时x, y方向上的偏移量
	CGFloat centerX,centerY; // 现在截取的图片内容的原点坐标
    CGFloat originSpace;
    CGRect lensRect; //设置镜头的大小
    CGFloat scale;   //缩放比例
}

- (void)setImgView:(NSString *)imgPath X:(float)x Y:(float)y Width:(float)width Height:(float)height;
- (void)moveToX:(CGFloat)x ToY:(CGFloat)y;
//- (void)scale:(id)sender;
- (void)scaleTo:(CGFloat)x;
- (void)resetLens:(CGPoint)point;
- (CGFloat)spaceToPoint:(CGPoint)ep FromPoint:(CGPoint)sp;

@end
