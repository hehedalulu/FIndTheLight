/**
* Copyright (c) 2015-2016 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
* EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
* and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
*/

#import "OpenGLView.h"
#import "AppDelegate.h"
#import "LLPunchModel.h"
#include <iostream>
#include "ar.hpp"
#include "renderer.hpp"

/*
* Steps to create the key for this sample:
*  1. login www.easyar.com
*  2. create app with
*      Name: HelloARVideo
*      Bundle ID: cn.easyar.samples.helloarvideo
*  3. find the created item in the list and show key
*  4. set key string bellow
*/
NSString* key = @"4ITSQ8cDr2gefWBGwmZ6vtwfXfcus7yqt3G0dGHkXwR8CJ8UMwQmQkhyU4SeXrvmAqroNNq3IzEGIuF8ugxPzvtoclyaMbXjpCPa50781c2049291e8125fd6890aff8bcc7dWi3qrhqUwoawWfhWy0yZCCCohj7m4UWPYaMG1nR6S3kfg4dmrNTz365pyHE0QCUqOAt";

namespace EasyAR {
namespace samples {

class HelloARVideo : public AR
{
public:
    HelloARVideo();
    ~HelloARVideo();
    virtual void initGL();
    virtual void resizeGL(int width, int height);
    virtual void render();
    virtual bool clear();
    
    std::string model1;
    std::string model2;
    std::string model3;
    std::string model4;
    std::string model5;
    std::string model6;
    std::string model7;
    std::string model8;
    std::string model9;
    std::string model10;
    std::string model11;
    std::string model12;
    std::string model13;
    std::string model14;
    std::string model15;
    
    
    int picisFind1;//没有扫过1 发射扫过的信号2 已扫过3
    int picisFind2;
    int picisFind3;
    int picisFind4;
    int picisFind5;
    int picisFind6;
    int picisFind7;
    int picisFind8;
    int picisFind9;
    int picisFind10;
    int picisFind11;
    int picisFind12;
    int picisFind13;
    int picisFind14;
    int picisFind15;


