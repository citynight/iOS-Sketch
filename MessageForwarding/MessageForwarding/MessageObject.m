//
//  MessageObject.m
//  MessageForwarding
//
//  Created by 李小争 on 2020/9/24.
//

#import "MessageObject.h"

@implementation MessageObject

#pragma mark - 0. 默认实现方式
//- (void)sendMessage:(NSString *)message {
//    NSLog(@"正常实现:  sendMessage:%@",message);
//}

#pragma mark - 1. Method Resolution
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(sendMessage:)) {
        // 如果不处理进入消息转发 -forwardingTargetForSelector
        NSLog(@"resolveInstanceMethod:");
        return NO;
    }else {
        return [super resolveInstanceMethod:sel];
    }
}

#pragma mark - 2. Fast Forwarding
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector:");
    
    // 如果不处理进入-methodSignatureForSelector
    return nil;
}

#pragma mark - 3. Normal Forwarding
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    NSLog(@"methodSignatureForSelector:");
    if (aSelector == @selector(sendMessage:)) {
        // v 表示方式值是void 类型
        // @ 表示第一个参数是id类型,即 self
        // : 表示第二个参数是SEL类型,即 @selector(sendMessage:)
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }else {
        return [super methodSignatureForSelector:aSelector];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation:");
}
@end
