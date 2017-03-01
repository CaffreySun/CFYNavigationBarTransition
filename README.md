### CFYNavigationBarTransition是一个设置NavigationBar颜色、透明度、隐藏/显示工具。
##### 详细介绍
使用CFYNavigationBarTransition可以为每个ViewController的NavigationBar设置自己的颜色、透明度、以及隐藏/显示，并且不同样式的NavigationBar在进行push或者pop时，动画过度和谐美观。效果如下：
![竖屏效果](http://om4qlnjqk.bkt.clouddn.com/CFY1.gif "竖屏效果")
![横屏效果](http://om4qlnjqk.bkt.clouddn.com/CFY2.gif "横屏效果")
##### 安装
方法一，直接将CFYNavigationBarTransition拖入代码
方法二，使用Cocoapods，支持iOS 8以上系统
 `pod 'CFYNavigationBarTransition'`

##### 使用
- 改变navigationBar的颜色，调用[viewController cfy\_setNavigationBarBackgroundColor:bgColor]方法。
- 改变navigationBar的透明度，调用[viewController cfy\_setNavigationBarAlpha:alpha]方法.
- 隐藏/显示则直接调用UINavigationController中原生的设置NavigationBar隐藏的方法[navigationController setNavigationBarHidden:]或[navigationController setNavigationBarHidden:animated:]
注意事项：不要设置NavigationBar的translucent为NO，原因是设置了translucent=NO，NavigationBar就不能透明了。
##### 未来加入的功能
- 支持设置每个ViewController的NavigationBar有不同的BackgroundImage
- 支持设置每个ViewController的NavigationBar有不同的ShadowImage
##### 原理
[iOS NavigationBar颜色、透明度、隐藏设置探究](http://www.jianshu.com/p/c7e6ed129b5c "iOS NavigationBar颜色、透明度、隐藏设置探究")