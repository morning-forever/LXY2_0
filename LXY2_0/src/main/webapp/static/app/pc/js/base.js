/**
 * 
 * 毫秒数转时间字符串
 * 
 */ 
var getTimeTxt=function(mmSecond,length){
	var t = new Date(mmSecond);
	var r=t.getFullYear()+"-";
	r+=(t.getMonth()+1>=10?t.getMonth()+1:"0"+(t.getMonth()+1));
	r+="-"+(t.getDate()>=10?t.getDate():"0"+t.getDate());
	if(length==10){
		return r;
	}
	r+=" "+(t.getHours()>=10?t.getHours():"0"+t.getHours());
	r+=":"+(t.getMinutes()>=10?t.getMinutes():"0"+t.getMinutes());
	
	if(length==16){
		return r;
	}
	
	r+=":"+(t.getSeconds()>=10?t.getSeconds():"0"+t.getSeconds());
	if(length==19){
		return r;
	}
}

/**
 ** 加法函数，用来得到精确的加法结果
 ** 说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
 ** 调用：accAdd(arg1,arg2)
 ** 返回值：arg1加上arg2的精确结果
 **/
function accAdd(arg1, arg2) {
    var r1, r2, m, c;
    try {
        r1 = arg1.toString().split(".")[1].length;
    }
    catch (e) {
        r1 = 0;
    }
    try {
        r2 = arg2.toString().split(".")[1].length;
    }
    catch (e) {
        r2 = 0;
    }
    c = Math.abs(r1 - r2);
    m = Math.pow(10, Math.max(r1, r2));
    if (c > 0) {
        var cm = Math.pow(10, c);
        if (r1 > r2) {
            arg1 = Number(arg1.toString().replace(".", ""));
            arg2 = Number(arg2.toString().replace(".", "")) * cm;
        } else {
            arg1 = Number(arg1.toString().replace(".", "")) * cm;
            arg2 = Number(arg2.toString().replace(".", ""));
        }
    } else {
        arg1 = Number(arg1.toString().replace(".", ""));
        arg2 = Number(arg2.toString().replace(".", ""));
    }
    return (arg1 + arg2) / m;
}

//给Number类型增加一个add方法，调用起来更加方便。
Number.prototype.add = function (arg) {
    return accAdd(arg, this);
};

function accSub(arg1, arg2) { 

	    var r1, r2, m, n;
	try {
		r1 = arg1.toString().split(".")[1].length
	} catch (e) {
		r1 = 0
	}
	try {
		r2 = arg2.toString().split(".")[1].length
	} catch (e) {
		r2 = 0
	}
	m = Math.pow(10, Math.max(r1, r2));
	n = (r1 >= r2) ? r1 : r2;
	return ((arg1 * m - arg2 * m) / m).toFixed(n); 
} 
//给Number类型增加一个add方法，调用起来更加方便。 
Number.prototype.sub = function(arg) { 
    return accSub(this, arg); 
}
/**
 ** 乘法函数，用来得到精确的乘法结果
 ** 说明：javascript的乘法结果会有误差，在两个浮点数相乘的时候会比较明显。这个函数返回较为精确的乘法结果。
 ** 调用：accMul(arg1,arg2)
 ** 返回值：arg1乘以 arg2的精确结果
 **/
function accMul(arg1, arg2) {
	var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
	try {
		m += s1.split(".")[1].length;
	} catch (e) {
	}
	try {
		m += s2.split(".")[1].length;
	} catch (e) {
	}
	return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
}

// 给Number类型增加一个mul方法，调用起来更加方便。
Number.prototype.mul = function (arg) {
    return accMul(arg, this);
};

/** 
 ** 除法函数，用来得到精确的除法结果
 ** 说明：javascript的除法结果会有误差，在两个浮点数相除的时候会比较明显。这个函数返回较为精确的除法结果。
 ** 调用：accDiv(arg1,arg2)
 ** 返回值：arg1除以arg2的精确结果
 **/
