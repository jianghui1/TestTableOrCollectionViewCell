做过 **iOS** 开发的，一般都使用过 `UITableView` `UICollectionView`，也就会用到 `UITableViewCell` `UIColletionViewCell`，在 **iOS14** 之前，使用`UITableViewCell` 或者 `UICollectionViewCell` 添加控件的时候，不管使用 `[self addSubview:];` 还是使用 `[self.contentView addSubview:];`，最后的视图层级都是一样的。但是在 **iOS14** 上，视图层级发生了一些变化。而这个变化，会影响到 `cell` 上面子控件的点击。

在 **iOS14** 之前，不管是 `UITableViewCell` 还是 `UICollectionViewCell`，不管使用 `self` 还是 `self.contentView` 亦或是 xib 添加控件，最后的视图层级由下到上都是 `cell - contentView - custom subviews`，其中 `custom subviews` 代表自己添加的控件。

在 **iOS14** 上，`UITableViewCell` 和 `UICollectionViewCell` 的视图层级已经不一样了。

先看下 `UITableViewCell`

* 代码创建 `cell`
    * 不添加任何控件，系统会自动创建出 `contentView`，视图层级由下到上为`cell - contentView`
    * 如果使用 `[self addSubview:];` 添加控件，视图层级由下到上会变成 `cell - custom subviews - contentView`，这时候添加的控件在 `contentView` 下面，如果子控件有点击事件，会被 `contentView` 阻断掉
    * 如果使用 `[self.contentView addSubview:];` 添加控件，视频层级由下到上会变成 `cell - contentView - custom subviews`，这时候跟   **iOS14** 之前是一致的。

* **xib** 创建 `cell`
    * 由于在 **xib** 中，添加的控件全部是在 `contentView` 上的，所以跟 **iOS14** 是一致的，视图层级由下到上为 `cell - contentView - custom subviews`

继续看 `UICollectionViewCell`

* 代码创建 `cell`
    * 不添加任何控件，系统不会自动创建 `contentView`，此时只有 `cell`;
    * 如果使用 `[self addSubview:];` 添加控件，视图层级由下到上会变成 `cell - custom subviews`
    * 如果使用 `[self.contentView addSubview:];` 添加控件，视图层级由下到上会变成 `cell - contentView - custom subviews`
    
 
* **xib** 创建 `cell`
    * 在 **xib** 中，不会显示出 `contentView`，直观上看到的就是控件直接加到了 `cell` 上，但是运行之后，系统还是自动创建出 `contentView`，视图层级由下到上是 `Cell - contentView - added subviews`

所以，**iOS14** 上面，`UITableViewCell` `UICollectionViewCell` 偷偷的变化了。如果之前有使用 `[self addSubview:];` 这个方法直接添加视图，可能就会发现界面看起来没有任何问题，但是 `UITableViewCell` 里面的点击事件单单在 **iOS14** 上无效了。那解决方案就是使用 `[self.contentView addSubview:];` 替代 `[self addSubview:];`。

其实，通过上面不同情况的对比，可以发现不同层级确实不会影响显示效果，而是会影响 `cell` 子控件的点击效果，而且仅仅是 `UITableViewCell` 才会出现这种问题。不过随着系统的继续迭代，`UICollectionViewCell` 会不会发生变化就不一定了。

而且，使用 **xib** 创建 `cell` 的话，表现跟 **iOS14** 之前是一致的，并且使用 `[self.contentView addSubview:];` 也是一致的。

还有，系统规范也已经说明了：

    // UITableViewCell
    // Custom subviews should be added to the content view.
    @property (nonatomic, readonly, strong) UIView *contentView;
    
    // UICollectionViewCell
    @property (nonatomic, readonly) UIView *contentView; // add custom subviews to the cell's contentView
    
所以，我们不管是为了解决目前遇到的问题，还是为了防止以后再次出现这种问题，都应该使用 `[self.contentView addSubview:];` 添加控件。

我自己做了个 demo ，运行可以清楚的看到不同情况下的效果，地址在[这里](https://github.com/jianghui1/TestTableOrCollectionViewCell/tree/main)，需要的可以点击下载。
