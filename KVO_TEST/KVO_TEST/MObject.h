//
//  MObject.h
//  KVO_TEST
//
//  Created by 李小争 on 2020/9/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MObject : NSObject

@property(nonatomic, assign) int value;

-(void)increase;
@end

NS_ASSUME_NONNULL_END
