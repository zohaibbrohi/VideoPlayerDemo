//
//  HelloWorldLayer.m
//  VideoPlayerDemo
//
//  Created by Zohaib Brohi on 26/02/2013.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"PlayVideo" fontName:@"Marker Felt" fontSize:64];
        CCMenuItemLabel *lableItem = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(testCCVideoPlayer)];
        
        CCMenu *menu = [CCMenu menuWithItems:lableItem, nil];
        [menu alignItemsHorizontally];
        [self addChild:menu];
        
        [CCVideoPlayer setDelegate:self];
		
    }
			return self;
}

-(void)testCCVideoPlayer
{
    [CCVideoPlayer playMovieWithFile:@"bait.m4v"];
}

-(void)moviePlaybackFinished
{
    [[CCDirector sharedDirector] startAnimation];
}

#ifdef __IPHONE_OS_VERSION_MAZ_ALLOWED
-(void)updateOrientationWithOrientation:(UIDeviceOrientation)newOrientation
{
    [CCVideoPlayer updateOrientationWithOrientation:newOrientation];
}
#endif
-(void)movieStartsPlaying
{
    [[CCDirector sharedDirector] stopAnimation];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