function accDiv(arg1, arg2) {
	var t1 = 0, t2 = 0, r1, r2;
	try {
		t1 = arg1.toString().split(".")[1].length;
	} catch (e) {
	}
	try {
		t2 = arg2.toString().split(".")[1].length;
	} catch (e) {
	}
	with (Math) {
		r1 = Number(arg1.toString().replace(".", ""));
		r2 = Number(arg2.toString().replace(".", ""));
		return (r1 / r2) * pow(10, t2 - t1);
	}
}

// 给Number类型增加一个div方法，调用起来更加方便。
Number.prototype.div = function (arg) {
    return accDiv(this, arg);
};
/**
 ** 减法函数，用来得到精确的减法结果
 ** 说明：javascript的减法结果会有误差，在两个浮点数相减的时候会比较明显。这个函数返回较为精确的减法结果。
 ** 调用：accSub(arg1,arg2)
 ** 返回值：arg1加上arg2的精确结果
 **/
function accSub(arg1, arg2) {
	var r1, r2, m, n;
	try {
		r1 = arg1.toString().split(".")[1].length;
	} catch (e) {
		r1 = 0;
	}
	try {
		r2 = arg2.toString().split(".")[1].length;
	} catch (e) {
		r2 = 0;
	}
	m = Math.pow(10, Math.max(r1, r2)); // last modify by deeka //动态控制精度长度
	n = (r1 >= r2) ? r1 : r2;
	return ((arg1 * m - arg2 * m) / m).toFixed(n);
}

// 给Number类型增加一个mul方法，调用起来更加方便。
Number.prototype.sub = function (arg) {
    return accSub(this,arg);
};


/**
 * 
 * 验证字段
 * 
 * <br>
 * 
 * 1.当参数为4个的时候：<br>
 * stOrLen表示最少长度，ed 表示最大长度，regx正则 2.当参数为3个的时候：<br>
 * 如果ed:是数字 stOrLen表示最小长度，ed 表示最大长度 如果ed:是正则 stOrLen表示长度，ed 是正则 3.当参数为2个的时候：<br>
 * stOrLen 是数字表示长度 stOrLen 是正则表示正则
 */
var checkField = function(fv, stOrLen, ed, regx) {

	if (typeof (stOrLen) == 'number' && typeof (ed) == 'number') {
		if (stOrLen >= ed)
			console.info("最小长度不能大于结束长度");
	}

	if (fv != null && fv != '' && fv.length != 0 && fv != 'undefined')
		if (arguments.length == 4) {
			if (fv.length >= stOrLen && fv.length <= ed)
				if (regx)
					if (regx.test(fv))
						return true;
		} else if (arguments.length == 3) {
			if (typeof (ed) == 'number') {
				if (fv.length >= stOrLen && fv.length <= ed)
					return true;
			} else {
				if (fv.length == stOrLen)
					if (ed)
						if (ed.test(fv))
							return true;
			}
		} else if (arguments.length == 2) {
			if (stOrLen && typeof (stOrLen) == 'number') {
				if (fv.length == stOrLen)
					return true;
			} else if (stOrLen) {
				if (stOrLen.test(fv))
					return true;
			}
		} else if (arguments.length == 1) {
			return true;
		}
	return false;
};

//校验邮箱格式
function checkEmail(fv){
	if(checkField(fv, new RegExp('^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$'))){
		return true;
	}
	return false;
}

//校验手机号格式
function checkPhone(fv){
	if(checkField(fv, new RegExp('^[1][34578][0-9]{9}$'))){
		return true;
	}
	return false;
}

/**
 * 调取显示验证form 弹框
 */
var valTips = function(obj, errStr) {
	if (typeof (obj) == 'object') {
		$(obj).tips({
			side : 2,
			msg : errStr,
			bg : '#AE81FF',
			time : 3
		});
		$(obj).focus();
	} else {
		$("#" + obj).tips({
			side : 2,
			msg : errStr,
			bg : '#AE81FF',
			time : 3
		});
		$("#" + obj).focus();
	}
};

var serializeObject = function(form) {
	var o = {};
	$.each(form.serializeArray(), function(index) {
		if (o[this["name"]]) {
			o[this["name"]] = o[this["name"]] + "," + this["value"];
		} else {
			o[this["name"]] = this["value"];
		}
	});
	return o;
};

