package com.phoenix.carrot.admin.dto;

public class WeatherDto {
	
	private String dataTime;
	private String sidoName;
	private String stationName;
	private String khaiGrade;
	private String pm10Grade;
	private String pm25Grade;
	
	public WeatherDto() {
		
	}
	
	public WeatherDto(String dataTime, String sidoName, String stationName, String khaiGrade, String pm10Grade,
			String pm25Grade) {
		this.dataTime = dataTime;
		this.sidoName = sidoName;
		this.stationName = stationName;
		this.khaiGrade = khaiGrade;
		this.pm10Grade = pm10Grade;
		this.pm25Grade = pm25Grade;
	}
	public String getdataTime() {
		return dataTime;
	}
	public void setdataTime(String dataTime) {
		this.dataTime = dataTime;
	}
	public String getSidoName() {
		return sidoName;
	}
	public void setSidoName(String sidoName) {
		this.sidoName = sidoName;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getKhaiGrade() {
		return khaiGrade;
	}
	public void setKhaiGrade(String khaiGrade) {
		this.khaiGrade = khaiGrade;
	}
	public String getPm10Grade() {
		return pm10Grade;
	}
	public void setPm10Grade(String pm10Grade) {
		this.pm10Grade = pm10Grade;
	}
	public String getPm25Grade() {
		return pm25Grade;
	}
	public void setPm25Grade(String pm25Grade) {
		this.pm25Grade = pm25Grade;
	}

}
