//
//  XBoundlessScrollView.h
//  XBoundlessScrollView
//
//  Created by LiX i n long on 2018/1/25.
//  Copyright © 2018年 LiX i n long. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CHDLQBoundlessBlockType) {
    CHDLQBoundlessBlockTypeScroll,      //滚动事件
    CHDLQBoundlessBlockTypeClick,       //点击事件
};

@interface XBoundlessScrollView : UIScrollView

/**< 自动滚动时间间隔 默认为3s 值小于等于0时不自动滚 */
@property (nonatomic) NSTimeInterval scrollInterval;
/**< showView 把所需要展示的view数据源给过来就可以展示 frame自动变为当前frame大小*/
@property (nonatomic, strong) NSArray<UIView *> *showViews;
/**< 滚动到到某个页面或者点击的时候的回调*/
@property (nonatomic, copy) void(^boundlessBlock)(CHDLQBoundlessBlockType blockType, NSInteger index);

@end