// 表单元素
function selfDefineFormBtn() {
	// radio
	$(".radio").click(function() {
		var _name = $(this).attr("name");
		$("[name=" + _name + "]").removeClass("radioed");
		$(this).addClass("radioed");
	});

	// 下拉框
	$(".select-item .select-text").each(function() {
		if ($(this).next("select").find("option:selected").length != 0) {
			$(this).text($(this).next("select").find("option:selected").text());
		}
	});
	$(".select-item select").change(function() {
		var _val = $(this).find("option:selected").text();
		$(this).parent(".select-item").find(".select-text").text(_val);
	});

	// 日期时间下拉框
	$(".date_time_select").click(function() {
		var _name = $(this).attr("name");
		if ($("#" + _name + "_val").hasClass("current")) {
			$("#" + _name + "_val").slideUp(400).removeClass("current");
		} else {
			if ($(".selectval_list.current").length == 1) {
				$(".selectval_list.current").removeClass("current").slideUp();
			}
			$("#" + _name + "_val").slideDown(400).addClass("current");
		}
	});
	// 选择日期时间
	$(".selectval_list li").click(function() {
		var _val = $(this).html();
		var _name = $(this).parent("ul").attr("id").split("_val")[0];
		$("[name=" + _name + "] .select-text").html(_val);
		$(this).parent("ul").slideUp(400).removeClass("current");
	});

	// checkbox
	$(".checkbox,.checkbox-s,.i-check").click(function() {
		if ($(this).hasClass("checked")) {
			$(this).removeClass("checked");
		} else {
			$(this).addClass("checked");
		}
	});

	// radio sex-select
	$(".sex .checkbox").click(function() {
		$(this).addClass("checked");
		$(this).parent().siblings().children("i").removeClass("checked");
	});

	// 开关控制
	$(".Button").click(function() {
		$(".Button i.active").removeClass("active").siblings().addClass("active");
	});
	// 通知中心
	$(".inf_list li p").click(function() {
		$(this).parent().siblings("li").removeClass("active");
		$(this).parent().siblings("li").find("div.letter").css({
			"display" : "none"
		});
		var $lip = $(this).parent();
		var $that = $(this).parent().find("div.letter");
		if ($lip.hasClass("active")) {
			$lip.removeClass("active");
			$that.slideUp();
		} else {
			$lip.addClass("active");
			$that.slideDown();
		}
	})
}

// 格式化日期2015年07月29日
function formatDate(objD) {
	var y = objD.getFullYear();
	var m = objD.getMonth() + 1;
	var d = objD.getDate();
	return y + '年' + ((m > 9) ? m : '0' + m) + '月' + ((d > 9) ? d : '0' + d) + '日';
}

/* 左右点击切换列表 */
function HorizontalList() {
	var liW = $(".inner_list li").outerWidth(true);
	var li_len = $(".inner_list li").length;
	var ulW = liW * li_len;
	var viewW = $(".inner_wrap").width();
	$(".inner_list").width(liW * li_len);
	$(".scroll_wrap .scroll_left,.scroll_wrap .scroll_right").click(function() {
		if ($(".inner_list").is(":animated"))
			return;
		var marginL = parseInt($(".inner_list").css("margin-left"));
		if ($(this).hasClass("scroll_left")) { // 左滑动
			$(".scroll_wrap .scroll_right").removeClass("disabled");
			if (marginL + 186 >= 0) {
				$(".inner_list").animate({
					"marginLeft" : 0
				}, 300);
				$(this).addClass("disabled");
			} else {
				$(".inner_list").animate({
					"marginLeft" : marginL + 186
				}, 300);
			}
		} else { // 右滑动
			$(".scroll_wrap .scroll_left").removeClass("disabled");
			if (marginL - 186 <= viewW - ulW) {
				$(".inner_list").animate({
					"marginLeft" : viewW - ulW
				}, 300);
				$(this).addClass("disabled");
			} else {
				$(".inner_list").animate({
					"marginLeft" : marginL - 186
				}, 300);
			}
		}
	});
}

// stopPropagation
function stopPropagation(e) {
	var e = e || window.event;
	if (e.stopPropagation) {
		e.stopPropagation();
	} else {
		e.cancelBubble = true;
	}
}