    BOOL arControl;
private:
    Vec2I view_size;
    VideoRenderer* renderer[15];
    int tracked_target;
    int active_target;
    int texid[15];
    ARVideo* video;
    VideoRenderer* video_renderer;
};

HelloARVideo::HelloARVideo()
{
    view_size[0] = -1;
    tracked_target = 0;
    active_target = 0;
    for(int i = 0; i < 15; ++i) {
        texid[i] = 0;
        renderer[i] = new VideoRenderer;
    }
    video = NULL;
    video_renderer = NULL;
}

HelloARVideo::~HelloARVideo()
{
    for(int i = 0; i < 15; ++i) {
        delete renderer[i];
    }
}

void HelloARVideo::initGL()
{
    augmenter_ = Augmenter();
    for(int i = 0; i < 15; ++i) {
        renderer[i]->init();
        texid[i] = renderer[i]->texId();
    }
}

void HelloARVideo::resizeGL(int width, int height)
{
    view_size = Vec2I(width, height);
}

void HelloARVideo::render()
{
//    std::cout << lulu << std::endl;
    glClearColor(0.f, 0.f, 0.f, 1.f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    Frame frame = augmenter_.newFrame();
    if(view_size[0] > 0){
        int width = view_size[0];
        int height = view_size[1];
        Vec2I size = Vec2I(1, 1);
        if (camera_ && camera_.isOpened())
            size = camera_.size();
        if(portrait_)
            std::swap(size[0], size[1]);
        float scaleRatio = std::max((float)width / (float)size[0], (float)height / (float)size[1]);
        Vec2I viewport_size = Vec2I((int)(size[0] * scaleRatio), (int)(size[1] * scaleRatio));
        if(portrait_)
            viewport_ = Vec4I(0, height - viewport_size[1], viewport_size[0], viewport_size[1]);
        else
            viewport_ = Vec4I(0, width - height, viewport_size[0], viewport_size[1]);
        if(camera_ && camera_.isOpened())
            view_size[0] = -1;
    }
    augmenter_.setViewPort(viewport_);
    augmenter_.drawVideoBackground();
    glViewport(viewport_[0], viewport_[1], viewport_[2], viewport_[3]);

    AugmentedTarget::Status status = frame.targets()[0].status();
    if(status == AugmentedTarget::kTargetStatusTracked){
        int id = frame.targets()[0].target().id();
        if(active_target && active_target != id) {
            video->onLost();
            delete video;
            video = NULL;
            tracked_target = 0;
            active_target = 0;
        }
        
//        arControl = NO;
        if (arControl) {
            if (!tracked_target) {
                if (video == NULL) {
                    if(frame.targets()[0].target().name() == model1 && texid[0]) {
                        if (picisFind1 == 0) {//第一次识别到
                            picisFind1 = 1;
                        }
//                        std::cout << isFind << std::endl;
                    }
                    else if(frame.targets()[0].target().name() == model2 && texid[1]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[1]);
//                        video_renderer = renderer[1];
                        if (picisFind2 == 0) {//第一次识别到
                            picisFind2 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model3 && texid[2]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[2]);
//                        video_renderer = renderer[2];
                        if (picisFind3 == 0) {//第一次识别到
                            picisFind3 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model4 && texid[3]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[3]);
//                        video_renderer = renderer[3];
                        if (picisFind4 == 0) {//第一次识别到
                            picisFind4 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model5 && texid[4]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[4]);
//                        video_renderer = renderer[4];
                        if (picisFind5 == 0) {//第一次识别到
                            picisFind5 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model6 && texid[5]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[5]);
//                        video_renderer = renderer[5];
                        if (picisFind6 == 0) {//第一次识别到
                            picisFind6 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model7 && texid[6]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[6]);
//                        video_renderer = renderer[6];
                        if (picisFind7 == 0) {//第一次识别到
                            picisFind7 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model8 && texid[7]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[7]);
//                        video_renderer = renderer[7];
                        if (picisFind8 == 0) {//第一次识别到
                            picisFind8 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model9 && texid[8]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[8]);
//                        video_renderer = renderer[8];
                        if (picisFind9 == 0) {//第一次识别到
                            picisFind9 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model10 && texid[9]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[9]);
//                        video_renderer = renderer[9];
                        if (picisFind10 == 0) {//第一次识别到
                            picisFind10 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model11 && texid[10]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[10]);
//                        video_renderer = renderer[10];
                        if (picisFind11 == 0) {//第一次识别到
                            picisFind11 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model12 && texid[11]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[11]);
//                        video_renderer = renderer[11];
                        if (picisFind12 == 0) {//第一次识别到
                            picisFind12 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model13 && texid[12]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[12]);
//                        video_renderer = renderer[12];
                        if (picisFind13 == 0) {//第一次识别到
                            picisFind13 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model14 && texid[13]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[13]);
//                        video_renderer = renderer[13];
                        if (picisFind14 == 0) {//第一次识别到
                            picisFind14 = 1;
                        }
                    }
                    else if(frame.targets()[0].target().name() == model15 && texid[14]) {
//                        video = new ARVideo;
//                        video->openTransparentVideoFile("new_pumkinlamp.mp4", texid[14]);
//                        video_renderer = renderer[14];
                        if (picisFind15 == 0) {//第一次识别到
                            picisFind15 = 1;
                        }
                    }
                }
                if (video) {
                    video->onFound();
                    tracked_target = id;
                    active_target = id;
                }
            }
        }
        
        
        Matrix44F projectionMatrix = getProjectionGL(camera_.cameraCalibration(), 0.2f, 500.f);
        Matrix44F cameraview = getPoseGL(frame.targets()[0].pose());
        ImageTarget target = frame.targets()[0].target().cast_dynamic<ImageTarget>();
        if(tracked_target) {
            video->update();
            video_renderer->render(projectionMatrix, cameraview, target.size());
        }
    } else {
        if (tracked_target) {
            video->onLost();
            tracked_target = 0;
        }
    }
}

bool HelloARVideo::clear()
{
    AR::clear();
    if(video){
        delete video;
        video = NULL;
        tracked_target = 0;
        active_target = 0;
    }
    return true;
}

}
}
EasyAR::samples::HelloARVideo ar;

@interface OpenGLView ()
{
}

@property(nonatomic, strong) CADisplayLink * displayLink;

- (void)displayLinkCallback:(CADisplayLink*)displayLink;

@end

@implementation OpenGLView

