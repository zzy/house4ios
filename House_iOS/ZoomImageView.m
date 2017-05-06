//
//  MoveImageView.m
//  MoveImage
//
//  Created by Zhongyu Zhang on 11-12-20.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ZoomImageView.h"

@implementation ZoomImageView

static float minOffset = 0.0;

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		imgView = [[[UIImageView alloc] init] autorelease];
		[self addSubview:imgView];
		
        //使图片视图支持交互和多点触摸
		[imgView setUserInteractionEnabled:YES];
		[imgView setMultipleTouchEnabled:YES];
	}
    
	return self;
}

- (void)dealloc
{
	[img release];
	[imgView release];
    
	[super dealloc];
}

- (void)setImgView:(NSString *)imgPath X:(float)x Y:(float)y Width:(float)width Height:(float)height
{
//  img = [[UIImage alloc]initWithCGImage:_image.CGImage];
    img = [UIImage imageNamed:imgPath];
	[imgView setImage:img];
    [imgView setFrame:CGRectMake(x, y, width, height)];
//	[imgView setNeedsLayout];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if ([touches count] == 2) {
		NSArray* twoTouches=[touches allObjects];
        originSpace = [self spaceToPoint:[[twoTouches objectAtIndex:0] locationInView:self]
                               FromPoint:[[twoTouches objectAtIndex:1] locationInView:self]];
	}
	
    if ([touches count] == 1) {
        UITouch *touch = [touches anyObject];
        gesturePoint = [touch locationInView:self];
        //	NSLog(@”touch:%f,%f”,gestureStartPoint.x,gestureStartPoint.y);
	}
}

//计算两点之间的距离
- (CGFloat)spaceToPoint:(CGPoint)ep FromPoint:(CGPoint)sp
{
	float x = ep.x - sp.x;
	float y = ep.y - sp.y;
    
	return (CGFloat)sqrt(x * x + y * y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count]==2) {
		NSArray* twoTouches=[touches allObjects];
		CGFloat currSpace=[self spaceToPoint:[[twoTouches objectAtIndex:0] locationInView:self]
		                           FromPoint:[[twoTouches objectAtIndex:1] locationInView:self]];
        
		//如果先触摸一根手指，再触摸另一根手指，则触发touchesMoved方法而不是touchesBegan方法
		//此时originSpace应该是0，我们要正确设置它的值为当前检测到的距离，否则可能导致0除错误
		if (originSpace == 0) {
			originSpace=currSpace;
		}
		if (fabsf(currSpace - originSpace) >= minOffset) 
		{//两指间移动距离超过min_offset，识别为手势“捏合”
			CGFloat s=currSpace/originSpace; //计算缩放比例
			[self scaleTo:s];
		}
	}
    
    if ([touches count]==1) {
        UITouch* touch = [touches anyObject];
        CGPoint centerPoint = [touch locationInView:self];
        
        //分别计算x，和y方向上的移动
        CGFloat offsetX = centerPoint.x - gesturePoint.x;
        CGFloat offsetY = centerPoint.y - gesturePoint.y;
        
        //只要在任一方向上移动的距离超过minOffset,判定手势有效
        if(fabsf(offsetX) >= minOffset || fabsf(offsetY) >= minOffset) {
            [self moveToX:offsetX ToY:offsetY];
            
            gesturePoint.x = centerPoint.x;
            gesturePoint.y = centerPoint.y;
        }
    }
}

- (void)scaleTo:(CGFloat)x
{
	scale *= x;
	//缩放限制：>＝0.1，<=10
	scale = (scale < 0.1) ? 0.1 : scale;
	scale = (scale > 10) ? 10 : scale;
	//重设imageView的frame
	[self moveToX:0 ToY:0];
}

-(void)moveToX:(CGFloat)x 
           ToY:(CGFloat)y
{
	CGPoint point=CGPointMake(x, y);
	//重设镜头
	[self resetLens:point];
	imgView.image=[UIImage imageWithCGImage:
                     CGImageCreateWithImageInRect([img CGImage], lensRect)];
	[imgView setFrame:
     CGRectMake(0, 0, lensRect.size.width*scale, lensRect.size.height*scale)];
}

- (void)resetLens:(CGPoint)point
{//设置镜头大小和位置
	CGFloat x,y,width,height;
	//===========镜头初始大小=========
	width=self.frame.size.width/scale;
	height=self.frame.size.height/scale;
	//===========调整镜大小不得超过图像实际大小==========
	if(width>img.size.width)
	{
		width=img.size.width;
	}
	if(height>img.size.height) 
	{
		height=img.size.height;
	}
	//计算镜头移动的位置（等比缩放）
	x=lensRect.origin.x-point.x/scale;
	y=lensRect.origin.y-point.y/scale;
	//左边界越界处理
	x=(x<0)?0:x;
	//上边界越界处理
	y=(y<0)?0:y;
	//右边界越界
	x=(x+width>img.size.width)?img.size.width-width:x;
	//下边界越界处理
	y=(y+height>img.size.height)?img.size.height-height:y;
	//镜头等比缩放
	lensRect=CGRectMake(x, y, width, height);
}

//-(void)moveToX:(CGFloat)x ToY:(CGFloat)y
//{
//	//计算移动后的矩形框，原点x,y坐标，矩形宽高
//	CGFloat rectX = centerX = centerX - x;
//	CGFloat rectY = centerY = centerY - y;
//    CGFloat rectW = self.frame.size.width;
//	CGFloat rectH = self.frame.size.height;
//	
//    if (rectX < 0) { //左边界越界处理
//		centerX = rectX = 0;
//	}
//    
//	if (rectY < 0) { //上边界越界处理
//		centerY = rectY = 0;
//	}
//    
//	if (rectX + rectW > img.size.width) { //右边界越界处理
//		centerX = rectX = img.size.width - rectW;
//	}
//    
//	if (rectY + rectH > img.size.height) { //右边界越界处理
//		centerY = rectY = img.size.height - rectH;
//	}
//    
//	//创建矩形框为本fame
//    CGRect rect = CGRectMake(centerX, centerY, self.frame.size.width, self.frame.size.height);
////	CGRect rect = CGRectMake(rectX, rectY, self.frame.size.width, self.frame.size.height);
//	imgView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([img CGImage], rect)];
//}

@end