// popbox
function popBoxInit() {
	if ($(".popbox").length != 0) {
		$(".haspopbox").click(function(e) {
			stopPropagation(e);
			$(this).find(".popbox").show();
		});
		$(".popbox .i-close").click(function(e) {
			stopPropagation(e);
			$(this).parent(".popbox").hide();
		});
		$(".popbox .spanwrap span").click(function(e) {
			var _text = $(this).text();
			stopPropagation(e);
			$(this).parent(".spanwrap").find("span.current").removeClass("current");
			$(this).addClass("current");
			if ($(this).parent(".spanwrap").hasClass("showvalue")) {
				$(this).parents(".haspopbox").find(".select-text").text(_text);
			}
		});
		$(document).click(function() {
			$(".popbox").hide();
		});
	}
}

// 日历控件汉化
// 添加中文语言
;
/*(function($) {
	if(typeof($.fn.datetimepicker) != 'undefined'){
		$.fn.datetimepicker.dates['zh-CN'] = {
			days : [ "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日" ],
			daysShort : [ "周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日" ],
			daysMin : [ "日", "一", "二", "三", "四", "五", "六", "日" ],
			months : [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月" ],
			monthsShort : [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月" ],
			today : "今天",
			clear:"全天",
			suffix : [],
			meridiem : [ "上午", "下午" ]
		};
	}
}(jQuery));*/

/**
 * 描述：点击click事件提交表单，跳转页面，兼容所有的浏览器
 * 
 * @param url
 *            链接的URL
 * @param jsonObj
 *            参数对象json ｛"a":b,"c":d,"d":[数组]｝
 */
function subWebForm(url, jsonObj, t) {
	var fid = "form_open_win", obj = $("#" + fid);
	if (obj && obj != null) {
		obj.remove();
	}
	t = t && t != "" ? "_blank" : "_self";
	method = jsonObj.method && jsonObj.method != '' ? jsonObj.method : "post";
	delete jsonObj.method;
	var form = null;
	try {
		form = document.createElement("<form  method='" + method + "'></form>");
	} catch (e) {
	}
	if (form == null) {
		form = document.createElement("form");
		form.method = method;
	}
	$("body").append(form);
	obj = $(form);
	obj.hide();
	var tj = null;
	$.each(jsonObj, function(key, val) {
		tj = jsonObj[key];
		if (tj instanceof Array) {
			$.each(tj, function(i, value) {
				var tempClone = null;
				try {
					tempClone = document.createElement("<input type='checkbox' name='" + key + "' />");
				} catch (e) {
				}
				if (tempClone == null) {
					tempClone = document.createElement("input");
					tempClone.type = "checkbox";
				}
				$(tempClone).attr({
					"checked" : true,
					"name" : key
				}).val(value);
				obj.append(tempClone);
			});
		} else {
			var tempClone = null;
			try {
				tempClone = document.createElement("<input type='text' name='" + key + "' />");
			} catch (e) {
			}
			if (tempClone == null) {
				tempClone = document.createElement("input");
				tempClone.type = "text";
			}
			$(tempClone).attr({
				"name" : key
			}).val(val);
			obj.append(tempClone);
		}
	});
	url = url && url != null ? url : '/';
	obj.attr({
		"action" : url,
		"target" : t,
		"id" : fid
	}).submit();

}

function outLogin() {
	$.ajax({
		url : sys.basePath+'pc/login/outLogin',
		type : 'post',
		success : function(req) {
			if (req.status == 'success') {
				$.cookie('password', null, {
					path : '/pc'
				});
				window.location.href=sys.basePath+"pc/home";
			}
			
		}
	});
}

