//
//  Post.h
//  VicTory
//
//  Created by Apui on 2019/9/27.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PostType) {
    
    PostTypeAll = 1,          //全部
    PostTypePicture = 10,     //图片
    PostTypeWord = 29,        //纯文字
    PostTypeVoice = 31,       //音频
    PostTypeVideo = 41        //视频
};

@interface Post : NSObject

@property (nonatomic, copy) NSString *name;                //用户名
@property (nonatomic, copy) NSString *profile_image;        //头像
@property (nonatomic, copy) NSString *text;                //正文
@property (nonatomic, copy) NSString *passtime;            //发帖时间

@property (nonatomic, assign) NSInteger ding;              //点赞数
@property (nonatomic, assign) NSInteger cai;               //不喜欢数量
@property (nonatomic, assign) NSInteger repost;            //转发数
@property (nonatomic, assign) NSInteger comment;           //评论数

@property (nonatomic, assign) NSInteger type;              //帖子的类型

@property (nonatomic, assign) NSInteger width;     //服务器返回的图片的宽度(像素）

@property (nonatomic, assign) NSInteger height;    //服务器返回的图片的高度（像素）

@property (nonatomic, strong) NSArray *top_cmt;        //最热评论

@property (nonatomic, copy) NSString *image0;           //小图

@property (nonatomic, copy) NSString *image2;           //中图
 
@property (nonatomic, copy) NSString *image1;           //大图

@property (nonatomic, assign) BOOL is_gif;              //是否是动图

@property (nonatomic, assign) NSInteger voicetime;     //音频时长

@property (nonatomic, assign) NSInteger videotime;     //视频时长

@property (nonatomic, assign) NSInteger playcount;     //音频\视频的播放次数

#pragma mark - extra properties

//额外增加的属性，并非服务器返回的属性，根据当前模型计算出来的cell高度
@property (nonatomic, assign) CGFloat cellHeight;
//中间音视频/图片的frame
@property (nonatomic, assign) CGRect middleFrame;

@property (nonatomic, assign,getter=isLongPicture) BOOL isLongPicture;
@end

NS_ASSUME_NONNULL_END
