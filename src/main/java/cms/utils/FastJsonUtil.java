package cms.utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.alibaba.fastjson.serializer.SerializerFeature;

public class FastJsonUtil {
	// 生成json
	public static String getJson(Object obj) {
		return JSONObject.toJSONString(obj, SerializerFeature.WriteMapNullValue);
	}

	// 解析Object
	public static <T> T getObject(String json, Class<T> c) {
		T t = null;
		try {
			t = JSON.parseObject(json, c);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return t;
	}

	// 解析List
	public static <T> List<T> getList(String json, Class<T> c) {
		List<T> list = new ArrayList<T>();
		try {
			list = JSON.parseArray(json, c);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 解析List
	public static List<String> getList(String json) {
		List<String> list = new ArrayList<String>();
		try {
			list = JSON.parseArray(json, String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 解析List
	public static List<Map<String, Object>> getListMap(String json) {
		try {
			return JSON.parseObject(json, new TypeReference<List<Map<String, Object>>>() {

			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static <T> void writeJson2File(T t, String filePath) throws IOException {
		writeJson2File(t, new File(filePath));
	}

	public static <T> void writeJson2File(T t, File file) throws IOException {
		String jsonStr = JSONObject.toJSONString(t, SerializerFeature.PrettyFormat);
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file)));
		bw.write(jsonStr);
		bw.close();
	}

	public static <T> T readFile2Json(Class<T> cls, String filePath) throws IOException {
		return readFile2Json(cls, new File(filePath));
	}

	public static <T> T readFile2Json(Class<T> cls, File file) throws IOException {
		StringBuilder strBuilder = new StringBuilder();
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
		String line = null;
		while ((line = br.readLine()) != null) {
			strBuilder.append(line);
		}
		br.close();
		return JSONObject.parseObject(strBuilder.toString(), cls);
	}

	public static <T> T readFile2Json(TypeReference<T> typeReference, String filePath) throws IOException {
		return readFile2Json(typeReference, new File(filePath));
	}

	public static <T> T readFile2Json(TypeReference<T> typeReference, File file) throws IOException {
		StringBuilder strBuilder = new StringBuilder();
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
		String line = null;
		while ((line = br.readLine()) != null) {
			strBuilder.append(line);
		}
		br.close();
		return JSONObject.parseObject(strBuilder.toString(), typeReference);
	}
}