//银行卡号验证规则(参数：银行名称和银行卡号)
function checkBankNo(bankName, bankNo){
	var flag = false;
	if(checkField(bankName) && checkField(bankNo)){
		//建设银行
		var jianshe = ["436728", "436742", "453242", "491031", "53242", "53243", "5453242", "5491031", "553242", "5544033",
		               "544033", "622707", "622725", "622728", "622700", "621284", "625955", "625956", "621700", "622966",
		               "622988", "421349", "434061", "434062", "524094", "526410", "552245", "589970", "620060", "621080",
		               "621081", "621082", "621466", "621467", "621488", "621499", "621598", "622280", "621621", "544887",
		               "557080", "436718", "436745", "489592", "532450", "532458", "436738", "436748", "552801", "558895",
		               "559051", "622168", "628266", "628366", "622708", "622166", "531693", "356895", "356896", "356899",
		               "625964", "625965", "625966", "622381", "622675", "622676", "622677", "621083", "622382", "621487", "621084"];
		//中国银行
		var zhongguo = ["621660", "621661", "621662", "621663", "621665", "621667", "621668", "621669", "621666", "625908", "625910",
		                "625909", "356833", "356835", "409665", "409666", "409668", "409669", "409670", "409671", "409672", "456351",
		                "512315", "512316", "512411", "512412", "514957", "409667", "518378", "518379", "518474", "518475", "518476",
		                "438088", "524865", "525745", "525746", "547766", "552742", "553131", "558868", "514958", "622752", "622753",
		                "622755", "524864", "622757", "622758", "622759", "622760", "622761", "622762", "622763", "601382", "622756",
		                "628388", "621256", "621212", "620514", "622754", "622764", "518377", "622765", "622788", "621283", "620061",
		                "621725", "620040", "558869", "621330", "621331", "621332", "621333", "621297", "377677", "621568", "621569",
		                "625905", "625906", "625907", "621756", "621757", "621758", "621759", "621785", "621786", "621787", "621788",
		                "621789", "621790", "621620", "620025", "620026", "621293", "621294", "621342", "621343", "621364", "621394",
		                "621648", "621248", "621215", "621249", "622273", "622274", "622750", "622751", "622771", "622772", "622770",
		                "625145", "620531", "620210", "620211", "620019", "620035", "621231", "622789", "621638", "621334", "625140",
		                "621395", "620513", "621741", "623040", "620202", "620203", "622346", "622347", "622348", "621041"];
		//交通银行
		var jiaotong = ["620021", "620521", "00405512", "0049104", "0053783", "00601428", "405512", "434910", "458123", "458124",
		               "49104", "520169", "522964", "53783", "552853", "601428", "622250", "622251", "521899", "622254", "622255",
		                "622256", "622257", "622258", "622259", "622253", "622261", "622284", "622656", "628216", "622252",
		                "66405512", "6649104", "622260", "66601428", "955590", "955591", "955592", "955593", "6653783",
		                "628218", "622262", "621002", "621069", "620013", "625028", "625029", "621436", "621335"];
		//工商银行
		var gongshang = ["370246", "370248", "370249", "427010", "427018", "427019", "427020", "427029", "427030", "427039", "370247", "438125", 
		                 "438126", "451804", "451810", "451811", "45806", "458071", "489734", "489735", "489736", "510529", "427062", "524091", 
		                 "427064", "530970", "53098", "530990", "558360", "620200", "620302", "620402", "620403", "620404", "524047", "620406", 
		                 "620407", "525498", "620409", "620410", "620411", "620412", "620502", "620503", "620405", "620408", "620512", "620602", 
		                 "620604", "620607", "620611", "620612", "620704", "620706", "620707", "620708", "620709", "620710", "620609", "620712", 
		                 "620713", "620714", "620802", "620711", "620904", "620905", "621001", "620902", "621103", "621105", "621106", "621107", 
		                 "621102", "621203", "621204", "621205", "621206", "621207", "621208", "621209", "621210", "621302", "621303", "621202", 
		                 "621305", "621306", "621307", "621309", "621311", "621313", "621211", "621315", "621304", "621402", "621404", "621405", 
		                 "621406", "621407", "621408", "621409", "621410", "621502", "621317", "621511", "621602", "621603", "621604", "621605", 
		                 "621608", "621609", "621610", "621611", "621612", "621613", "621614", "621615", "621616", "621617", "621607", "621606", 
		                 "621804", "621807", "621813", "621814", "621817", "621901", "621904", "621905", "621906", "621907", "621908", "621909", 
		                 "621910", "621911", "621912", "621913", "621915", "622002", "621903", "622004", "622005", "622006", "622007", "622008", 
		                 "622010", "622011", "622012", "621914", "622015", "622016", "622003", "622018", "622019", "622020", "622102", "622103", 
		                 "622104", "622105", "622013", "622111", "622114", "622200", "622017", "622202", "622203", "622208", "622210", "622211", 
		                 "622212", "622213", "622214", "622110", "622220", "622223", "622225", "622229", "622230", "622231", "622232", "622233", 
		                 "622234", "622235", "622237", "622215", "622239", "622240", "622245", "622224", "622303", "622304", "622305", "622306", 
		                 "622307", "622308", "622309", "622238", "622314", "622315", "622317", "622302", "622402", "622403", "622404", "622313", 
		                 "622504", "622505", "622509", "622513", "622517", "622502", "622604", "622605", "622606", "622510", "622703", "622715", 
		                 "622806", "622902", "622903", "622706", "623002", "623006", "623008", "623011", "623012", "622904", "623015", "623100", 
		                 "623202", "623301", "623400", "623500", "623602", "623803", "623901", "623014", "624100", "624200", "624301", "624402", 
		                 "62451804", "62451810", "62451811", "6245806", "62458071", "6253098", "623700", "628288", "624000", "955888", "628286", 
		                 "622206", "621225", "526836", "513685", "543098", "458441", "620058", "621281", "622246", "900000", "544210", "548943", 
		                 "370267", "621558", "621559", "621722", "621723", "620086", "621226", "402791", "427028", "427038", "548259", "356879", 
		                 "356880", "356881", "356882", "524374", "528856", "550213", "621618", "620516", "621227", "621288", "621721", "900010", 
		                 "625330", "625331", "625332", "623062", "622236", "625929", "621376", "620054", "620142", "621428", "625939", "625930", 
		                 "621761", "621749", "621300", "621378", "625114", "622159", "621720", "625021", "625022", "625932", "621379", "620114", 
		                 "620146", "622889", "625900", "622944", "622949", "625915", "625916", "620030", "622171", "621240", "621724", "625931", 
		                 "621762", "625113", "621371", "620143", "620149", "621730", "625928", "621414", "625914", "621375", "620187", "621734", 
		                 "621433", "625986", "621370", "625925", "622926", "622927", "622928", "622929", "622930", "622931", "621733", "621732", 
		                 "620124", "620183", "625921", "621764", "625926", "621372", "622158", "625917", "621765", "620094", "620186", "625922", 
		                 "621369", "621763", "625934", "620046", "621750", "625933", "621377", "620148", "620185", "625920", "621367", "625924", 
		                 "621374", "621731", "621781", "625017", "625018", "625019", "621423", "625927"];
		//中国邮政储蓄银行
		var youzheng = ["621096", "621098", "622150", "622151", "622181", "622188", "622199", "955100", "621095", "620062", "621285", "620529",
		                "621798", "621799", "621797", "62215049", "62215050", "62215051", "62218850", "62218851", "62218849", "621599",
		                "621622", "622812", "622810", "622811", "628310", "621674"];
		//中国招商银行
		var zhaoshang = ["356885", "356886", "356887", "356888", "356890", "402658", "410062", "439188", "439227", "468203", "479228", "479229",
		                 "512425", "521302", "524011", "356889", "545620", "545621", "545947", "545948", "552534", "552587", "622575", "622576",
		                 "622577", "622578", "622579", "622580", "545619", "622581", "622582", "622588", "622598", "622609", "690755", "690755",
		                 "95555", "545623", "621286", "620520", "621483", "621485", "621486", "370285", "370286", "370287", "370289", "439225",
		                 "518710", "518718", "628362", "439226", "628262", "621299"];
		//民生银行
		var minsheng = ["407405", "421869", "421870", "421871", "512466", "528948", "552288", "517636", "556610", "545392", "545393", "545431",
		                "545447", "622617", "622622", "622615", "622619", "472067", "421393", "472068", "472067", "421393", "472068", "622600",
		                "622601", "628258", "464580", "356858", "356857", "356856", "356859", "464581", "427571", "427570", "421865", "415599",
		                "553161", "545217", "523952", "622602", "622621", "622616", "622603", "377155", "377153", "377152", "377158", "622620",
		                "622623", "625913", "625912", "625911", "622618"];
		//兴业银行
		var xingye = ["549633", "552398", "548738", "625087", "625086", "625085", "625082", "625083", "625084", "451290", "451289", "524070",
		              "523036", "622902", "622901", "461982", "486494", "486493", "486861", "528057", "527414", "90592", "622909", "966666",
		              "625962", "625961625960", "625963", "438589", "438588", "622908", "622922", "628212"];
		//中国农业银行
		var nongye = ["95595", "95596", "95597", "95598", "95599", "622840", "622844", "622847", "622848", "622845", "622826", "622827",
		              "622841", "103", "622824", "622825", "622823", "622846", "622843", "622849", "622821", "622822", "621671", "620501",
		              "622828", "621619", "620059", "623018", "623206", "621282", "621336"];
		//中信银行
		var zhongxin = ["518212", "556617", "558916", "433666", "520108", "403393", "514906", "433669", "433668", "433667", "404157", "404174",
		                "404173", "404172", "400360", "403391", "403392", "404158", "404159", "404171", "621773", "621767", "621768", "621770",
		                "621772", "622689", "622688", "622680", "622679", "622678", "356392", "356391", "356390", "376968", "376969", "376966",
		                "433670", "433671", "433680", "968807", "968808", "968809", "628208", "628209", "628206", "442729", "442730", "622690",
		                "622691", "622998", "622999", "621771", "620082", "622692", "622698", "622696"];
		//中国光大银行
		var guangda = ["622663", "622664", "622665", "622666", "622667", "622669", "622670", "622671", "622672", "622668", "622661", "622674",
		               "90030", "622673", "622660", "622662", "356837", "356838", "356839", "356840", "486497", "425862", "625978", "625980",
		               "625979", "625981", "625977", "625976", "625975", "628201", "628202", "406254", "406252", "622655", "620518", "621489",
		               "621492", "303481699", "524090", "543159", "620085", "622161", "622570", "622650", "622658", "622685", "622659", "622687", "622657"];
		
		if(bankName == '中国建设银行'){
			flag = checkBankIsContain(jianshe, bankNo);
		}else if(bankName == '中国银行'){
			flag = checkBankIsContain(zhongguo, bankNo);
		}else if(bankName == '中国交通银行'){
			flag = checkBankIsContain(jiaotong, bankNo);
		}else if(bankName == '中国工商银行'){
			flag = checkBankIsContain(gongshang, bankNo);
		}else if(bankName == '中国邮政储蓄银行'){
			flag = checkBankIsContain(youzheng, bankNo);
		}else if(bankName == '中国招商银行'){
			flag = checkBankIsContain(zhaoshang, bankNo);
		}else if(bankName == '民生银行'){
			flag = checkBankIsContain(minsheng, bankNo);
		}else if(bankName == '兴业银行'){
			flag = checkBankIsContain(xingye, bankNo);
		}else if(bankName == '中国农业银行'){
			flag = checkBankIsContain(nongye, bankNo);
		}else if(bankName == '中信银行'){
			flag = checkBankIsContain(zhongxin, bankNo);
		}else if(bankName == '中国光大银行'){
			flag = checkBankIsContain(guangda, bankNo);
		}
	}
	return flag;
}

