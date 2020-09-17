//
//  MObject.m
//  KVO_TEST
//
//  Created by 李小争 on 2020/9/17.
//

#import "MObject.h"

@implementation MObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        _value = 0;
    }
    return self;
}
-(void)increase
{
    // 直接为成员变量赋值
    _value += 1;
}

-(void)increase2
{
    // 直接为成员变量赋值
    [self willChangeValueForKey:@"value"];
    _value += 1;
    [self didChangeValueForKey:@"value"];
}
@end
