//
//  MObserver.m
//  KVO_TEST
//
//  Created by 李小争 on 2020/9/17.
//

#import "MObserver.h"
#import "MObject.h"

@implementation MObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[MObject class]] && [keyPath isEqualToString:@"value"]) {
        // 获取value的新值
        NSNumber *valueNum = [change valueForKey:NSKeyValueChangeNewKey];
        NSLog(@"value is %@",valueNum);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
