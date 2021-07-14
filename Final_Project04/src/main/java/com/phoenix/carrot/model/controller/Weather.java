package com.phoenix.carrot.model.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.phoenix.carrot.admin.dto.WeatherDto;

@Service
public class Weather {
	private static final String HOST_URL = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?serviceKey=okJR2mnA1Rzmmk7CjZYkoyCo5Rl8TOuU4%2FIbVsOhh%2F6aZSGHZ1TQ%2BcHnM0LxasBAl7RZv5glsiirPyxly%2FjMAA%3D%3D&returnType=json&numOfRows=100&pageNo=1&sidoName=%EC%84%9C%EC%9A%B8&ver=1.0";
	public List<WeatherDto> get() {
		//System.out.println("sdfgdg");
		List<WeatherDto> list = new ArrayList<WeatherDto>();
		
		HttpURLConnection conn = null;

		try {
			URL url = new URL(HOST_URL);

			conn = (HttpURLConnection)url.openConnection();
			conn.setConnectTimeout(5000);
			conn.setReadTimeout(5000);
			conn.setRequestMethod("GET");
			//conn.setDoOutput(true);

			int responseCode = conn.getResponseCode();
			if (responseCode == 400 || responseCode == 401 || responseCode == 500 ) {
				System.out.println(responseCode + " Error!");
			} else {
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String line = "";
				String aaaaa = "";
				while ((line = br.readLine()) != null) {
					aaaaa += line;
				}
				//System.out.println("aaaaa" + aaaaa);

				JsonElement element = JsonParser.parseString(aaaaa);

				JsonObject jsondata = element.getAsJsonObject();

				JsonElement records = jsondata.get("response");
				jsondata = records.getAsJsonObject();
				JsonElement body = jsondata.get("body");
				jsondata = body.getAsJsonObject();
				JsonElement items = jsondata.get("items");
				JsonArray recordsArray = items.getAsJsonArray();

				System.out.println(responseCode);
				WeatherDto dto = new WeatherDto();
				for (int i = 0; i < recordsArray.size(); i++) {

					String dataTime = recordsArray.get(i).getAsJsonObject().get("dataTime").getAsString();
					String sidoName = recordsArray.get(i).getAsJsonObject().get("sidoName").getAsString();
					String stationName = recordsArray.get(i).getAsJsonObject().get("stationName").getAsString();
					String khaiGrade = recordsArray.get(i).getAsJsonObject().get("khaiGrade").getAsString();
					String pm10Grade = recordsArray.get(i).getAsJsonObject().get("pm10Grade").getAsString();
					String pm25Grade = recordsArray.get(i).getAsJsonObject().get("pm25Grade").getAsString();
					
					System.out.println(stationName);
					dto.setdataTime(dataTime);
					dto.setKhaiGrade(khaiGrade);
					dto.setPm10Grade(pm10Grade);
					dto.setPm25Grade(pm25Grade);
					dto.setSidoName(sidoName);
					dto.setStationName(stationName);
					System.out.println("dust" + list);
					list.add(dto);
				}
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			System.out.println("not JSON Format response");
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