+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    frame.size.width = frame.size.height = MAX(frame.size.width, frame.size.height);
    self = [super initWithFrame:frame];
    if(self){
        [self setupGL];

        EasyAR::initialize([key UTF8String]);
        ar.initGL();
    }

    return self;
}

- (void)dealloc
{
    ar.clear();
}

- (void)setupGL
{
    _eaglLayer = (CAEAGLLayer*) self.layer;
    _eaglLayer.opaque = YES;

    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc] initWithAPI:api];
    if (!_context)
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
    if (![EAGLContext setCurrentContext:_context])
        NSLog(@"Failed to set current OpenGL context");

    GLuint frameBuffer;
    glGenFramebuffers(1, &frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);

    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);

    int width, height;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &width);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &height);

    GLuint depthRenderBuffer;
    glGenRenderbuffers(1, &depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, depthRenderBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, width, height);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthRenderBuffer);
}

- (void)start{
    

    

    ar.fontOrNot = NO;
    ar.initCamera();
//    ar.loadAllFromJsonFile("targets.json");
//    ar.loadFromImage("IMG_9356.JPG");
//    ar.loadFromImage("IMG_7365.JPG");
//    ar.loadFromImage("Library_dongjiu3.jpg");
    ARArray = [LLARPicsModel allObjectsInRealm:[RLMRealm defaultRealm]];
    
    
    tempArray = [[NSMutableArray alloc]init];
    Picsarray = [[NSMutableArray alloc]init];
    NSMutableArray *tempScanArray = [[NSMutableArray alloc]init];
    //ar.load这边要求带jpg c++要求不带jpg
    for (int i=0; i<15; i++) {
        LLARPicsModel *model = [ARArray objectAtIndex:i];
        NSString *ARPicString = model.ARPicName;
        const char*LoadImage = [ARPicString UTF8String];
        ar.loadFromImage(LoadImage);
        
        [Picsarray addObject:ARPicString];
        NSArray *array = [ARPicString componentsSeparatedByString:@"."];
        NSString *targetImageName = [array firstObject];
        [tempArray addObject:targetImageName];
        int targetScan = model.HasbeenScan;
        NSString *tempScanString = [NSString stringWithFormat:@"%d",targetScan];
        [tempScanArray addObject:tempScanString];
    }
    
    for (NSString *string in Picsarray) {
        NSLog(@"图片模型的hasscan表%@",string);
        
    }
    for (NSString*string1 in tempArray) {
        NSLog(@"图片模型的.jpg表%@",string1);
    }
    //后期如果改成一张识别图不同模型的话 改model就可以
    const char* target1 = [[tempArray objectAtIndex:0] UTF8String];//Library 东九
    ar.model1 = target1;
    NSString *temp1 = [tempScanArray objectAtIndex:0];
    ar.picisFind1 = [temp1 intValue];
    
    const char* target2 = [[tempArray objectAtIndex:1] UTF8String];//library 东九
    ar.model2 = target2;
    NSString *temp2 = [tempScanArray objectAtIndex:1];
    ar.picisFind2 = [temp2 intValue];
    
    const char* target3 = [[tempArray objectAtIndex:2] UTF8String];//library 中间
    ar.model3 = target3;
    NSString *temp3 = [tempScanArray objectAtIndex:2];
    ar.picisFind3 = [temp3 intValue];
    
    const char* target4 = [[tempArray objectAtIndex:3] UTF8String];//library 中间
    ar.model4 = target4;
    NSString *temp4 = [tempScanArray objectAtIndex:3];
    ar.picisFind4 = [temp4 intValue];
    
    const char* target5 = [[tempArray objectAtIndex:4] UTF8String];//library 中间
    ar.model5 = target5;
    NSString *temp5 = [tempScanArray objectAtIndex:4];
    ar.picisFind5 = [temp5 intValue];
    
    
    const char* target6 = [[tempArray objectAtIndex:5] UTF8String];//教学楼 东九
    ar.model6 = target6;
    NSString *temp6 = [tempScanArray objectAtIndex:5];
    ar.picisFind6 = [temp6 intValue];
    
    const char* target7 = [[tempArray objectAtIndex:6] UTF8String];//教学楼 东九
    ar.model7 = target7;
    NSString *temp7 = [tempScanArray objectAtIndex:6];
    ar.picisFind7 = [temp7 intValue];
    
    const char* target8 = [[tempArray objectAtIndex:7] UTF8String];//教学楼 东九
    ar.model8 = target8;
    NSString *temp8 = [tempScanArray objectAtIndex:7];
    ar.picisFind8 = [temp8 intValue];
    
    const char* target9 = [[tempArray objectAtIndex:8] UTF8String];//教学路 西十二
    ar.model9 = target9;
    NSString *temp9 = [tempScanArray objectAtIndex:8];
    ar.picisFind9 = [temp9 intValue];
    
    const char* target10 = [[tempArray objectAtIndex:9] UTF8String];//教学路 西十二
    ar.model10 = target10;
    NSString *temp10 = [tempScanArray objectAtIndex:9];
    ar.picisFind10 = [temp10 intValue];
    
    const char* target11 = [[tempArray objectAtIndex:10] UTF8String];//食堂 东九
    ar.model11 = target11;
    NSString *temp11 = [tempScanArray objectAtIndex:10];
    ar.picisFind11 = [temp11 intValue];
    
    const char* target12 = [[tempArray objectAtIndex:11] UTF8String];//食堂 东九
    ar.model12 = target12;
    NSString *temp12 = [tempScanArray objectAtIndex:11];
    ar.picisFind12 = [temp12 intValue];
    
    const char* target13 = [[tempArray objectAtIndex:12] UTF8String];//食堂 西十二
    ar.model13 = target13;
    NSString *temp13 = [tempScanArray objectAtIndex:12];
    ar.picisFind13 = [temp13 intValue];
    
    const char* target14 = [[tempArray objectAtIndex:13] UTF8String];//食堂 西十二
    ar.model14 = target14;
    NSString *temp14 = [tempScanArray objectAtIndex:13];
    ar.picisFind14 = [temp14 intValue];
    
    const char* target15 = [[tempArray objectAtIndex:14] UTF8String];//食堂 中间
    ar.model15 = target15;
    NSString *temp15 = [tempScanArray objectAtIndex:14];
    ar.picisFind15 = [temp15 intValue];
    
    NSNotificationCenter  *center = [ NSNotificationCenter  defaultCenter];
    [center addObserver:self selector:@selector(ReceiveNetWorkChange:) name:@"Control" object:nil];
    ar.start();
    
    ar.arControl = YES;
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkCallback:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)ReceiveNetWorkChange:(NSNotification *)notification{
    
    if ([[notification object] isEqualToString:@"NoNet"]) {
        NSLog(@"无网络关闭AR功能");
        ar.arControl = NO;
    }else{
        NSLog(@"有网络开启");
        ar.arControl = YES;
    }
}

