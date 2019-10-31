<%--
  Created by IntelliJ IDEA.
  User: ZERO
  Date: 2019/6/22
  Time: 12:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>李同的主页</title>
    <meta name=“viewport” content=“width=device-width; initial-scale=1.0”>

    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="icon" href="image/lt.ico" />
    <link rel="stylesheet" href="styles/style.css" media="screen" />
    <link rel="stylesheet" href="styles/media-queries.css" />
    <link rel="stylesheet" href="./flex-slider/flexslider.css" type="text/css" media="screen" />
    <link href="styles/prettyPhoto.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="styles/tipsy.css" rel="stylesheet" type="text/css" media="screen" />

    <script type="text/javascript" src="scripts/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="flex-slider/jquery.flexslider-min.js"></script>
    <script src="scripts/jquery.prettyPhoto.js" type="text/javascript"></script>
    <script src="scripts/jquery.tipsy.js" type="text/javascript"></script>
    <script src="scripts/jquery.knob.js" type="text/javascript"></script>
    <script type="text/javascript" src="scripts/jquery.isotope.min.js"></script>
    <script type="text/javascript" src="scripts/jquery.smooth-scroll.min.js"></script>
    <script type="text/javascript" src="scripts/waypoints.min.js"></script>
    <script type="text/javascript" src="scripts/setup.js"></script>
    <base target="_blank" />
    <script type="text/javascript">
        //Setup flex slider
        $(window).load(function () {
            $('.gf-slider').flexslider();

        });
        //Setup Page

        $(document).ready(function () {
            //Initialize PrettyPhoto here
            $("a[rel^='prettyPhoto']").prettyPhoto({ animation_speed: 'normal', theme: 'facebook', slideshow: 3000, autoplay_slideshow: false, social_tools: false 	});

            //Remove this line if you want to naviagate to url on each client box click
            $('#clients.grid a').click(function(){return false;});
            //Initialize jQuery knob here
            $(".knob").knob();
            //Initialie tipsy here
            $('#fb').tipsy({ gravity: 'n', fade: true });
            $('#tw').tipsy({ gravity: 'n', fade: true });
            $('#ld').tipsy({ gravity: 'n', fade: true });
            /* smooth-scroll */
            $("ul#navigation a").smoothScroll({
                afterScroll: function () {
                    $('ul#navigation a.active').removeClass('active');
                    $(this).addClass('active');
                }
            });

            //Scroll
            $('div.page').waypoint(function () {
                var id = $(this).attr('id');

                $('ul#navigation a.active').removeClass('active');
                $('ul#navigation a[href="#' + id + '"]').addClass('active');
            });

            /* fixes */
            $(window).scroll(function () {
                if ($(window).scrollTop() === 0) {
                    $('ul#navigation a.active').removeClass('active');
                    $('ul#navigation a[href="#home"]').addClass('active');
                } else if ($(window).height() + $(window).scrollTop() === $('#container').height()) {
                    $('ul#navigation a.active').removeClass('active');
                    $('ul#navigation a[href^="#"]:last').addClass('active');
                }
            });

            /* tab */
            // first selector
            $('.tab').each(function () {
                $(this).find('ul > li:first').addClass('active');
                $(this).find('div.tab_container > div:first').addClass('active');
            });

            /* toggles */
            $('.toggle h3').click(function () {
                $(this).parent().find('.toggle_data').slideToggle();
            });

            // click functions
            $('.tab > ul > li').click(function () {
                $(this).parent().find('li.active').removeClass('active');
                $(this).addClass('active');

                $(this).parent().parent().find('div.tab_container > div.active').removeClass('active').slideUp();
                $(this).parent().parent().find('div.tab_container > div#' + $(this).attr('id')).slideDown().addClass('active');

                return false;
            });

            var $container = $('div#works').isotope({
                itemSelector: 'img.work',
                layoutMode: 'fitRows'
            });

            // items filter
            $('#works_filter a').click(function () {
                var selector = $(this).attr('data-filter');
                $('div#works').isotope({
                    filter: selector,
                    itemSelector: 'img.work',
                    layoutMode: 'fitRows'
                });

                $('#works_filter').find('a.selected').removeClass('selected');
                $(this).addClass('selected');

                return false;
            });

            //smooth scroll top
            $('.gotop').addClass('hidden');

            $("a.gotop").smoothScroll();

            $('#wrap').waypoint(function (event, direction) {
                $('.gotop').toggleClass('hidden', direction === "up");
            }, {
                offset: '-100%'
            });
            //bind send message here
            $('#submit').click(sendMessage);
        });

        /* Contact Form */
        function checkEmail(email) {
            var check = /^[\w\.\+-]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$/;
            if (!check.test(email)) {
                return false;
            }
            return true;
        }

        function changeImg() {
            var imgSrc = $("#imgObj");
            var src = imgSrc.attr("src");
            imgSrc.attr("src", chgUrl(src));
        }

        function sendMessage() {
            // receive the provided data
            var name = $("input#name").val();
            var email = $("input#email").val();
            var subject = $("input#subject").val();
            var msg = $("textarea#msg").val();

            // check if all the fields are filled
            if (name == '' || name == 'Full Name*' || email == '' || email == 'Email Address*' || subject == '' || subject == 'Subject*' || msg == '' || msg == 'Your Message*') {
                $("div#msgs").html('<p class="warning">你必须输入所有的字段!</p>');

                return false;
            }

            // verify the email address
            if (!checkEmail(email)) {
                $("div#msgs").html('<p class="warning">请输入有效的电子邮件地址!</p>');
                return false;
            }

            // make the AJAX request
            var dataString = $('#cform').serialize();

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/sendMail",
                data: dataString,
                dataType: 'json',
                success: function (data) {
                    if (data.success == 0) {
                        var errors = '<ul><li>';
                        if (data.name_msg != '')
                            errors += data.name_msg + '</li>';
                        if (data.email_msg != '')
                            errors += '<li>' + data.email_msg + '</li>';
                        if (data.message_msg != '')
                            errors += '<li>' + data.message_msg + '</li>';
                        if (data.subject_msg != '')
                            errors += '<li>' + data.subject_msg + '</li>';

                        $("div#msgs").html('<p class="error">无法完成你的请求。请参阅下面的错误!</p>' + errors);
                    }
                    else if (data.success == 1) {
                        changeImg();
                        $("div#msgs").html('<p class="error">您的信息已成功发送!</p>');
                    }else if (data.success == 2) {

                        $("div#msgs").html('<p class="error">验证码错误!</p>');

                    }else if (data.success == 3) {

                        $("div#msgs").html('<p class="error">验证码超时，请点击图片刷新</p>');
                    }

                },
                error: function () {
                    $("div#msgs").html('<p class="error">无法完成你的请求。对不起!</p>');
                }
            });

            return false;
        }</script>
