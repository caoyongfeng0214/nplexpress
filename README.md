# npl-express

这是一个简单易用的 [NPL](https://github.com/LiXizhi/NPLRuntime) Web 应用框架，实现方式参考自 [Express](http://expressjs.com/)，用法也与  [Express](http://expressjs.com/) 基本相似。

所有对 HTTP 的处理操作均采用中间件（middleware）的形式。你也可以为 NPLExpress 开发你自己的中间件。

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
