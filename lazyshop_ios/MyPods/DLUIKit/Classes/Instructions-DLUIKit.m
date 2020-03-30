/*
 
 
 
 
 版本：2.2.4
 时间：2017.5.19
 --
 1.修改bug：DLLoading弹出框如果之前调用DLToolTipInWindow方法之后，再调用loading方法，随后定时器会取消loading框
 
 
 
 版本：2.2.3
 时间：2017.4.12
 --
 1.DLAlertShowAnimate弹出动画效果自定义
 
 
 
 版本：2.2.2
 时间：2016.1.17
 --
 1.上层自定义简单的loading加载动画
 
 
 
 版本：2.2.1
 时间：2016.12.14
 --
 1.自定义弹出动画iOS7优化处理
 
 
 
 版本：2.2.0
 时间：2016.12.5
 --
 1.刷新列表的逻辑优化
 2.添加自定义弹出动画类
 
 
 
 版本：2.1.9
 时间：2016.11.1
 --
 1.DLAlertShowView兼容iOS7下的window适配问题
 2.DLAlertShowView添加消失的回调函数
 
 
 
 版本：2.1.8
 时间：2016.10.27
 --
 1.加载更多兼容UICollectionView
 
 
 
 版本：2.1.7
 时间：2016.10.24
 --
 1.弹出浮层view优化连续弹出的效果
 2.自动刷新table支持连续改变加载状态
 3.loading加载框bug修改
 
 
 
 版本：2.1.6
 时间：2016.10.21
 --
 1.弹出浮层view优化
 2.加载动画添加系统loading动画效果
 
 
 
 版本：2.1.5
 时间：2016.10.17
 --
 1.弹出浮层view自定义弹出方向，点击外围自动消失
 
 
 
 版本：2.1.4
 时间：2016.9.7
 --
 1.autoTable读取图片bug修改，doneLoadingTableViewData方法优化
 
 
 
 版本：2.1.2
 时间：2016.9.2
 --
 1.AutoTable执行doneLoadingTableViewData方法，reloadData方法在最前面，以免变化数据源之后调用egoRefreshScrollViewDataSourceDidFinishedLoading方法，位移变化之后可能会执行显示cell的代理，数据有问题就会导致bug
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */
