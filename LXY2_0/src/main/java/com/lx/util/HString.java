package com.lx.util;

import java.lang.reflect.Array;
import java.util.Collection;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串工具类
 * 
 * @author
 * 
 */
public class HString {

	/**
	 * 支持obj
	 * 
	 * @param str
	 *            判断字符串是否为空
	 * @return true is empty ,false is not empty
	 */
	@SuppressWarnings("rawtypes")
	public static boolean isEmpty(Object str) {
		if (str == null)
			return true;
		if (str instanceof String) {
			return String.valueOf(str).trim().isEmpty();
		} else if (str instanceof Map) {
			return ((Map) str).isEmpty();
		} else if (str instanceof Collection) {
			Collection coll = (Collection) str;
			return coll.isEmpty();
		} else if (str.getClass().isArray()) {
			return Array.getLength(str) == 0;
		} else if (str instanceof Long) {
			Long l = (Long) str;
			return l == 0;
		}
		return false;
	}

	/**
	 * 是否是数字
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumber(String str) {
		// "^[-+]?(([0-9]+)([.]([0-9]+))?|([.]([0-9]+))?)$"
		Pattern pattern = Pattern.compile("^[-+]?(([0-9]+)([.]([0-9]+))?|([.]([0-9]+))?)$");
		Matcher isNum = pattern.matcher(str);
		if (isNum.matches()) {
			return true;
		}
		return false;
	}

	/**
	 * 是否是数字
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isInteger(String str) {
		Pattern pattern = Pattern.compile("[0-9]*");
		Matcher isNum = pattern.matcher(str);
		if (isNum.matches()) {
			return true;
		}
		return false;
	}

	/**
	 * 对文本去除HTML标签
	 * 
	 * @param text
	 * @return
	 */
	public static String replaceHTML(String text) {
		if (isEmpty(text))
			return null;
		return text.replaceAll("\t|\r|\n|<[^>]*?>|&nbsp;", "").trim();
	}

	/**
	 * 描述:获得包含中文的字符串长度方法(一个中文为2个字符)
	 * 
	 * @return
	 */
	public static int getTextLength(String text) {
		if (isEmpty(text))
			return 0;
		int len = 0;
		for (int i = 0; i < text.length(); i++) {
			if (text.charAt(i) > 127 || text.charAt(i) == 94) {
				len += 2;
			} else {
				len++;
			}
		}
		return len;
	}

	/**
	 * 判断字符串是否是乱码
	 *
	 * @param strName
	 *            字符串
	 * @return 是否是乱码
	 */
	public static boolean isMessyCode(String text) {
		Pattern p = Pattern.compile("\\s*|t*|r*|n*");
		Matcher m = p.matcher(text);
		String after = m.replaceAll("");
		String temp = after.replaceAll("\\p{P}", "");
		char[] ch = temp.trim().toCharArray();
		float chLength = ch.length;
		float count = 0;
		for (int i = 0; i < ch.length; i++) {
			char c = ch[i];
			if (!Character.isLetterOrDigit(c)) {
				if (!isChinese(c)) {
					count = count + 1;
				}
			}
		}
		float result = count / chLength;
		if (result > 0.4) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
     * 判断字符是否是中文
     *
     * @param c 字符
     * @return 是否是中文
     */
    public static boolean isChinese(char c) {
        Character.UnicodeBlock ub = Character.UnicodeBlock.of(c);
        if (ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS
                || ub == Character.UnicodeBlock.CJK_COMPATIBILITY_IDEOGRAPHS
                || ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS_EXTENSION_A
                || ub == Character.UnicodeBlock.GENERAL_PUNCTUATION
                || ub == Character.UnicodeBlock.CJK_SYMBOLS_AND_PUNCTUATION
                || ub == Character.UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS) {
            return true;
        }
        return false;
    }
	
    
    public static String enANum = "^[\\^\\w+-=*/%&$#@<>(){}\\[\\],.:;\"\'\\\\]*$"; //"^[A-Za-z0-9_]*$";
    public static Pattern enANumPat = Pattern.compile(enANum);
    public static String [] encode = {"GB2312","GBK","ISO-8859-1","UTF-8"};
    public static String cnEx = "[\u4e00-\u9fa5]";
    public static Pattern cnPat = Pattern.compile(cnEx);
	
	public static boolean isEnglishAndNumber(String str) {
		Matcher matcher = null;
		String temp[] = str.split("");
		for (String s : temp) {
			matcher = enANumPat.matcher(s);
			if(!matcher.find()){
				return false;
			}
		}
		return true;
	}

	public static String getUnEncode(String str) throws Exception {
		String newStr = null;
		if (!isEnglishAndNumber(str)) {
			for (int i = 0; i < encode.length; i++) {
				for (int j = 0; j < encode.length; j++) {
					newStr = new String(str.getBytes(encode[i]), encode[j]);
					char temp[] = newStr.toCharArray();
					boolean isAll = true;
					for (char c : temp) {
						if (!isEnglishAndNumber(String.valueOf(c)) && !isChinese(c)) {
							isAll = false;
							break;
						}
					}
					if (isAll) {
						return newStr;
					}
				}
			}
		}
		return str;
	}
    
	public static void main(String[] args) {
		System.out.println(isEmpty(""));
	}
}