//检验输入的字符串是否包含此开头
function checkBankIsContain(arr, str){
	for(var i = 0; i < arr.length; i++){
		if(str.indexOf(arr[i]) == 0){
			return true;
		}
	}
	return false;
}

Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	// millisecond
	}
	if (/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
	return format;
}

/*
 * ! [类]弹出框
 */
function dialogBox(configparam) {
	this.config = {
		selfClass : "", // 弹出框自定义样式
		contentHtml : "", // 弹出框内容
		title : "", // 弹出框标题
		popupBoxW : 0, // 弹出框自定义宽度
		popupBoxH : 0, // 弹出框自定义高度
		okFunc : null, // 确认操作
		cancelFunc : null, // 取消操作
		initEvent : null, // 初始化事件绑定
		closeBtnshow : true,
		coverhide : true, // 默认点击黑色透明背景隐藏弹出框
		noCover : false,
		hasTitle:true
	// 默认有遮罩层
	};
	if (configparam) {
		$.extend(this.config, configparam);
	}
	// 弹出框结构Html
	var _frameHtml = '<div class="popup-wrap none">\
	<div class="popup-cover"></div>\
	<div class="popup-case">\
		<span class="btn-span btn-close abs"></span>\
		<h3 class="popup-title"></h3>\
		<div class="popup-cent">\
		</div></div>\
	</div>';
	var _self = this;
	this.curDlg = $(_frameHtml);
	$("body").append(this.curDlg);

	this.curDlg.find(".popup-cent").html(this.config.contentHtml);

	if (this.config.title) {
		this.curDlg.find(".popup-title").html(this.config.title);
	}
	if (!this.config.hasTitle){
		this.curDlg.find(".popup-title").remove();
	}
	if (!this.config.closeBtnshow) {
		this.curDlg.find(".btn-close").remove();
	}
	if (this.config.noCover) {
		this.curDlg.find(".popup-cover").remove();
	}

	if (this.config.selfClass) { // 自定义样式
		this.curDlg.addClass(this.config.selfClass);
	}
	if (this.config.popupBoxW) {
		this.curDlg.find(".popup-case").width(this.config.popupBoxW);
	}
	if (this.config.popupBoxH) {
		var centHeight = this.config.popupBoxH - this.curDlg.find(".popup-title").height();
		this.curDlg.find(".popup-case").height(this.config.popupBoxH);
		this.curDlg.find(".popup-cent").css({
			height : centHeight,
			"max-height" : centHeight
		});
	}
	if (_self.config.initEvent) {
		_self.config.initEvent(_self.curDlg);
	}

	this.reSetBox();

	this.curDlg.find("[name='case-ok']").unbind("click").bind("click", function() {
		_self.curDlg.hide();
		if (_self.config.okFunc && typeof _self.config.okFunc == "function") {
			_self.config.okFunc(_self.curDlg);
		}
		_self.renewDoc();
	});
	this.curDlg.find("[name='case-no']").unbind("click").bind("click", function() {
		_self.curDlg.hide();
		if (_self.config.cancelFunc && typeof _self.config.cancelFunc == "function") {
			_self.config.cancelFunc(_self.curDlg);
		}
		_self.renewDoc();
	});
	this.curDlg.find(".btn-close").unbind("click").bind("click", function() {
		_self.hideDlg();
	});
	if (this.config.coverhide) {
		this.curDlg.find(".popup-cover").unbind("click").bind("click", function() {
			_self.hideDlg();
		});
	}
}

