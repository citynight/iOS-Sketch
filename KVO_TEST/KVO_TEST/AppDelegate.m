//
//  AppDelegate.m
//  KVO_TEST
//
//  Created by 李小争 on 2020/9/17.
//

#import "AppDelegate.h"
#import "MObject.h"
#import "MObserver.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    MObject *obj = [MObject new];
    MObserver *observer = [MObserver new];
    
    // KVO监听前
    NSLog(@"KVO 监听前: %s",object_getClassName(obj));
    
    // 调用KVO方法监听obj的value属性的变化
    [obj addObserver:observer forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:NULL];
    
    // KVO监听后
    NSLog(@"KVO 监听后: %s",object_getClassName(obj));
    
    // 通过setter方法修改value
    obj.value = 1;
    
    // 通过kvc设置value能否生效?
    [obj setValue:@2 forKey:@"value"]; // 生效了.
    
    // 通过成员变量直接赋值value能否生效?
    [obj increase]; // 没有生效.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