</head>
<body>
<div id="wrap">
    <!-- wrapper -->
    <div id="sidebar">
        <!-- the  sidebar -->
        <!-- logo -->
        <a  href="https://www.gitee.com/litong-zero" id="logo"> <img src="./images/logo.png" alt="李同" /></a>
        <!-- navigation menu -->
        <ul id="navigation">
            <li><img id="headimg" src="images/headimg.jpg"></li>
            <br/>
            <li><a>推荐使用PC端访问</a></li>
            <br/>
            <li><a href="#home" class="active">个人简介</a></li>
            <li><a href="#about">求职期望</a></li>
            <li><a href="#portfolio">项目经历</a></li>
            <li><a href="#skills">教育经历</a></li>
            <li><a href="#internship">实习经历</a></li>
            <li><a href="#certificate">获得奖项</a></li>
            <li><a href="#contact">联系我</a></li>

        </ul>
    </div>
    <div id="container">
        <!-- page container -->
        <div class="page" id="home">
            <!-- page home -->
            <div class="page_content">
                <div class="gf-slider">
                    <!-- slider -->
                    <ul class="slides">
                        <li> <img src="images/01.jpg" alt="" />

                        </li>
                        <li> <img src="images/02.jpg" alt="" />

                        </li>
                        <li> <img src="images/03.jpg" alt="" />
                        </li>
                    </ul>
                </div>
                <div class="space"> </div>
                <div class="clear"> </div>
                <!-- services -->
                <h3 class="page_title"> 个人简介</h3>
                <div class="one_half first">
                    <div class="column_content">
                        <h4> 姓名</h4>
                        <img src="images/name.png" class="left no_border" alt="" style="margin-top: 10px;
                                margin-right: 10px" />
                        <p style="font-size:30px"> 李同</p>
                    </div>
                </div>
                <div class="one_half last">
                    <div class="column_content">
                        <h4> 性别</h4>
                        <img src="images/sex.png" class="left no_border" alt="" style="margin-top: 10px;
                                margin-right: 10px" />
                        <p style="font-size:30px"> 男</p>
                    </div>
                </div>
                <div class="space"> </div>
                <div class="one_half first">
                    <div class="column_content">
                        <h4> 籍贯</h4>
                        <img src="./images/home.png" class="left no_border" alt="" style="margin-top: 10px;
                                margin-right: 10px" />
                        <p style="font-size:30px"> 河北涿州</p>
                    </div>
                </div>
                <div class="one_half last">
                    <div class="column_content">
                        <h4> Git地址</h4>
                        <img src="./images/github.png" class="left no_border" alt="" style="margin-top: 10px;
                                margin-right: 10px" />
                        <p style="font-size:20px"><a href="https://gitee.com/litong-zero"> gitee.com/litong-zero</a></p>
                    </div>
                </div>
                <div class="space"> </div>
                <div class="one_half first">
                    <div class="column_content">
                        <h4> CSDN博客</h4>
                        <img src="./images/csdn.png" class="left no_border" alt="" style="margin-top: 10px;height: 48px;
                                margin-right: 10px" />
                        <p style="font-size:20px"><a href="https://blog.csdn.net/LitongZero"> blog.csdn.net/LitongZero</a></p>

                    </div>
                </div>
                <div class="one_half last">
                    <div class="column_content">
                        <h4> E-mail</h4>
                        <img src="./images/email.png" class="left no_border" alt="" style="margin-top: 10px;
                                margin-right: 10px" />
                        <p style="font-size:20px"> litongzero@163.com</p>
                    </div>

                </div>
                <div class="space"> </div>
                <div class="one_half first">
                    <div class="column_content">
                        <h4> Phone</h4>
                        <img src="./images/phone.png" class="left no_border" alt="" style="margin-top: 10px;
                                margin-right: 10px" />
                        <p style="font-size:20px"> 15201098340</p>
                    </div>
                </div>
                <div class="one_half1">
                    <div class="column_content">
                        <h4> 自我评价</h4>
                        <img src="./images/SelfAssessment.png" class="left no_border" alt="" style="margin-top: 10px;
                                margin-right: 10px" />
                        <p style="font-size:20px"> 在上海有一年的软件开发工作经验，熟练掌握Java、SpringBoot、Mybatis、MySQL、git。</p>
                        <p style="font-size:20px"> 了解会用Vue.js、MongoDB、Redis、HTML、JavaScript、jQuery、CSS、Python、C、Photoshop。</p>
                        <p style="font-size:20px"> 有一定的Linux编程部署项目能力。</p>
                        <p style="font-size:20px"> 在大学任班长一职，有一定的管理能力。</p>
                    </div>

                </div>

                <div class="clear"> </div>
            </div>
        </div>
        <div class="page" id="about">
            <!-- page about -->
            <h3 class="page_title"> 求职期望</h3>
            <div class="page_content">
                <p style="font-size:30px"> 地点：北京 职位：Java工程师，后台开发</p>

                <blockquote><p style="font-size:20px"> 期望薪资：8k-10k</p> </blockquote>
                <div class="clear"> </div>
            </div>
        </div>
        <div class="page" id="portfolio">
            <!-- page portfolio -->
            <h3 class="page_title"> 项目经历</h3>
            <div class="page_content">
                <p style="font-size:25px">项目名称：失物招领  ·  组长</p>
                <blockquote><p style="font-size:20px">项目时间：2017.10-2017.12</p> </blockquote>
                <p style="font-size:20px"> 项目概况：完成度不是很高，只有一些基本的功能。</p>
                <p style="font-size:20px">
                    该项目使用了MVC设计模式，MySQL、Grpc、阿里云服务器等技术制作的一个APP。我主要负责编写Android端、服务器后台和云服务器搭建。</p>
                <blockquote><p style="font-size:20px">项目地址:<a href="https://gitee.com/litong-zero/LifeHttp">gitee.com/litong-zero/LifeHttp</a></p> </blockquote>
                <p style="font-size:20px">项目截图：</p>
                <img class="projectImg" src="image/life1.png">
                <img class="projectImg" src="image/life2.png">
                <img class="projectImg" src="image/life3.png">
                <img class="projectImg" src="image/life4.png">
                <img class="projectImg" src="image/life5.png">
                <img class="projectImg" src="image/life6.png">
                <img class="projectImg" src="image/life7.png">
                <img class="projectImg" src="image/life8.png">

                <div class="clear"> </div>

            </div>
            <div class="page_content">
                <p style="font-size:25px">项目名称：超级课表  ·  组长</p>
                <blockquote><p style="font-size:20px">项目时间：2018.1-2018.2</p> </blockquote>
                <p style="font-size:20px"> 项目概述：完成了大部分功能包括：从定向网页抓取数据，数据解析，数据在云服务器缓存，数据在Android端缓存，Android端定向查找，Android端模糊查询和PC管理终端的部分功能（查删改）。</p>
                <p style="font-size:20px"> 我主要负责：数据存储（Android端Sqlite和云服务器MongDB），Android端后台编写，Android端模糊查询，PC端编写，云服务器搭建部署和项目测试及项目整合。最终实现了,由Android端、PC端、云服务器和网络数据为一体的项目。</p>
                <blockquote>
                    <p style="font-size:20px">项目地址:Android端：<a href="https://gitee.com/litong-zero/SuperSchedule">gitee.com/litong-zero/SuperSchedule</a></p>
                    <p style="font-size:20px">Server端：<a href="https://gitee.com/litong-zero/Server">gitee.com/litong-zero/Server</a></p>
                    <p style="font-size:20px">Pc端：<a href="https://gitee.com/litong-zero/SuperSchedulePC">gitee.com/litong-zero/SuperSchedulePC</a></p>
                </blockquote>
                <p style="font-size:20px">项目截图：</p>
                <img class="projectImg" src="image/super1.png">
                <img class="projectImg" src="image/super2.png">
                <img class="projectImg" src="image/super3.png">
                <img class="projectImg" src="image/super4.png">
                <img class="projectImg" src="image/super5.png">
                <img class="projectImg" src="image/super6.png">
                <img class="projectImg" src="image/super7.png">
                <div class="clear"> </div>

            </div>

            <div class="page_content">
                <p style="font-size:25px">项目名称：基于微信的消息通知和材料收集系统  ·  毕业设计</p>
                <blockquote><p style="font-size:20px">项目时间：2019.1-2019.5</p> </blockquote>
                <p style="font-size:20px"> 项目基本功能、流程已经完成。实现了由后台系统配置群组任务，系统自动下发给制定的微信公众号。微信公众号可接受消息和附件，并可以反馈消息给服务端。服务端的统计模块可以查看目前任务的下发情况以及材料的收集情况。</p>
                <p style="font-size:20px"> 项目使用前后端分离式开发，前端使用Vue.js架构，后端使用SpringBoot+Mybatis+Mysql+Redis完成，文件服务器使用FastDFS。</p>
                <p style="font-size:20px"> 我完成项目的全部任务，前期的需求收集，系统架构设计，数据库设计，项目开发，项目联调，项目测试等。</p>
                <p style="font-size:20px"> 目前项目的前端部署在GiteePages上，后端部署在阿里云上。</p>
                <blockquote>
                    <p style="font-size:20px">项目地址：<a href="http://litong-zero.gitee.io/ltz-vue/">litong-zero.gitee.io/ltz-vue</a></p>
                </blockquote>
                <p style="font-size:20px">项目截图(平台端)：</p>

                <div class="gf-slider">
                    <!-- slider -->
                    <ul class="slides">
                        <li> <img src="image/lw/2.png" alt="" /></li>
                        <li> <img src="image/lw/3.png" alt="" /></li>
                        <li> <img src="image/lw/4.png" alt="" /></li>
                        <li> <img src="image/lw/5.png" alt="" /></li>
                        <li> <img src="image/lw/6.png" alt="" /></li>
                        <li> <img src="image/lw/8.png" alt="" /></li>
                        <li> <img src="image/lw/1.png" alt="" /></li>
                    </ul>
                </div>
                <p style="font-size:20px">项目截图(客户端)：</p>
                <img class="projectImg40" src="image/lw/7.png">
                <img class="projectImg40" src="image/lw/9.png">
                <div class="clear"> </div>

            </div>
        </div>
        <div class="page" id="skills">
            <!-- page skills -->
            <h3 class="page_title"> 教育经历</h3>
            <div class="page_content">
                <p style="font-size:25px">2015.9-2019.6    宜春学院     计算机科学与技术 / 本科</p>

                <div class="clear"> </div>
            </div>
        </div>

        <div class="page" id="internship">
            <!-- page skills -->
            <h3 class="page_title"> 实习经历</h3>
            <div class="page_content">
                <p style="font-size:25px">2018.7-2019.5    上海     上海艾拉比智能科技有限公司 </p>
                <p style="font-size:20px"> 担任“Java开发工程师”</p>
                <p style="font-size:20px"> 工作内容：</p>
                <p style="font-size:20px"> 1、汽车云平台的后端业务开发，承担两个大版本的开发和维护</p>
                <p style="font-size:20px"> 2、平台端接口开发</p>
                <p style="font-size:20px"> 3、前端Vue部分编写</p>
                <p style="font-size:20px"> 4、前后端接口联调</p>
                <p style="font-size:20px"> 5、参与项目需求讨论</p>

                <div class="clear"> </div>
            </div>
        </div>
        <div class="page" id="certificate">
            <!-- page industries -->
            <h3 class="page_title"> 获得奖项</h3>
            <div class="page_content">
                <p style="font-size:20px"> 在校期间，多次获得“先进个人”，“优秀学生奖学金”，“优秀学生干部”，“优秀寝室长”称号</p>
                <p style="font-size:20px"> “失物招领”项目在2017年江西省大学生科技创新与职业技能竞赛中荣获“软件服务外包创新创业”赛项，本科组三等奖。</p>
                <div class="clear"> </div>

                <div class="clear"> </div>
            </div>
        </div>
        <div class="page" id="industries">
            <!-- page industries -->
            <h3 class="page_title"> 一些说明</h3>
            <div class="page_content">
                <p style="font-size:20px"> 之所以两个项目截图都是为Android端的截图，是因为Android端的截图比较好展示，然而像后端服务器，一般不好展示，只能看代码</p>
                <p style="font-size:20px"> 然后，我现在也正在做自己的“小”项目，做完了会继续更新简历......</p>
                <div class="clear"> </div>

                <div class="clear"> </div>
            </div>
        </div>
        <div class="page" id="contact">
            <!-- page contact -->
            <h3 class="page_title"> 联系我(通过下面可直接向我发送信息)</h3>
            <div class="page_content">
                <fieldset id="contact_form">
                    <div id="msgs" style="font-size:20px"> </div>
                    <form id="cform" name="cform" method="post" action="#" >
                        <input type="text"  style="font-size:20px" id="name" name="name" value="名称" onFocus="if(this.value == '名称') this.value = ''"
                               onblur="if(this.value == '') this.value = '名称'" />
                        <input type="text"  style="font-size:20px"id="email" name="email" value="你的邮箱" onFocus="if(this.value == '你的邮箱') this.value = ''"
                               onblur="if(this.value == '') this.value = '你的邮箱'" />
                        <input type="text" style="font-size:20px" id="subject" name="subject" value="主题" onFocus="if(this.value == '主题') this.value = ''"
                               onblur="if(this.value == '') this.value = '主题'" />
                        <textarea id="msg" style="font-size:20px" name="message" onFocus="if(this.value == '信息') this.value = ''"
                                  onblur="if(this.value == '') this.value = '信息'">信息</textarea>


                        <input type="text" style="font-size:20px" id="code" name="code" value="验证码" onFocus="if(this.value == '验证码') this.value = ''"
                               onblur="if(this.value == '') this.value = '验证码'" />
                        <img id="imgObj" src="${pageContext.request.contextPath}/getCode" onclick="changeImg()">
                        <button id="submit" style="font-size:20px" class="button"> 发送</button>
                    </form>
                </fieldset>
                <div class="clear"> </div>
            </div>
        </div>
        <div class="footer">
            <p> &copy; 2019年5月</p>

        </div>
    </div>
</div>
<a class="gotop" href="#top">Top</a>
</body>
</html>
