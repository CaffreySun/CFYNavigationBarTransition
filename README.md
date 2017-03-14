# 一个设置NavigationBar颜色、透明度、隐藏/显示工具 — — CFYNavigationBarTransition

## 详细介绍
　　使用CFYNavigationBarTransition可以为每个ViewController的NavigationBar设置自己的颜色、透明度、以及隐藏/显示，并且不同样式的NavigationBar在进行push或者pop时，动画过度和谐美观。效果如下：

![修改NavigationBar样式](https://github.com/CaffreySun/CFYNavigationBarTransition/blob/master/DemoImage/cfydemo1.gif?raw=true "修改NavigationBar样式") ![不同样式的NavigationBar进行pop时的过度](https://github.com/CaffreySun/CFYNavigationBarTransition/blob/master/DemoImage/cfydemo2.gif?raw=true "不同样式的NavigationBar进行pop时的过度")

## 安装
- 方法一，下载代码直接将CFYNavigationBarTransition文件夹拖入工程
- 方法二，使用Cocoapods，支持iOS 8以上系统
 `pod 'CFYNavigationBarTransition'`

## 使用
　　引用：`#import "CFYNavigationBarTransition.h"`，调用一下接口
- 改变navigationBar的颜色，调用:`[viewController cfy\_setNavigationBarBackgroundColor:]`
- 改变navigationBar的背景图，调用:`[viewController cfy\_setNavigationBarBackgroundImage:]`
- 改变navigationBar的透明度，调用:`[viewController cfy\_setNavigationBarAlpha:]`
- 改变navigationBar的ShadowImage，调用:`[viewController cfy\_setNavigationBarShadowImage:]`
- 改变navigationBar的ShadowImage的BackgroundColor，调用:`[viewController cfy\_setNavigationBarShadowImageBackgroundColor:]`
- 隐藏/显示则直接调用UINavigationController中原生的设置NavigationBar隐藏的方法`[navigationController setNavigationBarHidden:]`或`[navigationController setNavigationBarHidden:animated:]`

## 注意
　　注意事项：不要设置NavigationBar的translucent为NO，原因是设置了translucent=NO，NavigationBar就不能透明了。

## 更新列表
#### 1.0.0
- 加入修改bar背景图接口
- 加入修改bar的shadowImage图片接口
- 加入修改bar的shadowImage的背景色接口
- 优化代码逻辑

#### 0.0.3 ~ 0.0.6
- 修复bug

#### 0.0.2
- 修复iOS8上奔溃的问题

#### 0.0.1
- 可修改bar背景色
- 可修改bar透明度
