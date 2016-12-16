package com.lx.util;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.lx.util.XConst;
import com.lx.util.HString;

@SuppressWarnings({ "rawtypes", "unchecked" })
public class PageData extends HashMap implements Map {

	private Long insertPK;

	// public Object data = null;

	private static final long serialVersionUID = 1L;

	Map map = null;
	HttpServletRequest request;

	public PageData(HttpServletRequest request) {
		this.request = request;
		Map properties = request.getParameterMap();
		Map returnMap = new HashMap();
		Iterator entries = properties.entrySet().iterator();
		Map.Entry entry;
		String name = "";
		String value = "";
		while (entries.hasNext()) {
			entry = (Map.Entry) entries.next();
			name = (String) entry.getKey();
			Object valueObj = entry.getValue();
			if (null == valueObj) {
				value = "";
			} else if (valueObj instanceof String[]) {
				String[] values = (String[]) valueObj;
				for (int i = 0; i < values.length; i++) {
					value = values[i] + ",";
				}
				value = value.substring(0, value.length() - 1);
			} else {
				value = valueObj.toString();
			}
			returnMap.put(name, value);
		}
		map = returnMap;
	}

	public PageData() {
		map = new HashMap();
	}

	/**
	 * true :创建带有statue默认值的数据 <br>
	 * 默认为fail
	 * 
	 * @param isResult
	 */
	public PageData(boolean isResult) {
		map = new HashMap();
		if (isResult) {
			map.put(XConst.STATUS_KEY, XConst.FAIL);
			map.put(XConst.FlAG, false);
		}
	}

	@Override
	public Object get(Object key) {
		Object obj = null;
		if (map.get(key) instanceof Object[]) {
			Object[] arr = (Object[]) map.get(key);
			obj = request == null ? arr : (request.getParameter((String) key) == null ? arr : arr[0]);
		} else {
			obj = map.get(key);
		}
		return obj;
	}
	
	public Object[] getObjectArr(Object key){
		return (Object[]) map.get(key);
	}

	public Long getLong(Object key) {
		if (HString.isEmpty(get(key)))
			return null;
		return Long.valueOf(get(key).toString());
	}

	public Integer getInt(Object key) {
		if (HString.isEmpty(get(key)))
			return null;
		return Integer.parseInt(get(key).toString());
	}

	public String getString(Object key) {
		if (HString.isEmpty(get(key)))
			return null;
		return get(key).toString();
	}

	public Double getDouble(Object key) {
		if (HString.isEmpty(get(key)))
			return null;
		return Double.valueOf(get(key).toString());
	}

	@Override
	public Object put(Object key, Object value) {
		return map.put(key, value);
	}

	/**
	 * 更改返回状态
	 * 
	 * @param value
	 * @return
	 */
	public Object putStatus(Object value) {
		return map.put(XConst.STATUS_KEY, value);
	}

	@Override
	public Object remove(Object key) {
		return map.remove(key);
	}

	public void clear() {
		map.clear();
	}

	public boolean containsKey(Object key) {
		return map.containsKey(key);
	}

	public boolean containsValue(Object value) {
		return map.containsValue(value);
	}

	public Set entrySet() {
		return map.entrySet();
	}

	public boolean isEmpty() {
		return map.isEmpty();
	}

	public Set keySet() {
		return map.keySet();
	}

	public void putAll(Map t) {
		map.putAll(t);
	}

	public int size() {
		return map.size();
	}

	public Collection values() {
		return map.values();
	}

	public Long getInsertPK() {
		return insertPK;
	}

	public void setInsertPK(Long insertPK) {
		this.insertPK = insertPK;
	}

	public void putFlag(boolean flag) {
		map.put(XConst.FlAG, flag);
	}

	public void putMessage(String message) {
		map.put(XConst.MESSAGE, message);
	}

	private Map<String, Object> data = new HashMap<String, Object>();

	public void putData(String key, Object value) {
		data.put(key, value);
		map.put("data", data);
	}

	public Map<String,Object> getData() {
		return data;
	}

	public boolean getBoolean(String key) {
		return Boolean.parseBoolean(getString(key));
	}

	// public void setData(Object data) {
	// this.data = data;
	// }
}
