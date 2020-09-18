//
//  NSObject+MYKVO.m
//  KVO_TEST
//
//  Created by 李小争 on 2020/9/17.
//

#import "NSObject+MYKVO.h"
#import <objc/message.h>

/*该实例代码只适用于NSString类型的属性监听。
 如果要监听多种类型的属性，可以参考 AWSimpleKVO
 地址是：https://github.com/hardman/AWSimpleKVO
 */
@implementation NSObject (MYKVO)
//self ==> 被观察者(Person)
//observer ==> 观察者
-(void)my_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    /*
     1.自定义子类
     2.重写setHKProperty,在方法中,调用super的,通知观察者!
     3.修改当前对象的isa指针!!指向自定义的子类!!
     */
    //1.动态的生成一个类!!
    //1.1获取类名
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newClassName =[@"MYKVO_" stringByAppendingString:oldClassName];
    const char *newName = [newClassName UTF8String];
    //创建一个类的Class
    Class MyClass = objc_allocateClassPair([self class], newName, 0);
    //注册类
    objc_registerClassPair(MyClass);
    //2.添加set方法
    NSString *setMathod = [NSString stringWithFormat:@"set%@:",[keyPath capitalizedString]];
    SEL setSelector = NSSelectorFromString(setMathod);
    class_addMethod(MyClass, setSelector, (IMP)setHKProperty, "v@:@");
    //3.修改isa指针
    object_setClass(self, MyClass);
    //4.保存观察者对象
    objc_setAssociatedObject(self, @"MY_objc", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //5.保存keyPath
    objc_setAssociatedObject(self, @"MY_keyPath", keyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//1.调用super的set方法
//2.通知外界!

void setHKProperty(id self,SEL _cmd, NSString *property){
    //保存子类类型
    id class = [self class];
    //改变self的isa指针
    object_setClass(self, class_getSuperclass(class));
    //拿到keypath
    NSString *keyPath = objc_getAssociatedObject(self, @"MY_keyPath");
    //调用父类的set方法!!
    NSString *setMathod = [NSString stringWithFormat:@"set%@:",[keyPath capitalizedString]];
    SEL setSelector = NSSelectorFromString(setMathod);
    
    /*
     Too many arguments to function call, expected 0, have 3
     
     Setting Enable strict checking of objc_msgSend Calls to NO
     https://stackoverflow.com/questions/24922913/too-many-arguments-to-function-call-expected-0-have-3
     
     */
    objc_msgSend(self, setSelector,property);
    //拿到观察者
    id observer = objc_getAssociatedObject(self, @"MY_objc");
    //通知观察者
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:),@"name",self,@{NSKeyValueChangeNewKey:[self valueForKey:@"name"],@"kind:":@1},nil);

    //改回子类类型
    object_setClass(self, class);
}

@end
