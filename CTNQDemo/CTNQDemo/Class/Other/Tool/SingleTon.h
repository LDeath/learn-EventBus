//
//  SingleTon.h
//  完美单例
//
//  Created by on 15/5/25.
//  Copyright (c) 2015年. All rights reserved.
//

//点H宏
#define SingleTonH(methodName) +(instancetype)share##methodName;

//点M宏
#if __has_feature(objc_arc)
#define SingleTonM(methodName)\
static id instence =nil;\
+(instancetype)share##methodName\
{\
instence=[[self alloc]init ];\
return instence;\
}\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
if (instence==nil) {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instence=[super allocWithZone:zone];\
});\
}\
return instence;\
}\
-(instancetype)init\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instence =[super init];\
});\
return instence;\
}

#else

#define SingleTonM(methodName)\
static id instence =nil;\
+(instancetype)share##methodName\
{\
instence=[[self alloc]init ];\
return instence;\
}\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
if (instence==nil) {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instence=[super allocWithZone:zone];\
});\
}\
return instence;\
}\
-(instancetype)init\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instence =[super init];\
});\
return instence;\
}\
-(oneway void)release\
{\
}\
-(instancetype)retain\
{\
return self;\
}\
-(NSUInteger)retainCount\
{\
return 1;\
}
#endif