- (void)stop
{
    ar.clear();
}

- (void)displayLinkCallback:(CADisplayLink*)displayLink
{
    if (!((AppDelegate*)[[UIApplication sharedApplication]delegate]).active)
        return;

    ar.render();
    
    if (ar.picisFind1 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        self.hasFindPic = YES;
        ar.picisFind1 = 2;
        RLMRealm *realm1 = [RLMRealm defaultRealm];
        [realm1  transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:0]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                    NSLog(@"扫到的模型的名字%@",[Picsarray objectAtIndex:0]);
                }
            }
         [realm1 commitWriteTransaction];
        }];
        
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.LibraryPunchAM = 1;
        }else{
            Punchmodel.LibraryPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];

    }
    if (ar.picisFind2 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm2 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind2 = 2;
        [realm2 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:1]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                    NSLog(@"改变");
                }
            }
            [realm2 commitWriteTransaction];
        }];
        
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.LibraryPunchAM = 1;
        }else{
            Punchmodel.LibraryPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind3 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm3 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind3 = 2;
        [realm3 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:2]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm3 commitWriteTransaction];
        }];
        
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.LibraryPunchAM = 1;
        }else{
            Punchmodel.LibraryPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind4 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm4 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind4 = 2;
        [realm4 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:3]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm4 commitWriteTransaction];
        }];
        
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.LibraryPunchAM = 1;
        }else{
            Punchmodel.LibraryPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind5 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm5 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind5 = 2;
        [realm5 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:4]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm5 commitWriteTransaction];
        }];
        
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.LibraryPunchAM = 1;
        }else{
            Punchmodel.LibraryPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind6 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm6 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind6 = 2;
        [realm6 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:5]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm6 commitWriteTransaction];
        }];
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.TeachPunchAM = 1;
        }else{
            Punchmodel.TeachPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind7 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm7 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind7 = 1;
        [realm7 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:6]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm7 commitWriteTransaction];
        }];
        
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.TeachPunchAM = 1;
        }else{
            Punchmodel.TeachPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind8 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm8 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind8 = 2;
        [realm8 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:7]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm8 commitWriteTransaction];
        }];
        
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.TeachPunchAM = 1;
        }else{
            Punchmodel.TeachPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind9 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm9 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind9 = 1;
        [realm9 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:8]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm9 commitWriteTransaction];
        }];
        
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.TeachPunchAM = 1;
        }else{
            Punchmodel.TeachPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind10 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm10 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind10 = 2;
        [realm10 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:9]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm10 commitWriteTransaction];
        }];
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.TeachPunchAM = 1;
        }else{
            Punchmodel.TeachPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind11 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm11 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind11 = 2;
        [realm11 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:10]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm11 commitWriteTransaction];
        }];
        
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.ResturantPunchAM = 1;
        }else{
            Punchmodel.ResturantPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind12 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm12 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind12 = 2;
        [realm12 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:11]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm12 commitWriteTransaction];
        }];
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.ResturantPunchAM = 1;
        }else{
            Punchmodel.ResturantPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind13 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm13 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind13 = 2;
        [realm13 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:12]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm13 commitWriteTransaction];
        }];
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.ResturantPunchAM = 1;
        }else{
            Punchmodel.ResturantPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind14 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm14 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind14 = 2;
        [realm14 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:13]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm14 commitWriteTransaction];
        }];
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.ResturantPunchAM = 1;
        }else{
            Punchmodel.ResturantPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    if (ar.picisFind15 == 1) {
        __block NSString *test1 = [[NSString alloc]init];
        __block NSString *test2 = [[NSString alloc]init];
        RLMRealm *realm15 = [RLMRealm defaultRealm];
        self.hasFindPic = YES;
        ar.picisFind15 = 2;
        [realm15 transactionWithBlock:^{
            for (LLARPicsModel *model  in ARArray) {
                if ([model.ARPicName isEqualToString:[Picsarray objectAtIndex:14]]) {
                    model.HasbeenScan = 2;
                    test1 = model.ARPicsAMOrPM;
                    test2 = model.ARPicLocation;
                }
            }
            [realm15 commitWriteTransaction];
        }];
        RLMRealm *realmtest = [RLMRealm defaultRealm];
        LLPunchModel *Punchmodel = [[LLPunchModel alloc]init];
        Punchmodel.PunchDate = [self nowdate];
        Punchmodel.PunchPlace = test2;
        if ([test1 isEqualToString:@"AM"]) {
            Punchmodel.ResturantPunchAM = 1;
        }else{
            Punchmodel.ResturantPunchPM = 1;
        }
        [realmtest transactionWithBlock:^{
            [realmtest  addObject:Punchmodel];
            [realmtest commitWriteTransaction];
        }];
    }
    
    (void)displayLink;
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

- (void)resize:(CGRect)frame orientation:(UIInterfaceOrientation)orientation
{
    BOOL isPortrait = FALSE;
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            isPortrait = TRUE;
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            isPortrait = FALSE;
            break;
        default:
            break;
    }
    ar.setPortrait(isPortrait);
    ar.resizeGL(frame.size.width, frame.size.height);
}

- (void)setOrientation:(UIInterfaceOrientation)orientation
{
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
            EasyAR::setRotationIOS(270);
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            EasyAR::setRotationIOS(90);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            EasyAR::setRotationIOS(180);
            break;
        case UIInterfaceOrientationLandscapeRight:
            EasyAR::setRotationIOS(0);
            break;
        default:
            break;
    }
}

-(BOOL)isRightLocation{
    return YES;
}

-(NSString *)nowdate{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *datestr = [formatter stringFromDate:date];
    return datestr;
}

@end
