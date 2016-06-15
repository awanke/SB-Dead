package cms.web.admin;

import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import cms.myenum.UserEnum;
import cms.web.admin.base.BaseController;
import cms.web.shiro.ShiroRealmImpl;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

//import weibo4j.Account;
//import weibo4j.Oauth;
//import weibo4j.Users;
//import weibo4j.http.AccessToken;
//import weibo4j.org.json.JSONObject;
//import weibo4j.util.WeiboConfig;
import cms.po.User;
import cms.service.UserService;

//import com.qq.connect.api.OpenID;
//import com.qq.connect.api.qzone.UserInfo;
//import com.qq.connect.javabeans.qzone.UserInfoBean;

@Controller
@RequestMapping(value = "/admin")
public class LoginController extends BaseController {
    private static Logger log = Logger.getLogger(LoginController.class);
    @Autowired
    private UserService userService;
    @Autowired
    private ShiroRealmImpl shiroDbRealm;

    @RequestMapping(value = "logout")
    public String logout() {
        Subject currentUser = SecurityUtils.getSubject();
        currentUser.logout();
        return "redirect:/admin/";
    }

    @RequestMapping(value = "welcome")
    public String welcome() {
        return "admin/welcome";
    }

    /**
     * 跳转到登陆页面,如果已登陆,则直接到文章列表页
     */
    @RequestMapping(value = StringUtils.EMPTY)
    public String index() {
        Subject currentUser = SecurityUtils.getSubject();
        if (currentUser.isAuthenticated()) {
            return "redirect:/admin/welcome";
        }
        return "admin/login";
    }

