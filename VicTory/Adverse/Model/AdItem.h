//
//  AdItem.h
//  VicTory
//
//  Created by 陈沛 on 2019/9/6.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdItem : NSObject
@property (nonatomic,strong) NSString *w_picurl;
@property (nonatomic,strong) NSString *ori_picurl;
@property (nonatomic,strong) NSString *winurl;
@property (nonatomic,assign) CGFloat w;
@property (nonatomic,assign) CGFloat h;

@end

NS_ASSUME_NONNULL_END