/**
 * 弹出框原型 方法
 */
dialogBox.prototype = {
	showDlg : function(showFunc) {
		if (showFunc && typeof showFunc == "function") { // 自定义处理
			showFunc(this.curDlg);
		}
		this.curDlg.show();
		this.reSetBox();
//		$("html,body").css("overflow", "hidden");
	},
	removeDlg : function(removeFunc) {
		if (removeFunc && typeof removeFunc == "function") { // 自定义处理
			removeFunc(this.curDlg);
		}
		this.curDlg.remove();
	},
	
	hideDlg : function(hideFunc) {
		if (hideFunc && typeof hideFunc == "function") { // 自定义处理
			hideFunc(this.curDlg);
		}
		this.curDlg.hide();
		this.renewDoc();
	},
	refreshBoxContent : function(_content) {
		this.curDlg.find(".popup-cent").html(_content);
	},
	reSetBox : function() {
		var DlgTrueW = this.curDlg.find(".popup-case").outerWidth();
		var DlgTrueH = this.curDlg.find(".popup-case").outerHeight();
		this.curDlg.find(".popup-case").css({
			marginTop : -DlgTrueH / 2,
			marginLeft : -DlgTrueW / 2
		});
	},
	renewDoc : function() {
		if (!$(".popup-wrap:visible").length) {
//			$("html,body").css("overflow-y", "auto");
		}

	}
};