    /**
     * 用户登录,第三方账号如新浪微博和qq登录也会调用此方法
     *
     * @param username 用户名
     * @param password 密码
     * @param encryt   是否对密码加密,第三方账号登录时账号和密码是从数据库中查询的,密码已加密过,不需要再加密
     * @param target   第三方账号登陆是需要指定一个登出成功后的回跳地址
     */
    @RequestMapping(value = "login")
    public String login(
            @RequestParam(value = "username", defaultValue = StringUtils.EMPTY) String username,
            @RequestParam(value = "password", defaultValue = StringUtils.EMPTY) String password,
            @RequestParam(value = "encryt", defaultValue = "true") String encryt,
            @RequestParam(value = "target", defaultValue = StringUtils.EMPTY) String target, Model model) {

        // 用新浪微博,qq登陆时,直接会调用数据库中的账号登陆,这时候是直接使用加密后的密码的,所以无需再加密
        if ("true".equals(encryt)) {
            password = shiroDbRealm.encrytPassword(password);
        }

        try {
            AuthenticationToken token = new UsernamePasswordToken(username, password, true);
            Subject currentUser = SecurityUtils.getSubject();
            currentUser.login(token);
            return StringUtils.isEmpty(target) ? "redirect:/admin/welcome" : "redirect:" + target;
        } catch (AuthenticationException e) {
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("loginerror", "用户名或密码错误!");
            return "admin/login";
        }
    }

//    /**
//     * 新浪微博登录前处理 。
//     */
//    @RequestMapping(value = "beforeLogin4Sina")
//    public String beforeLogin4Sina(@RequestHeader HttpHeaders headers, HttpSession session) {
//        String referer = headers.getFirst("Referer");
//        session.setAttribute("referer", referer);
//        // 要想使用如下注释掉的方法,linux需要安装图形UI,那样会降低服务器性能,我门这里直接调用其对应的url地址。
////		try {
////			Oauth oauth = new Oauth();
////			BareBonesBrowserLaunch.openURL(oauth.authorize("code"));
////		} catch (WeiboException e) {
////			log.error("新浪登陆前处理错误", e);
////		}
//        String clientId = WeiboConfig.getValue("client_ID");
//        String redirectUri = WeiboConfig.getValue("redirect_URI");
//        return "redirect:https://api.weibo.com/oauth2/authorize?client_id="
//                + clientId + "&redirect_uri=" + redirectUri
//                + "&response_type=code";
//    }
//
//    /**
//     * 新浪微博登陆后处理 。
//     */
//    @RequestMapping(value = "afterLogin4Sina")
//    public String afterLogin4Sina(
//            @RequestParam(value = "code", defaultValue = StringUtils.EMPTY) String code,
//            @RequestParam(value = "error", defaultValue = StringUtils.EMPTY) String error,
//            HttpSession session, Model model) {
//
//        // 如果用户取消授权或其他原因导致失败,则直接返回登陆页面
//        if (StringUtils.isNotEmpty(error)) {
//            return "redirect:admin/login";
//        }
//
//        String target = session.getAttribute("referer").toString();
//        session.removeAttribute("referer");
//
//        User user = null;
//        Oauth oauth = new Oauth();
//        try {
//            AccessToken token = oauth.getAccessTokenByCode(code);
//            String accessToken = token.getAccessToken();
//            Account account = new Account(accessToken);
//            JSONObject json = account.getUid();
//            String uid = json.getString("uid");
//            Users users = new Users(accessToken);
//            weibo4j.model.User sinaUser = users.showUserById(uid);
//
//            // 第三方验证只会在登陆时使用,以后调用系统内账号登陆,所以验证成功后即可取消授权,以便在退出登陆后可以重新选择账号授权 。
//            URL url = new URL(
//                    "https://api.weibo.com/oauth2/revokeoauth2?access_token="
//                            + accessToken);
//            url.getContent();
//
//            // 验证通过后,如果库中没有对应用户,则新添加一个
//            user = userService.getByUidAndSource(uid, UserEnum.USER_SOURCE_SINA);
//            if (user == null) {
//                user = new User();
//                this.insertRandomUser(user, sinaUser.getScreenName(), sinaUser
//                        .getProfileImageURL().toString(), uid, UserEnum.USER_SOURCE_SINA);
//            }
//
//            // json全部内容
//            // User [id=1793561022, screenName=起个昵称半小时, name=起个昵称半小时, province=36,
//            // city=1, location=江西 南昌, description=, url=,
//            // profileImageUrl=http://tp3.sinaimg.cn/1793561022/50/1295338153/1,
//            // userDomain=, gender=m, followersCount=0, friendsCount=0, statusesCount=0,
//            // favouritesCount=6, createdAt=Mon Jan 17 10:48:24 CST 2011, following=false,
//            // verified=false, verifiedType=-1, allowAllActMsg=false, allowAllComment=true,
//            // followMe=false, avatarLarge=http://tp3.sinaimg.cn/1793561022/180/1295338153/1,
//            // onlineStatus=0, status=Status [user=null, idstr=0, createdAt=null, id=, text=,
//            // source=null, favorited=false, truncated=false, inReplyToStatusId=-1,
//            // inReplyToUserId=-1, inReplyToScreenName=, thumbnailPic=, bmiddlePic=, originalPic=,
//            // retweetedStatus=null, geo=, latitude=-1.0, longitude=-1.0, repostsCount=0,
//            //commentsCount=0, mid=, annotations=, mlevel=0, visible=null], biFollowersCount=10,
//            // remark=null, lang=zh-cn, verifiedReason=, weihao=, statusId=]
//
//
//        } catch (Exception e) {
//            log.error("新浪微博登陆后处理错误", e);
//            return "redirect:admin/login";
//        }
//
//        return this.login(user.getUsername(), user.getPassword(), "false",
//                target, model);
//    }
//
//    /**
//     * qq登录前处理 。
//     */
//    @RequestMapping(value = "beforeLogin4qq")
//    public String beforeLogin4qq(@RequestHeader HttpHeaders headers,
//                                 HttpServletRequest request, HttpSession session) {
//        String referer = headers.getFirst("Referer");
//        session.setAttribute("referer", referer);
//        String url = null;
//        try {
//            url = new com.qq.connect.oauth.Oauth().getAuthorizeURL(request);
//        } catch (Exception e) {
//            log.error("qq登陆前处理错误", e);
//            return "redirect:admin/login";
//        }
//        return "redirect:" + url;
//    }
//
//    /**
//     * qq登陆后处理 。
//     */
//    @RequestMapping(value = "afterLogin4qq")
//    public String afterLogin4qq(
//            @RequestParam(value = "code", defaultValue = StringUtils.EMPTY) String code,
//            @RequestParam(value = "error", defaultValue = StringUtils.EMPTY) String error,
//            HttpServletRequest request, HttpSession session, Model model) {
//
//        String target = session.getAttribute("referer").toString();
//        session.removeAttribute("referer");
//
//        User user = null;
//        try {
//            com.qq.connect.javabeans.AccessToken accessTokenObj = (new com.qq.connect.oauth.Oauth())
//                    .getAccessTokenByRequest(request);
//            String accessToken = null;
//            String openID = null;
//
//            if (accessTokenObj.getAccessToken().equals("")) {
//                // 我们的网站被CSRF攻击了或者用户取消了授权
//                // 做一些数据统计工作
//                return "redirect:admin/login";
//            }
//            accessToken = accessTokenObj.getAccessToken();
//
//            // 利用获取到的accessToken 去获取当前用的openid -------- start
//            OpenID openIDObj = new OpenID(accessToken);
//            openID = openIDObj.getUserOpenID();
//
//            UserInfo qzoneUserInfo = new UserInfo(accessToken, openID);
//            UserInfoBean userInfoBean = qzoneUserInfo.getUserInfo();
//
//            // 这里无法像新浪微博那样取消授权,因为没有此接口,可能因为在授权后重复登陆时有一个倒计时的功能 。
//
//            // 验证通过后,如果库中没有对应用户,则新添加一个
//            user = userService.getByUidAndSource(openID, UserEnum.USER_SOURCE_QQ);
//            if (user == null) {
//                user = new User();
//                this.insertRandomUser(user, userInfoBean.getNickname(),
//                        userInfoBean.getAvatar().getAvatarURL50(), openID,
//                        UserEnum.USER_SOURCE_QQ);
//            }
//
//        } catch (Exception e) {
//            log.error("qq登陆后处理错误", e);
//            return "redirect:admin/login";
//        }
//
//        return this.login(user.getUsername(), user.getPassword(), "false",
//                target, model);
//    }
//
//    /**
//     * 第三方账号首次登陆,会在数据库中自动生成一个账号,并与之绑定 。
//     *
//     * @param user   属性会被设置到这个对象上
//     * @param name   昵称
//     * @param avatar 用户头像
//     * @param uid    第三方平台的user id
//     * @param source 用户来源
//     */
//    private void insertRandomUser(User user, String name, String avatar, String uid, int source) {
//        // 为第三方用户生成一个数据库中没有用过的用户名,并同时生成一个密码,密码在入库的时候需要经过加密 。
//        String username = null;
//        String password = null;
//
//        // 生成用户名前缀
//        if (source == UserEnum.USER_SOURCE_QQ) {
//            username = "q";
//        } else if (source == UserEnum.USER_SOURCE_SINA) {
//            username = "s";
//        }
//
//        // 生成用户名其他部分
//        while (true) {
//            username += RandomStringUtils.randomNumeric(6);
//            User u = userService.getByUserName(username);
//            if (u == null) break;
//        }
//        password = RandomStringUtils.randomAlphanumeric(8);
//        password = shiroDbRealm.encrytPassword(password);
//
//        user.setUsername(username);
//        user.setPassword(password);
//        user.setName(name);
//        user.setAvatar(avatar);
//        user.setUid(uid);
//        user.setSource(source);
//        userService.insertWithDefaultRole(user);
//    }
}
