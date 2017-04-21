# npl-express

这是一个简单易用的 [NPL](https://github.com/LiXizhi/NPLRuntime) Web 应用框架，实现方式参考自 [Express](http://expressjs.com/)，用法也与  [Express](http://expressjs.com/) 基本相似。

所有对 HTTP 的处理操作均采用中间件（middleware）的形式。你也可以为 NPLExpress 开发你自己的中间件。

-----

> ## 创建一个基于 NPLExpress 的 Web 应用程序

（该插件还未更新，敬请期待。。。。。。。。。。。）

* 一、确保你已经为你的 Visual Studio 安装了 NPLLuaLanguageService 插件，如果没有，请下载并安装它：

  [https://marketplace.visualstudio.com/items?itemName=Xizhi.NPLLuaLanguageService](https://marketplace.visualstudio.com/items?itemName=Xizhi.NPLLuaLanguageService)

* 二、使用 Visual Studio 创建一个 Web Application for Express：

  （等待截图中。。。。。。。。）

* 三、项目创建后，Visual Studio 会自动帮我们生成一些基本的文件：

  （等待截图中。。。。。。。。）

* 四、点击 Visual Studio 顶部的 “运行”<img src="https://cloud.githubusercontent.com/assets/14923844/24989598/4bec0d3a-2040-11e7-83a7-6dec56de3704.png" style="vertical-align:middle;height:1.5em" valign="middle" height="22"/> 即可启动项目并在浏览器中打开项目首页：

  （等待截图中。。。。。。。。）
  
    你也可以右键点击项目名，在弹出菜单中选择 “Open Command Prompt Here...”，
    
    （等待截图中。。。。。。。。）
    
    这会打开一个命令行窗口，在该命令行窗口中输入指令 `npl bin/www.npl`并回车：
    
    （等待截图中。。。。。。。。）
    
    同样可以启动项目。但这种方式启动项目后不会自动在浏览器中打开项目首页。你可以在浏览器地址栏中输入 `http://localhost:3000` 来打开项目首页。
    
-----

> ## 模板引擎

NPLExpress 推荐使用 [NPLLustache](https://github.com/caoyongfeng0214/npllustache) 。

模板引擎将作为 NPLExpress 的中间件被引入。如果你希望在你的项目中使用 [NPLLustache](https://github.com/caoyongfeng0214/npllustache) ，可以这样做：

    local express = NPL.load('express');

    local app = express:new();

    app:set('views', 'views');
    app:set('view engine', 'lustache');

代码 `app:set('view engine', 'lustache')` 设置了你的应用将使用  [NPLLustache](https://github.com/caoyongfeng0214/npllustache) 模板引擎，`app:set('views', 'views')` 设置了模板文件所在的路径，即模板文件放置在应用程序的根目录下的 views 目录。

如果你希望使用其它的模板引擎，则只需将 `app:set('view engine', 'lustache')` 的第二个参数改为模板引擎的模块名（包名）即可。必须能通过 `NPL.load('YOURR_MOD_NAME')` 或 `require('YOUR_MOD_NAME')` 加载到该模块。

作为在 NPLExpress 中使用的模板引擎，如果你期望能使用 NPLExpress 的 `render(path, data)` 方法来渲染模板并推送到客户端的话，则该模板引擎必须拥有 `renderFile(path, data)` 方法 和 `render(template, data)` 方法。

`renderFile(path, data)` 方法的第一个参数表示需要转换成 HTML 的模板文件的路径，第二个参数为传递给模板的数据（table）。

`render(template, data)` 方法的第一个参数表示需要转换成 HTML 的模板字符串，第二个参数为传递给模板的数据（table）。

这两个方法都需要能返回转换后的 HTML 字符串。

如果该模板引擎没有以上两种方法，则不能使用 NPLExpress 的 `renderFile(path, data)` 方法，但你可以使用你的模板引擎所提供的方法将模板渲染成 HTML 字符串，然后再使用 NPLExpress 的 `send(html)` 方法将其推送到客户端。

如果该模板引擎需要能被配置，则需提供一个 `config(cnf)` 方法。NPLExpress 会通过该方法将有关针对模板引擎的配置传递给模板引擎，比如设置的模板文件所在的路径。当 `config(cnf)` 方法接收到的参数有个 key 值为 'views' 时，即表示是在设置模板文件所在的路径。

-----

> ## 静态文件

    local express = NPL.load('express');

    local app = express:new();

    app:use(express.static('public'));

以上代码设置了根目录下的 'public' 文件夹是用来存放静态文件的，也可以说，针对静态文件来说 'public' 文件夹就是应用程序的根目录。

还可以在这里默认文件，即当客户端请求的网址是一个目录，不是具体的某个文件，则应该访问的是哪个文件。默认值为 'index.htm'，即，当客户端访问的是网址为 `http://www.domain.com/` 时，实际访问的是 `http://www.domain.com/index.htm` 。可以这样修改此默认值：

    app:use(express.static('public', { default = 'default.htm' }));

这样，当客户端访问的是网址为 `http://www.domain.com/` 时，实际访问的是 `http://www.domain.com/default.htm` 。

本质上，`express.static(...)` 返回的是一个 NPLExpress 的中间件，由此中间件来处理所有针对静态文件的请求。你也可以开发自己的用来处理静态文件的中间件。

-----

> ## session

如果希望在你的应用中使用 session，则需配置 session 中间件：

    app:use(express.session());

建议将此代码写在配置静态文件中间件的代码 `app:use(express.static('public'))` 后面。因为 NPLExpress 是按代码顺序执行中间件的，而针对静态文件的请求是不需要在服务器端操作 session 的。这样处理会在性能上有所优化。

`express.session()` 返回的也是一个中间件，你当然也可以用你自己写的 session 中间件替换它。该方法还能接受以下配置参数：

    app:use(express.session({
        maxAge: 3600, -- session 经过多长时间后会被清除，单位为“秒”。默认值为 86400 。
        domain: nooong.com, -- 设置 session 所作用的域，默认值为 nil ，即只会作用于当前域。
        secure: true -- 是否加密传输。默认值为 false
    }));

你当然也可以在设置某个 session 时单独为其指定以上参数：

    req.session:set({
        name = 'myname',
        value = 'abcdefg',
        maxAge = 3600
    });

在设置 session 时，参数中的 name 和 value 是必须的，其它都是可选的。

根据 session 名取得 session 对象：

    local mysession = req.session:get('myname');

session 对象包含以下属性：

    local mysession = req.session:get('myname');
    local name = mysession.name; -- session 的名字，这里当然返回的是 'myname'（如果 mysession 不为 nil 的话）
    local value = mysession.value; -- 该 session 中存储的数据。
    local maxAge = mysession.maxAge; -- 生命期。
    local domain = mysession.domain; -- 作用域。





