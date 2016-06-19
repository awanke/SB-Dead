/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : dead

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2016-06-20 00:19:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(64) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `source` int(1) unsigned DEFAULT '0',
  `writer` varchar(64) DEFAULT NULL,
  `content` text,
  `publishDate` datetime DEFAULT NULL,
  `catalogId` int(11) unsigned DEFAULT NULL,
  `pageView` int(11) unsigned DEFAULT NULL,
  `environment` varchar(255) DEFAULT NULL,
  `download` int(11) unsigned DEFAULT NULL,
  `status` int(1) unsigned DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', null, '九度-1465-最简真分数', '', '', '0', 'admin', '来源 [http://ac.jobdu.com/problem.php?pid=1465](http://ac.jobdu.com/problem.php?pid=1465)\r\n\r\n题目描述：\r\n给出n个正整数，任取两个数分别作为分子和分母组成最简真分数，编程求共有几个这样的组合。\r\n输入：\r\n输入有多组，每组包含n（n&lt;=600）和n个不同的整数，整数大于1且小于等于1000。\r\n当n=0时，程序结束，不需要处理这组数据。\r\n输出：\r\n每行输出最简真分数组合的个数。\r\n样例输入：\r\n7\r\n3 5 7 9 11 13 15\r\n3\r\n2 4 5\r\n0\r\n样例输出：\r\n17\r\n2\r\n来源：\r\n2012年北京大学计算机研究生机试真题\r\n\r\n```\r\n#include&lt;iostream&gt;\r\n#include&lt;algorithm&gt;\r\nusing namespace std;\r\n\r\nint a[601];\r\n\r\n// 求最大公约数\r\nint gcd(int x, int y) {\r\n    if (y == 0)\r\n        return x;\r\n    else\r\n        return gcd(y, x % y);\r\n}\r\n\r\nint main() {\r\n    freopen(\"gcd.txt\", \"r\", stdin);\r\n    int n;\r\n    while (scanf(\"%d\", &n), n) {\r\n        for (int i = 0; i &lt; n; ++i)\r\n            scanf(\"%d\", &a[i]);\r\n        // 优化\r\n        sort(a, a + n);\r\n        int count = 0;\r\n        for (int i = 0; i &lt; n; ++i)\r\n            for (int j = i + 1; j &lt; n; ++j)\r\n                if (gcd(a[i], a[j]) == 1)\r\n                    count++;\r\n        printf(\"%d\\n\", count);\r\n    }\r\n}\r\n```', '2016-06-19 22:50:52', '26', '28', 'markdown', '0', '3', '0', '2016-06-18 20:16:27', null, '2016-06-19 22:50:52', null, null);
INSERT INTO `article` VALUES ('2', null, 'elasticsearch java客户端', '', '', '0', 'admin', 'https://github.com/elastic/elasticsearch\r\n\r\nhttps://github.com/searchbox-io/Jest/tree/master/jest', '2016-06-19 21:21:49', '25', '3', 'markdown', '0', '3', '0', '2016-06-19 21:16:14', null, '2016-06-19 21:21:49', null, null);
INSERT INTO `article` VALUES ('3', null, 'App下载Web站点性能优化', '', '', '0', 'admin', 'A公司打算搭建一个Android App下载的Web站点，计划将目前常见的手机APP都放到这个网站上提供下载。因为业务开展初期下载量很小，技术部门就用了1台服务器，给服务器配置了一个公网IP对外进行服务。随着销售部门的推广到位，用户量和下载量呈指数级上载，要求技术部门马上进行改造。如果你是技术部门经理，你会怎么改造这个站点，以满足高负载的需求。\r\n提示：短时间修改网站的代码不现实，其他方面的各种改造建议都可以，建议越多越好。\r\n\r\n解：瓶颈主要有两点个：\r\n1.网络带宽不足\r\n2.磁盘的性能不足\r\n网络带宽不足可以增加带宽；\r\n磁盘性能不足可以\r\n1.负载均衡，用nginx做一个简单的负载均衡，将下载的内容分发到几个服务器，减少每个服务器的负载；\r\n2.将硬盘换成固态硬盘；\r\n3.购买CDN服务；\r\n4.将文件缓存在内存中间', '2016-06-19 21:32:11', '28', '0', 'markdown', '0', '3', '0', '2016-06-19 21:31:57', null, '2016-06-19 21:32:11', null, null);
INSERT INTO `article` VALUES ('4', null, '打印菱形', '', '', '0', 'admin', '```\r\n#include&lt;iostream&gt;\r\n#include&lt;vector&gt;\r\n#include&lt;limits&gt;\r\n#include&lt;cstdio&gt;\r\n#include&lt;algorithm&gt;\r\n#include&lt;fstream&gt;\r\n#include&lt;cstdlib&gt;\r\n#include&lt;cstring&gt;\r\n#include&lt;iomanip&gt;\r\n#include&lt;cmath&gt;\r\nusing namespace std;\r\n\r\nint main() {\r\n////    如果用C语言输入输出流\r\n//#ifndef ONLINE_JUDGE\r\n//  freopen(\"c:/in.txt\", \"r\", stdin);\r\n//  freopen(\"out.txt\", \"w\", stdout);\r\n//#endif\r\n//#ifndef ONLINE_JUDGE\r\n//  fclose(stdin);\r\n//  fclose(stdout);\r\n//#endif\r\n\r\n//  //  如果是C++的文件输入输出流\r\n//  ifstream fin(\"c:/in.txt\");\r\n//  cin.rdbuf(fin.rdbuf());\r\n//  ofstream fout(\"c:/out.txt\");\r\n//  cout.rdbuf(fout.rdbuf());\r\n\r\n//  Pascal assign(input, \'1.in\');\r\n//  reset (input);\r\n//  assign(output, \'1.out\');\r\n//  rewrite (output);\r\n\r\n    cout &lt;&lt; \"请输入你要打印菱形的大小\" &lt;&lt; endl;\r\n    int n;\r\n    int i, j;\r\n    cin &gt;&gt; n;\r\n    for (i = 1; i &lt;= n; ++i) {\r\n        for (j = 1; j &lt;= n - i; ++j)\r\n            cout &lt;&lt; \" \";\r\n        for (j = 1; j &lt;= i; ++j)\r\n            if (j == 1 || j == i)\r\n                cout &lt;&lt; \"* \";\r\n            else\r\n                cout &lt;&lt; \"  \";\r\n        cout &lt;&lt; endl;\r\n    }\r\n    for (i = n - 1; i &gt;= 1; --i) {\r\n        for (j = 1; j &lt;= n - i; ++j)\r\n            cout &lt;&lt; \" \";\r\n        for (j = 1; j &lt;= i; ++j)\r\n            if (j == 1 || j == i)\r\n                cout &lt;&lt; \"* \";\r\n            else\r\n                cout &lt;&lt; \"  \";\r\n        cout &lt;&lt; endl;\r\n    }\r\n    return 0;\r\n}\r\n```', '2016-06-19 22:50:52', '21', '3', 'markdown', '0', '3', '0', '2016-06-19 21:51:20', null, '2016-06-19 22:50:52', null, null);
INSERT INTO `article` VALUES ('5', null, 'wordpress', '', '', '0', 'admin', '主题：\r\n\r\nhttp://www.cnsecer.com/4817.html\r\n\r\nhttp://yusi123.com/wordpress/tutorial\r\n\r\n插件：\r\n\r\n云插件：https://blueandhack.com/plugins/801.html\r\n\r\n关闭自动草稿：http://www.5ycode.com/199\r\n\r\n统计代码：http://blog.csdn.net/techzero/article/details/38088927\r\n\r\n网站插件大全：http://www.patent-cn.com/2010/08/22/43630.shtml', '2016-06-19 22:23:38', '29', '1', 'markdown', '0', '3', '0', '2016-06-19 22:23:13', null, '2016-06-19 22:23:37', null, null);
INSERT INTO `article` VALUES ('6', null, '九度-1048-判断三角形类型', '', '', '0', 'admin', '来源 [http://ac.jobdu.com/problem.php?pid=1048](http://ac.jobdu.com/problem.php?pid=1048)\r\n\r\n题目描述：\r\n\r\n给定三角形的三条边，a,b,c。判断该三角形类型。\r\n输入：\r\n测试数据有多组，每组输入三角形的三条边。\r\n输出：\r\n对于每组输入,输出直角三角形、锐角三角形、或是钝角三角形。\r\n样例输入：\r\n3 4 5\r\n样例输出：\r\n直角三角形\r\n来源：\r\n2009年哈尔滨工业大学计算机研究生机试真题\r\n\r\n```\r\n#include&lt;iostream&gt;\r\n#include&lt;vector&gt;\r\n#include&lt;limits&gt;\r\n#include&lt;cstdio&gt;\r\n#include&lt;algorithm&gt;\r\n#include&lt;fstream&gt;\r\n#include&lt;cstdlib&gt;\r\n#include&lt;cstring&gt;\r\n#include&lt;iomanip&gt;\r\n#include&lt;cmath&gt;\r\nusing namespace std;\r\n\r\ntypedef long long lld;\r\nconst lld M = 100001;\r\n\r\nint main() {\r\n    //  如果用 C语言 输入输出流\r\n    //#ifndef ONLINE_JUDGE\r\n    //  freopen(\"c:/in.txt\", \"r\", stdin);\r\n    //  freopen(\"out.txt\", \"w\", stdout);\r\n    //#endif\r\n    //#ifndef ONLINE_JUDGE\r\n    //  fclose(stdin);\r\n    //  fclose(stdout);\r\n    //#endif\r\n\r\n    // 如果是 C++ 的文件输入输出流\r\n    //  ifstream fin(\"c:/in.txt\");\r\n    //  cin.rdbuf(fin.rdbuf());\r\n    //  ofstream fout(\"c:/out.txt\");\r\n    //  cout.rdbuf(fout.rdbuf());\r\n\r\n    //  Pascal assign(input, \'1.in\');\r\n    //  reset(input);\r\n    //  assign(output, \'1.out\');\r\n    //  rewrite(output);\r\n\r\n    int a, b, c;\r\n    while (scanf(\"%d %d %d\", &a, &b, &c) != EOF) {\r\n        if (a &gt; b) {\r\n            int t = a;\r\n            a = b;\r\n            b = t;\r\n        }\r\n        if (a &gt; c) {\r\n            int t = a;\r\n            a = c;\r\n            c = t;\r\n        }\r\n        if (b &gt; c) {\r\n            int t = b;\r\n            b = c;\r\n            c = t;\r\n        }\r\n        int ans = a * a + b * b - c * c;\r\n        if (ans &gt; 0) {\r\n            printf(\"锐角三角形\\n\");\r\n        } else if (ans == 0) {\r\n            printf(\"直角三角形\\n\");\r\n        } else if (ans &lt; 0) {\r\n            printf(\"钝角三角形\\n\");\r\n        }\r\n    }\r\n    return 0;\r\n}\r\n```', '2016-06-19 22:50:52', '10', '0', 'markdown', '0', '3', '0', '2016-06-19 22:38:09', null, '2016-06-19 22:50:51', null, null);
INSERT INTO `article` VALUES ('7', null, '括号匹配', '', '', '0', 'admin', '判断一个括号字符串是否匹配正确，如果括号有多种，怎么做？如（（[]））正确，[[(()错误。\r\n\r\n```\r\nimport java.util.Stack;\r\n\r\npublic class Solution {\r\n    public boolean isMatch(String str) {\r\n        Stack stack = new Stack();\r\n        for (int i = 0; i &lt; str.length(); ++i) {\r\n            char ch = str.charAt(i);\r\n            // 入栈\r\n            if (ch == \'[\' || ch == \'{\' || ch == \'(\') {\r\n                stack.push(ch);\r\n            } else if (ch == \']\' || ch == \'}\' || ch == \')\') {\r\n                // 判断空栈情况\r\n                if (stack.isEmpty()) {\r\n                    return false;\r\n                }\r\n                // 取出栈顶元素，不立即删除\r\n                char top = (char) stack.peek();\r\n                if (ch == \']\' && top == \'[\' || ch == \'}\' && top == \'{\'\r\n                        || ch == \')\' && top == \'(\') {\r\n                    // 删除栈顶元素\r\n                    stack.pop();\r\n                } else {\r\n                    return false;\r\n                }\r\n            }\r\n        }\r\n        // 空栈\r\n        return stack.isEmpty();\r\n    }\r\n\r\n    public static void main(String[] args) {\r\n        String str = \"{{[test]}}()\";\r\n        Solution solution = new Solution();\r\n        System.out.println(solution.isMatch(str));\r\n    }\r\n}\r\n```', '2016-06-19 22:50:52', '31', '0', 'markdown', '0', '3', '0', '2016-06-19 22:48:16', null, '2016-06-19 22:50:51', null, null);
INSERT INTO `article` VALUES ('8', null, 'hdu-2899-Strange fuction', '', '', '0', 'admin', 'Problem Description\r\nNow, here is a fuction:\r\nF(x) = 6 * x^7+8*x^6+7*x^3+5*x^2-y*x (0 &lt;= x &lt;=100)\r\nCan you find the minimum value when x is between 0 and 100.\r\n\r\nInput\r\nThe first line of the input contains an integer T(1&lt;=T&lt;=100) which means the number of test cases. Then T lines follow, each line has only one real numbers Y.(0 &lt; Y &lt;1e10)\r\n\r\nOutput\r\nJust the minimum value (accurate up to 4 decimal places),when x is between 0 and 100.\r\n\r\nSample Input\r\n2\r\n100\r\n200\r\n\r\nSample Output\r\n-74.4291\r\n-178.8534\r\n\r\nAuthor\r\nRedow\r\n\r\n```\r\n#include&lt;iostream&gt;\r\n#include&lt;vector&gt;\r\n#include&lt;limits&gt;\r\n#include&lt;cstdio&gt;\r\n#include&lt;algorithm&gt;\r\n#include&lt;fstream&gt;\r\n#include&lt;cstdlib&gt;\r\n#include&lt;cstring&gt;\r\n#include&lt;iomanip&gt;\r\n#include&lt;cmath&gt;\r\nusing namespace std;\r\n\r\nconst double precision = 1e-6;\r\n// 求最小值\r\n#define g(x) 6*x*x*x*x*x*x*x+8*x*x*x*x*x*x+7*x*x*x+5*x*x-y*x\r\n\r\n// 转而求一阶导数为0\r\n#define f(x) 42*x*x*x*x*x*x+48*x*x*x*x*x+21*x*x+10*x-y\r\n\r\n// 二阶导数\r\n#define f1(x) 42*6*x*x*x*x*x+48*5*x*x*x*x+42*x+10\r\n\r\ndouble y;\r\n\r\ndouble NewtonRaphson(double x) {\r\n    int k = 1;\r\n    // 括号问题\r\n    while (fabs(f(x)) &gt; precision) {\r\n        x = x - (f(x)) / (f1(x));\r\n        k++;\r\n//        if (k &gt; 30)\r\n//            //超过预定次数，则方法失败；\r\n//            return -1;\r\n    }\r\n    return x;\r\n}\r\n\r\nint main() {\r\n#ifndef ONLINE_JUDGE\r\n    freopen(\"in.txt\", \"r\", stdin);\r\n#endif\r\n    int t;\r\n    cin &gt;&gt; t;\r\n    while (t--) {\r\n        cin &gt;&gt; y;\r\n        int flag = 0;\r\n        double result;\r\n        for (double i = 0.0; i &lt;= 100; ++i) {\r\n            result = NewtonRaphson(i);\r\n            if (result &gt;= 0.0 && result &lt;= 100.0) {\r\n                flag = 1;\r\n                break;\r\n            }\r\n        }\r\n\r\n        if (flag == 0)\r\n            printf(\"No solution!\\n\");\r\n        else\r\n            printf(\"%.4lf\\n\", g(result));\r\n\r\n//      或者这样写\r\n//      printf(\"%.4lf\\n\", g(NewtonRaphson(0.0)));\r\n    }\r\n    return 0;\r\n}\r\n```', '2016-06-19 22:59:33', '30', '0', 'markdown', '0', '3', '0', '2016-06-19 22:58:38', null, '2016-06-19 22:59:33', null, null);
INSERT INTO `article` VALUES ('9', null, '九度-1047-素数判定', '', '', '0', 'admin', '来源 [http://ac.jobdu.com/problem.php?pid=1047](http://ac.jobdu.com/problem.php?pid=1047)\r\n\r\n题目描述：\r\n\r\n给定一个数n，要求判断其是否为素数（0,1，负数都是非素数）。\r\n输入：\r\n测试数据有多组，每组输入一个数n。\r\n输出：\r\n对于每组输入,若是素数则输出yes，否则输入no。\r\n样例输入：\r\n13\r\n样例输出：\r\nyes\r\n来源：\r\n2009年哈尔滨工业大学计算机研究生机试真题\r\n\r\n```\r\n#include&lt;iostream&gt;\r\n#include&lt;vector&gt;\r\n#include&lt;limits&gt;\r\n#include&lt;cstdio&gt;\r\n#include&lt;algorithm&gt;\r\n#include&lt;fstream&gt;\r\n#include&lt;cstdlib&gt;\r\n#include&lt;cstring&gt;\r\n#include&lt;iomanip&gt;\r\n#include&lt;cmath&gt;\r\nusing namespace std;\r\n\r\ntypedef long long lld;\r\nconst lld M = 10001;\r\n\r\nint prime[M];   // 保存筛得的素数\r\nint primeCount;      // 保存素数的个数\r\nbool mark[M];   // 为true时，表示是素数\r\n\r\nvoid isPrime() {\r\n    for (int i = 0; i &lt; M; i++) {\r\n        mark[i] = true;\r\n    }\r\n    mark[0] = false;\r\n    mark[1] = false;\r\n    primeCount = 0;\r\n    for (int i = 2; i &lt; M; i++) {\r\n        if (mark[i] == false)\r\n            continue;\r\n        prime[primeCount++] = i;\r\n        for (int j = i * i; j &lt; M; j += i) {\r\n            mark[j] = false;\r\n        }\r\n    }\r\n}\r\n\r\nint main() {\r\n    //如果用C语言输入输出流\r\n    //#ifndef ONLINE_JUDGE\r\n    //  freopen(\"c:/in.txt\", \"r\", stdin);\r\n    //  freopen(\"out.txt\", \"w\", stdout);\r\n    //#endif\r\n    //#ifndef ONLINE_JUDGE\r\n    //  fclose(stdin);\r\n    //  fclose(stdout);\r\n    //#endif\r\n\r\n    //  如果是C++的文件输入输出流\r\n    //  ifstream fin(\"c:/in.txt\");\r\n    //  cin.rdbuf(fin.rdbuf());\r\n    //  ofstream fout(\"c:/out.txt\");\r\n    //  cout.rdbuf(fout.rdbuf());\r\n\r\n    //  Pascal assign(input, \'1.in\');\r\n    //  reset(input);\r\n    //  assign(output, \'1.out\');\r\n    //  rewrite(output);\r\n\r\n    isPrime();\r\n    int n;\r\n    while (scanf(\"%d\", &n) != EOF) {\r\n        if (n &lt; 0) {\r\n            printf(\"no\\n\");\r\n            continue;\r\n        }\r\n        if (mark[n]) {\r\n            printf(\"yes\\n\");\r\n        } else {\r\n            printf(\"no\\n\");\r\n        }\r\n    }\r\n    return 0;\r\n}\r\n```', '2016-06-20 00:16:53', '10', '0', 'markdown', '0', '3', '0', '2016-06-19 23:08:58', null, '2016-06-20 00:16:53', null, null);
INSERT INTO `article` VALUES ('10', null, '九度-1046-求最大值', '', '', '0', 'admin', '来源 [http://ac.jobdu.com/problem.php?pid=1046](http://ac.jobdu.com/problem.php?pid=1046)\r\n\r\n题目描述：\r\n\r\n输入10个数，要求输出其中的最大值。\r\n输入：\r\n测试数据有多组，每组10个数。\r\n输出：\r\n对于每组输入,请输出其最大值（有回车）。\r\n样例输入：\r\n10 22 23 152 65 79 85 96 32 1\r\n样例输出：\r\nmax=152\r\n来源：\r\n2009年哈尔滨工业大学计算机研究生机试真题\r\n\r\n```\r\n#include&lt;iostream&gt;\r\n#include&lt;vector&gt;\r\n#include&lt;limits&gt;\r\n#include&lt;cstdio&gt;\r\n#include&lt;algorithm&gt;\r\n#include&lt;fstream&gt;\r\n#include&lt;cstdlib&gt;\r\n#include&lt;cstring&gt;\r\n#include&lt;iomanip&gt;\r\n#include&lt;cmath&gt;\r\nusing namespace std;\r\n\r\ntypedef long long lld;\r\nconst lld M = 100001;\r\n\r\nint main() {\r\n    //如果用C语言输入输出流\r\n    //#ifndef ONLINE_JUDGE\r\n    //  freopen(\"c:/in.txt\", \"r\", stdin);\r\n    //  freopen(\"out.txt\", \"w\", stdout);\r\n    //#endif\r\n    //#ifndef ONLINE_JUDGE\r\n    //  fclose(stdin);\r\n    //  fclose(stdout);\r\n    //#endif\r\n\r\n    //  如果是C++的文件输入输出流\r\n    //  ifstream fin(\"c:/in.txt\");\r\n    //  cin.rdbuf(fin.rdbuf());\r\n    //  ofstream fout(\"c:/out.txt\");\r\n    //  cout.rdbuf(fout.rdbuf());\r\n\r\n    //  Pascal assign(input, \'1.in\');\r\n    //  reset(input);\r\n    //  assign(output, \'1.out\');\r\n    //  rewrite(output);\r\n\r\n    int a[10];\r\n    while (scanf(\"%d\", &a[0]) != EOF) {\r\n        for (int i = 1; i &lt; 10; ++i)\r\n            scanf(\"%d\", &a[i]);\r\n        sort(a, a + 10);\r\n        printf(\"max=%d\\n\", a[9]);\r\n    }\r\n    return 0;\r\n}\r\n```', '2016-06-20 00:16:53', '21', '0', 'markdown', '0', '3', '0', '2016-06-19 23:13:38', null, '2016-06-20 00:16:53', null, null);
INSERT INTO `article` VALUES ('11', null, '写出这个数', '', '', '0', 'admin', '读入一个自然数n，计算其各位数字之和，用汉语拼音写出和的每一位数字。\r\n\r\n输入描述:\r\n每个测试输入包含1个测试用例，即给出自然数n的值。这里保证n小于10100。\r\n\r\n输出描述:\r\n在一行内输出n的各位数字之和的每一位，拼音数字间有1 空格，但一行中最后一个拼音数字后没有空格。\r\n\r\n输入例子:\r\n1234567890987654321123456789\r\n\r\n输出例子:\r\nyi san wu\r\n\r\n```\r\n#include&lt;iostream&gt;\r\n#include&lt;vector&gt;\r\n#include&lt;limits&gt;\r\n#include&lt;cstdio&gt;\r\n#include&lt;algorithm&gt;\r\n#include&lt;fstream&gt;\r\n#include&lt;cstdlib&gt;\r\n#include&lt;cstring&gt;\r\n#include&lt;iomanip&gt;\r\n#include&lt;cmath&gt;\r\nusing namespace std;\r\n\r\nint main() {\r\n////    如果用C语言输入输出流\r\n//#ifndef ONLINE_JUDGE\r\n//  freopen(\"c:/in.txt\", \"r\", stdin);\r\n//  freopen(\"out.txt\", \"w\", stdout);\r\n//#endif\r\n//#ifndef ONLINE_JUDGE\r\n//  fclose(stdin);\r\n//  fclose(stdout);\r\n//#endif\r\n\r\n//  //  如果是C++的文件输入输出流\r\n//  ifstream fin(\"c:/in.txt\");\r\n//  cin.rdbuf(fin.rdbuf());\r\n//  ofstream fout(\"c:/out.txt\");\r\n//  cout.rdbuf(fout.rdbuf());\r\n\r\n//  Pascal assign(input, \'1.in\');\r\n//  reset (input);\r\n//  assign(output, \'1.out\');\r\n//  rewrite (output);\r\n\r\n    string str;\r\n    cin &gt;&gt; str;\r\n    int sum = 0;\r\n    for (int i = 0; i &lt; str.length(); ++i)\r\n        sum += str[i] - 48;\r\n    int flag = 1;\r\n    while (sum / flag &gt;= 10)\r\n        flag *= 10;\r\n    string arr[10] = { \"ling\", \"yi\", \"er\", \"san\", \"si\", \"wu\", \"liu\", \"qi\", \"ba\", \"jiu\" };\r\n    while (flag &gt; 0) {\r\n        if (flag == 1)\r\n            cout &lt;&lt; arr[sum / flag];\r\n        else\r\n            cout &lt;&lt; arr[sum / flag] &lt;&lt; \" \";\r\n        sum %= flag;\r\n        flag /= 10;\r\n    }\r\n    return 0;\r\n}\r\n```', '2016-06-20 00:16:53', '21', '0', 'markdown', '0', '3', '0', '2016-06-19 23:21:52', null, '2016-06-20 00:16:53', null, null);
INSERT INTO `article` VALUES ('12', null, '无判断max', '', '', '0', 'admin', '请编写一个方法，找出两个数字中最大的那个。条件是不得使用if-else等比较和判断运算符。\r\n\r\n给定两个int a和b，请返回较大的一个数。若两数相同则返回任意一个。\r\n\r\n测试样例：\r\n1，2\r\n返回：2\r\n\r\n不能使用比较判别等方式来输出两个数的最大值 就需要借助数学运算的方式来解决\r\n如果a&gt;=b，则 (a+b +|a-b|)/2 = (a+b + a – b)/2 = a;\r\n如果a&lt;b， 则 (a+b +|a-b|)/2 = (a+b + b – a)/2 = b;\r\n\r\n```\r\n#include&lt;iostream&gt;\r\n#include&lt;vector&gt;\r\n#include&lt;limits&gt;\r\n#include&lt;cstdio&gt;\r\n#include&lt;algorithm&gt;\r\n#include&lt;fstream&gt;\r\n#include&lt;cstdlib&gt;\r\n#include&lt;cstring&gt;\r\n#include&lt;iomanip&gt;\r\n#include&lt;cmath&gt;\r\nusing namespace std;\r\n\r\nint getMax(int a, int b) {\r\n    return (a + b + abs(a - b)) / 2;\r\n}\r\n\r\nint main() {\r\n////    如果用C语言输入输出流\r\n//#ifndef ONLINE_JUDGE\r\n//  freopen(\"c:/in.txt\", \"r\", stdin);\r\n//  freopen(\"out.txt\", \"w\", stdout);\r\n//#endif\r\n//#ifndef ONLINE_JUDGE\r\n//  fclose(stdin);\r\n//  fclose(stdout);\r\n//#endif\r\n\r\n//  //  如果是C++的文件输入输出流\r\n//  ifstream fin(\"c:/in.txt\");\r\n//  cin.rdbuf(fin.rdbuf());\r\n//  ofstream fout(\"c:/out.txt\");\r\n//  cout.rdbuf(fout.rdbuf());\r\n\r\n//  Pascal assign(input, \'1.in\');\r\n//  reset (input);\r\n//  assign(output, \'1.out\');\r\n//  rewrite (output);\r\n\r\n    printf(\"%d\\n\", getMax(1, 2));\r\n    return 0;\r\n}\r\n```', '2016-06-20 00:16:53', '21', '0', 'markdown', '0', '3', '0', '2016-06-20 00:06:41', null, '2016-06-20 00:16:53', null, null);
INSERT INTO `article` VALUES ('13', null, '回文数', '', '', '0', 'admin', '大家对回文串不陌生吧？一个字符串从前看和从后看如果一样的话，就是回文串。比如“上海自来水来自海上”就是一个回文串。现在我们的问题来了,把一个数字看成字符串,问它是不是一个回文数？这么简单的题目对想要成为小米工程师的你来说肯定不是问题。不过提醒一下哦：时间复杂度和空间复杂度越低的算法，得分越高。\r\nC++：\r\nbool isPalindromeNumber(long num)\r\nJava:\r\nboolean isPalindromeNumber(long num)\r\n示例：12321 -&gt;  true\r\n3     -&gt;  true\r\n133434-&gt;  false\r\n\r\n```\r\nimport java.util.Stack;\r\n\r\npublic class Solution {\r\n    public static boolean isPalindromeNumber(long num) {\r\n        if (num &lt; 0)\r\n            return false;\r\n        int flag = 1;\r\n        while (num / flag &gt;= 10) {\r\n            flag *= 10;\r\n        }\r\n\r\n        while (num != 0) {\r\n            if (num / flag != num % 10)\r\n                return false;\r\n            // 扣除左右两边的数\r\n            num %= flag;\r\n            num /= 10;\r\n            flag /= 100;\r\n        }\r\n        return true;\r\n    }\r\n\r\n    public static void main(String[] args) {\r\n        System.out.println(isPalindromeNumber(123));\r\n        System.out.println(isPalindromeNumber(121));\r\n        System.out.println(isPalindromeNumber(12021));\r\n        System.out.println(isPalindromeNumber(1223));\r\n        System.out.println(isPalindromeNumber(1));\r\n    }\r\n}\r\n```', '2016-06-20 00:16:53', '21', '0', 'markdown', '0', '3', '0', '2016-06-20 00:08:00', null, '2016-06-20 00:16:53', null, null);
INSERT INTO `article` VALUES ('14', null, '九度-1526-朋友圈', '', '', '0', 'admin', '题目描述：\r\n\r\n假如已知有n个人和m对好友关系（存于数字r）。如果两个人是直接或间接的好友（好友的好友的好友…），则认为他们属于同一个朋友圈，请写程序求出这n个人里一共有多少个朋友圈。\r\n假如：n = 5 ， m = 3 ， r = {{1 , 2} , {2 , 3} , {4 , 5}}，表示有5个人，1和2是好友，2和3是好友，4和5是好友，则1、2、3属于一个朋友圈，4、5属于另一个朋友圈，结果为2个朋友圈。\r\n输入：\r\n输入包含多个测试用例，每个测试用例的第一行包含两个正整数 n、m，1=&lt;n，m&lt;=100000。接下来有m行，每行分别输入两个人的编号f，t（1=&lt;f，t&lt;=n），表示f和t是好友。 当n为0时，输入结束，该用例不被处理。\r\n输出：\r\n对应每个测试用例，输出在这n个人里一共有多少个朋友圈。\r\n样例输入：\r\n5 3\r\n1 2\r\n2 3\r\n4 5\r\n3 3\r\n1 2\r\n1 3\r\n2 3\r\n0\r\n样例输出：\r\n2\r\n1\r\n来源：\r\n小米2013年校园招聘笔试题\r\n\r\n```\r\n#include &lt;stdio.h&gt;\r\n#include &lt;iostream&gt;\r\nusing namespace std;\r\n\r\nconst int MAXN = 100001;\r\nint f[MAXN];\r\n//一颗树收取与其等秩的树的次数\r\nint r[MAXN];\r\nint n, m, i;\r\n\r\nvoid makeSet(int x) {\r\n    f[x] = x;\r\n    r[x] = 0;\r\n}\r\n\r\n//带路径压缩查找\r\nint findSet(int x) {\r\n    //递归压缩路径可能会造成溢出栈\r\n    //if(x != f[x])\r\n    //f[x] = findSet(f[x]);\r\n    //return f[x];\r\n\r\n    int t = x;\r\n    //查找树根\r\n    while (x != f[x])\r\n        x = f[x];\r\n    //路径压缩\r\n    while (t != x) {\r\n        int q = f[t];\r\n        f[t] = x;\r\n        t = q;\r\n    }\r\n    return x;\r\n}\r\n\r\n//按秩合并x，y所在的集合\r\nvoid unionSet(int x, int y) {\r\n    x = findSet(x);\r\n    y = findSet(y);\r\n    if (x == y)\r\n        return;\r\n    n--;\r\n\r\n    // 让rank比较高的作为父结点\r\n    if (r[x] &gt; r[y]) {\r\n        f[y] = x;\r\n    } else if (r[x] &lt; r[y]) {\r\n        f[x] = y;\r\n    } else if (r[x] == r[y]) {\r\n        f[x] = y;\r\n        r[y]++;\r\n    }\r\n}\r\n\r\nint main() {\r\n//  freopen(\"c:/in.txt\", \"r\", stdin);\r\n    int a, b;\r\n    while (scanf(\"%d\", &n), n) {\r\n        scanf(\"%d\", &m);\r\n        for (i = 1; i &lt;= n; i++)\r\n            makeSet(i);\r\n        for (i = 0; i &lt; m; i++) {\r\n            scanf(\"%d %d\", &a, &b);\r\n            unionSet(a, b);\r\n        }\r\n        printf(\"%d\\n\", n);\r\n    }\r\n    return 0;\r\n}\r\n```', '2016-06-20 00:16:53', '32', '0', 'markdown', '0', '3', '0', '2016-06-20 00:10:24', null, '2016-06-20 00:16:52', null, null);
INSERT INTO `article` VALUES ('15', null, '模拟登录新浪微博源码(无需加密算法)', '', '', '0', 'admin', '```\r\npackage cn.edu.hfut.dmic.webcollector.weiboapi;\r\n\r\nimport java.util.Set;\r\nimport org.openqa.selenium.Cookie;\r\nimport org.openqa.selenium.WebElement;\r\nimport org.openqa.selenium.htmlunit.HtmlUnitDriver;\r\n\r\n/**\r\n * 代码由WebCollector提供，如果不在WebCollector中使用，需要导入selenium相关jar包\r\n */\r\npublic class WeiboCN {\r\n\r\n    /**\r\n     * 获取新浪微博的cookie，这个方法针对weibo.cn有效，对weibo.com无效\r\n     * weibo.cn以明文形式传输数据，请使用小号\r\n     * @param username 新浪微博用户名\r\n     * @param password 新浪微博密码\r\n     * @return\r\n     * @throws Exception\r\n     */\r\n    public static String getSinaCookie(String username, String password) throws Exception{\r\n        StringBuilder sb = new StringBuilder();\r\n        HtmlUnitDriver driver = new HtmlUnitDriver();\r\n        driver.setJavascriptEnabled(true);\r\n        driver.get(\"http://login.weibo.cn/login/\");\r\n\r\n        WebElement mobile = driver.findElementByCssSelector(\"input[name=mobile]\");\r\n        mobile.sendKeys(username);\r\n        WebElement pass = driver.findElementByCssSelector(\"input[name^=password]\");\r\n        pass.sendKeys(password);\r\n        WebElement rem = driver.findElementByCssSelector(\"input[name=remember]\");\r\n        rem.click();\r\n        WebElement submit = driver.findElementByCssSelector(\"input[name=submit]\");\r\n        submit.click();\r\n\r\n        Set&lt;Cookie&gt; cookieSet = driver.manage().getCookies();\r\n        driver.close();\r\n        for (Cookie cookie : cookieSet) {\r\n            sb.append(cookie.getName()+\"=\"+cookie.getValue()+\";\");\r\n        }\r\n        String result=sb.toString();\r\n        if(result.contains(\"gsid_CTandWM\")){\r\n            return result;\r\n        }else{\r\n            throw new Exception(\"weibo login failed\");\r\n        }\r\n    }\r\n}\r\n```', '2016-06-20 00:16:53', '13', '0', 'markdown', '0', '3', '0', '2016-06-20 00:11:58', null, '2016-06-20 00:16:52', null, null);
INSERT INTO `article` VALUES ('16', null, '九度-1049-字符串去特定字符', '', '', '0', 'admin', '题目描述：\r\n\r\n输入字符串s和字符c，要求去掉s中所有的c字符，并输出结果。\r\n输入：\r\n测试数据有多组，每组输入字符串s和字符c。\r\n输出：\r\n对于每组输入,输出去除c字符后的结果。\r\n样例输入：\r\nheallo\r\na\r\n样例输出：\r\nhello\r\n来源：\r\n2009年哈尔滨工业大学计算机研究生机试真题\r\n\r\n```\r\n#include&lt;cstdlib&gt;\r\n#include&lt;cstring&gt;\r\n#include&lt;cstdio&gt;\r\n#include&lt;iostream&gt;\r\n#include&lt;algorithm&gt;\r\nusing namespace std;\r\n\r\nint main() {\r\n    char *s = (char *) malloc(sizeof(char));\r\n    char c;\r\n    while (scanf(\"%s\", s) != EOF) {\r\n        scanf(\"%c\", &c);\r\n        c = getchar();\r\n        for (int i = 0; i &lt; strlen(s); i++) {\r\n            if (s[i] != c)\r\n                printf(\"%c\", s[i]);\r\n        }\r\n        printf(\"\\n\");\r\n    }\r\n    return 0;\r\n}\r\n```', '2016-06-20 00:16:53', '21', '0', 'markdown', '0', '3', '0', '2016-06-20 00:13:12', null, '2016-06-20 00:16:52', null, null);
INSERT INTO `article` VALUES ('17', null, '福建师大附中-1068-铺地毯', '', '', '0', 'admin', '题目描述\r\n\r\n为了准备一个独特的颁奖典礼，组织者在会场的一片矩形区域（可看做是平面直角坐标系的第一象限）铺上一些矩形地毯，一共有n张地毯，编号从 1 到n。现在将这些地毯按照编号从小到大的顺序平行于坐标轴先后铺设，后铺的地毯覆盖在前面已经铺好的地毯之上。\r\n地毯铺设完成后，组织者想知道覆盖地面某个点的最上面的那张地毯的编号。注意：在矩形地毯边界和四个顶点上的点也算被地毯覆盖。\r\n\r\n![](http://localhost:5566/upload/image/2016/06/20/Lh5tn16aCh.png)\r\n\r\n输入\r\n\r\n输入共 n+2行。\r\n第一行有一个整数n，表示总共有 n张地毯。\r\n接下来的 n行中，第 i+1行表示编号 i的地毯的信息，包含四个正整数 a，b，g，k，每两个整数之间用一个空格隔开，分别表示铺设地毯的左下角的坐标（a，b）以及地毯在 x轴和 y轴方向的长度。\r\n第 n+2 行包含两个正整数 x 和 y，表示所求的地面的点的坐标（x，y）。\r\n\r\n输出\r\n\r\n输出共 1 行，一个整数，表示所求的地毯的编号；若此处没有被地毯覆盖则输出-1。\r\n\r\n样例输入\r\n\r\n3\r\n1 0 2 3\r\n0 2 3 3\r\n2 1 3 3\r\n2 2\r\n样例输出\r\n\r\n3\r\n提示\r\n\r\n数据范围：\r\n30% n&lt;=2\r\n50% 0&lt;=a,b,g,k&lt;=100\r\n100% 0&lt;=n&lt;=10000, 0&lt;=a,b,g,k&lt;=100000\r\nNOIP2011 DAY1 carpet\r\n\r\n来源\r\n\r\nNOIP2011\r\n\r\n```\r\n#include &lt;iostream&gt;\r\n#include&lt;fstream&gt;\r\nusing namespace std;\r\n\r\nconst int N = 10001;\r\n\r\nint main() {\r\n    ifstream fin(\"in.txt\");\r\n    cin.rdbuf(fin.rdbuf());\r\n//  ofstream fout(\"out.txt\");\r\n//  cout.rdbuf(fout.rdbuf());\r\n    int n, a[N], b[N], x[N], y[N], x1, y1;\r\n    cin &gt;&gt; n;\r\n    for (int i = 1; i &lt;= n; ++i)\r\n        cin &gt;&gt; a[i] &gt;&gt; b[i] &gt;&gt; x[i] &gt;&gt; y[i];\r\n    cin &gt;&gt; x1 &gt;&gt; y1;\r\n    for (int i = n; i &gt; 0; --i)\r\n        if (a[i] &lt;= x1 && a[i] + x[i] &gt;= x1 && b[i] &lt;= y1 && b[i] + y[i] &gt;= y1) {\r\n            cout &lt;&lt; i &lt;&lt; endl;\r\n            return 0;\r\n        }\r\n    cout &lt;&lt; -1 &lt;&lt; endl;\r\n    return 0;\r\n}\r\n\r\n#include &lt;iostream&gt;\r\n#include&lt;fstream&gt;\r\nusing namespace std;\r\n\r\nint a, b, x, y, n, arr[10001][10001] = { 0 };\r\n\r\n// 内存溢出\r\nint main() {\r\n    ifstream fin(\"in.txt\");\r\n    cin.rdbuf(fin.rdbuf());\r\n//  ofstream fout(\"out.txt\");\r\n    cin &gt;&gt; n;\r\n    for (int i = 1; i &lt;= n; ++i) {\r\n        cin &gt;&gt; a &gt;&gt; b &gt;&gt; x &gt;&gt; y;\r\n        for (int j = a; j &lt;= a + x; ++j)\r\n            for (int k = b; k &lt;= b + y; ++k)\r\n                arr[j][k] = i;\r\n    }\r\n    cin &gt;&gt; x &gt;&gt; y;\r\n    if (arr[x][y] == 0) {\r\n        cout &lt;&lt; -1;\r\n    } else {\r\n        cout &lt;&lt; arr[x][y];\r\n    }\r\n    return 0;\r\n}\r\n```', '2016-06-20 00:16:53', '21', '1', 'markdown', '0', '3', '0', '2016-06-20 00:16:44', null, '2016-06-20 00:16:52', null, null);

-- ----------------------------
-- Table structure for attachment
-- ----------------------------
DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(255) DEFAULT NULL,
  `size` varchar(64) DEFAULT NULL,
  `downloads` int(11) unsigned DEFAULT '0',
  `url` char(255) DEFAULT NULL,
  `articleId` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of attachment
-- ----------------------------

-- ----------------------------
-- Table structure for catalog
-- ----------------------------
DROP TABLE IF EXISTS `catalog`;
CREATE TABLE `catalog` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `folder` varchar(64) DEFAULT NULL,
  `deep` int(1) unsigned DEFAULT '0',
  `pid` int(11) DEFAULT NULL,
  `pidPath` varchar(255) DEFAULT NULL,
  `sum` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of catalog
-- ----------------------------
INSERT INTO `catalog` VALUES ('1', '算法', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:33:07', null, null, null, null);
INSERT INTO `catalog` VALUES ('2', '基础算法', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:33:20', null, '2016-06-18 19:35:55', null, null);
INSERT INTO `catalog` VALUES ('3', '字符串', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:36:44', null, null, null, null);
INSERT INTO `catalog` VALUES ('4', '数据结构', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:36:59', null, null, null, null);
INSERT INTO `catalog` VALUES ('5', '动态规划', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:37:19', null, null, null, null);
INSERT INTO `catalog` VALUES ('6', '搜索', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:37:37', null, null, null, null);
INSERT INTO `catalog` VALUES ('7', '树论', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:39:19', null, null, null, null);
INSERT INTO `catalog` VALUES ('8', '图论', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:39:25', null, null, null, null);
INSERT INTO `catalog` VALUES ('9', '计算几何', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:39:47', null, null, null, null);
INSERT INTO `catalog` VALUES ('10', '数学', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:39:54', null, null, null, null);
INSERT INTO `catalog` VALUES ('11', '其他', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:40:31', null, null, null, null);
INSERT INTO `catalog` VALUES ('12', '搜索引擎', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:40:55', null, null, null, null);
INSERT INTO `catalog` VALUES ('13', '爬虫', '', '2', '12', '0', '0', '0', '0', '2016-06-18 19:41:06', null, null, null, null);
INSERT INTO `catalog` VALUES ('14', 'hadoop', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:41:29', null, null, null, null);
INSERT INTO `catalog` VALUES ('15', 'spark', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:41:35', null, null, null, null);
INSERT INTO `catalog` VALUES ('16', '数据挖掘', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:41:47', null, null, null, null);
INSERT INTO `catalog` VALUES ('17', '开源项目', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:41:55', null, null, null, null);
INSERT INTO `catalog` VALUES ('18', 'linux', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:42:09', null, null, null, null);
INSERT INTO `catalog` VALUES ('19', '前端', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:42:15', null, null, null, null);
INSERT INTO `catalog` VALUES ('20', '其他', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:42:35', null, '2016-06-18 19:43:21', null, null);
INSERT INTO `catalog` VALUES ('21', '水', '', '3', '2', '0', '0', '0', '0', '2016-06-18 19:44:05', null, '2016-06-19 09:00:05', null, null);
INSERT INTO `catalog` VALUES ('22', '模拟', '', '3', '2', '0', '0', '0', '0', '2016-06-18 23:49:21', null, null, null, null);
INSERT INTO `catalog` VALUES ('23', '查找', '', '3', '2', '0', '0', '0', '0', '2016-06-18 23:49:29', null, null, null, null);
INSERT INTO `catalog` VALUES ('24', '排序', '', '3', '2', '0', '0', '0', '0', '2016-06-18 23:49:44', null, null, null, null);
INSERT INTO `catalog` VALUES ('25', 'elasticsearch', '', '2', '12', '0', '0', '0', '0', '2016-06-19 21:15:27', null, null, null, null);
INSERT INTO `catalog` VALUES ('26', '数论', '', '3', '10', '0', '0', '0', '0', '2016-06-19 21:16:51', null, null, null, null);
INSERT INTO `catalog` VALUES ('27', '面试题', '', '1', '0', '0', '0', '0', '0', '2016-06-19 21:29:26', null, null, null, null);
INSERT INTO `catalog` VALUES ('28', '性能优化', '', '2', '27', '0', '0', '0', '0', '2016-06-19 21:31:35', null, null, null, null);
INSERT INTO `catalog` VALUES ('29', '建站', '', '2', '20', '0', '0', '0', '0', '2016-06-19 22:22:50', null, null, null, null);
INSERT INTO `catalog` VALUES ('30', '牛顿迭代法', '', '3', '10', '0', '0', '0', '0', '2016-06-19 22:43:51', null, null, null, null);
INSERT INTO `catalog` VALUES ('31', '栈', '', '3', '4', '0', '0', '0', '0', '2016-06-19 22:44:14', null, null, null, null);
INSERT INTO `catalog` VALUES ('32', '并查集', '', '3', '4', '0', '0', '0', '0', '2016-06-19 22:44:56', null, null, null, null);

-- ----------------------------
-- Table structure for plan
-- ----------------------------
DROP TABLE IF EXISTS `plan`;
CREATE TABLE `plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `cancelReason` varchar(255) DEFAULT NULL,
  `level` int(1) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of plan
-- ----------------------------

-- ----------------------------
-- Table structure for search_log
-- ----------------------------
DROP TABLE IF EXISTS `search_log`;
CREATE TABLE `search_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keywords` varchar(255) DEFAULT NULL,
  `times` int(11) unsigned DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of search_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `value` varchar(64) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('13', '', 'article:publish', '0', '0', '2016-06-05 12:56:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('19', '', 'permission:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('20', '', 'permission:delete', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('21', '', 'role:delete', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('22', '', 'role:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('23', '', 'user:delete', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('24', '', 'user:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('42', '', 'plan:delete', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('43', '', 'plan:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('44', '', 'article:delete', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('45', '', 'article:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('46', '', 'article:upload', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('47', '', 'attachment:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('48', '', 'attachment:delete', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('49', '', 'system:rebuild', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('50', '', 'catalog:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('51', '', 'system:staticAll', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('52', '', 'system:staticOne', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `value` varchar(64) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', null, 'admin', '0', '0', '2016-06-05 12:56:03', null, '2016-06-05 12:56:03', null, null);
INSERT INTO `sys_role` VALUES ('10', null, 'publisher', '0', '0', '2016-06-05 12:56:03', null, '2016-06-05 12:56:03', null, null);
INSERT INTO `sys_role` VALUES ('11', null, 'user', '0', '0', '2016-06-05 12:56:03', null, '2016-06-05 12:56:03', null, null);
INSERT INTO `sys_role` VALUES ('12', null, 'developer', '0', '0', '2016-06-05 12:56:03', null, '2016-06-05 12:56:03', null, null);

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) DEFAULT NULL,
  `permissionId` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('1', '1', '13', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('2', '1', '19', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('3', '1', '20', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('4', '1', '21', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('5', '1', '22', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('6', '1', '23', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('7', '1', '24', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('8', '1', '42', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('9', '1', '43', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('10', '1', '44', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('11', '1', '45', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('12', '1', '46', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('13', '1', '47', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('14', '1', '48', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('15', '1', '49', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('16', '1', '50', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('17', '1', '51', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('18', '1', '52', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('19', '10', '13', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('20', '10', '44', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('21', '10', '45', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('22', '10', '46', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('23', '10', '47', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('24', '10', '48', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `uid` varchar(64) DEFAULT NULL,
  `source` int(1) DEFAULT NULL COMMENT '用户来源:0为站内注册,1为新浪微博,2为qq登陆',
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '1SOxD7X3fSr0Hs0Wz/KBRhAGZGzel3flrQtuwexsPXc=', 'admin', '', '0', '0', '0', '0', '2016-06-05 12:56:40', null, '2016-06-09 15:28:00', null, null);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1', '1', '1', null, '2016-06-05 12:55:43', null, '2016-06-05 12:55:43', null, null);

-- ----------------------------
-- Function structure for queryChildrenInfo
-- ----------------------------
DROP FUNCTION IF EXISTS `queryChildrenInfo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `queryChildrenInfo`(folderIdPara INT) RETURNS varchar(4000) CHARSET utf8
BEGIN
DECLARE sTemp VARCHAR(4000);
DECLARE sTempChd VARCHAR(4000);

SET sTemp = '$';
SET sTempChd = cast(folderIdPara as char);

WHILE sTempChd is not NULL DO
SET sTemp = CONCAT(sTemp,',',sTempChd);
SELECT group_concat(id) INTO sTempChd FROM sys_catalog where FIND_IN_SET(folder,sTempChd)>0;
END WHILE;
return sTemp;
END
;;
DELIMITER ;
