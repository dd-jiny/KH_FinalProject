package com.phoenix.carrot.utils;

import java.awt.image.BufferedImage;

import java.io.File;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnails;

/*
  #서버에 파일을 저장할 때 고려사항
  -동일한 파일명을 저장할 경우 : UUID를 이용하여 고유 값을 생성, 원본파일명 앞에 붙여 중복 분제 해결
  -파일의 단일 저장 경로 : 단일 경로에 계속파일을 저장하게 되면 나중에 파일을 검색하고 찾는데 속도 문제가
  발생할 수 있기 때문에 파일을 날짜별 폴더를 생성해 관리한다. 
  -이미지 파일인 경우 브라우저에 출력할 파일의 크기 : 이미지 파일의 용량이 클 경우, 서버에서 브라우저에
  많은 양의 데이터를 전송하게 되므로 이미지 파일의 축소본, 썸네일을 생성하여 최소한의 데이터를 브라우저에
  전송하도록 처리한다. 
  
  1.유틸클래스로 사용하기 때문에 기본적으로 클래스 내부의 모든 메서드는 static메서드로 선언하여 인스
  턴스 생성 없이 바로 사용이 가능하도록 작성
  
  2. 파일 업로드처리, 삭제, 출력을 위한 httpHeader설정 메소드는 public메소드로 선언하고 파일 업로드 컨트롤러에서
  바로 접근하여 사용이 가능하게 작성 
 */

public class UploadFileUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);
	
	static final int THUMB_WIDTH = 300;
	static final int THUMB_HEIGHT = 300;
	
	public static String fileUpload(String uploadPath, String fileName, byte[] fileData, String ymdPath) throws Exception {
		//UUID 랜덤 번호 작성 
	  UUID uid = UUID.randomUUID();
	  
	  String newFileName = uid + "_" + fileName;
	  String imgPath = uploadPath + ymdPath;

	  File target = new File(imgPath, newFileName);
	  FileCopyUtils.copy(fileData, target);
	  
	  String thumbFileName = "s_" + newFileName;
	  File image = new File(imgPath + File.separator + newFileName);

	  File thumbnail = new File(imgPath + File.separator + "s" + File.separator + thumbFileName);

	  if (image.exists()) {
	   thumbnail.getParentFile().mkdirs();
	   Thumbnails.of(image).size(THUMB_WIDTH, THUMB_HEIGHT).toFile(thumbnail);
	  }
	  return newFileName;
	 }

	 public static String calcPath(String uploadPath) {
	  Calendar cal = Calendar.getInstance();
	  String yearPath = File.separator + cal.get(Calendar.YEAR);
	  String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
	  String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));

	  makeDir(uploadPath, yearPath, monthPath, datePath);
	  makeDir(uploadPath, yearPath, monthPath, datePath + "\\s");

	  return datePath;
	 }

	 private static void makeDir(String uploadPath, String... paths) {

	  if (new File(paths[paths.length - 1]).exists()) { return; }

	  for (String path : paths) {
	   File dirPath = new File(uploadPath + path);

	   if (!dirPath.exists()) {
	    dirPath.mkdir();
	   }
	  }
	 }
	/*
    // 파일 업로드 처리
    public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
        // 중복된 이름의 파일을 저장하지 않기 위해 UUID 키값 생성
        UUID uuid = UUID.randomUUID();
        // 실제 저장할 파일명 = UUID + _ + 원본파일명
        String savedName = uuid.toString() + "_" + originalName;
        // 날짜 경로 = 년 + 월 + 일
        String savedPath = calcPath(uploadPath);
        // 파일 객체 생성 = 기본 저장경로 + 날짜경로 + UUID_파일명
        File target = new File(uploadPath + savedPath, savedName);
        System.out.println("target : " + target);
        // fileData를 파일객체에 복사
        FileCopyUtils.copy(fileData, target);
        // 파일 확장자 추출
        String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);
        // 업로드 파일명 : 썸네일 이미지 파일명 or 일반 파일명
        String uploadFileName = null;
        // 확장자에 따라 썸네일 이미지 생성 or 일반 파일 아이콘 생성
        if (MediaUtils.getMediaType(formatName) != null) {
            // 썸네일 이미지 생성, 썸네일 이미지 파일명
            uploadFileName = makeThumbnail(uploadPath, savedPath, savedName);
        } else {
            // 파일 아이콘 생성,
            uploadFileName = makeIcon(uploadPath, savedPath, savedName);
        }
        // 업로드 파일명 반환
        return uploadFileName;
    }

    // 1. 날짜별 경로 추출
    public static String calcPath(String uploadPath) {
        Calendar calendar = Calendar.getInstance();
        // 년
        String yearPath = File.separator + calendar.get(Calendar.YEAR);
        // 년 + 월
        String monthPath = yearPath + File.separator + new DecimalFormat("00").format(calendar.get(Calendar.MONTH) + 1);
        // 년 + 월 + 일
        String datePath = monthPath + File.separator + new DecimalFormat("00").format(calendar.get(Calendar.DATE));
        // 파일 저장 기본 경로 + 날짜 경로 생성
        makeDir(uploadPath, yearPath, monthPath, datePath);
        // 날짜 경로 반환
        return datePath;
    }

    // 2. 파일 저장 기본 경로 + 날짜 경로 생성
    private static void makeDir(String uploadPath, String... paths) {
        // 기본 경로 + 날짜 경로가 이미 존재 : 메서드 종료
        if (new File(uploadPath + paths[paths.length - 1]).exists()) {
            return;
        }
        // 날짜 경로가 존재 X : 경로 생성을 위한 반복문 수행
        for (String path : paths) {
            // 기본 경로 + 날짜 경로에 해당하는 파일 객체 생성
            File dirPath = new File(uploadPath + path);
            // 파일 객체에 해당하는 경로가 존재 X
            if (!dirPath.exists()) {
                // 경로 생성
                dirPath.mkdir();
            }
        }
    }

    // 3. 썸네일 생성 : 이미지 파일의 경우
    private static String makeThumbnail(String uploadPath, String path, String fileName) throws Exception {
        // BufferedImage : 실제 이미지 X, 메모리상의 이미지를 의미하는 객체
        // 원본 이미지파일을 메모리에 로딩
        BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));
        // 정해진 크기에 맞게 원본이미지를 축소
        BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
        // 썸네일 이미지 파일명
        String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;
        // 썸네일 이미지 파일 객체 생성
        File newFile = new File(thumbnailName);
        // 파일 확장자 추출
        String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
        // 썸네일 파일 저장
        ImageIO.write(destImg, formatName.toUpperCase(), newFile);
        return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
    }

    // 4. 아이콘 생성 : 이미지 파일이 아닐 경우
    private static String makeIcon(String uploadPath, String savedPath, String fileName) throws Exception {
        // 아이콘 파일명 = 기본 저장경로 + 날짜경로 + 구분자 + 파일명
        String iconName = uploadPath + savedPath + File.separator + fileName;
        return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
    }

    // 파일 삭제처리 메서드
    public static void removeFile(String uploadPath, String fileName) {
        // 파일 확장자 추출
        String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
        // 파일 확장자를 통해 이미지 파일인지 판별
        MediaType mediaType = MediaUtils.getMediaType(formatName);
        // 이미지 파일일 경우, 원본파일 삭제
        if (mediaType != null) {
            // 원본 이미지의 경로 + 파일명 추출
            // 날짜 경로 추출
            String front = fileName.substring(0, 12);
            // UUID + 파일명 추출
            String end = fileName.substring(14);
            // 원본 이미지 파일 삭제(구분자 변환)
            new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();
        }
        // 파일 삭제(일반 파일 or 썸네일 이미지 파일 삭제)
        new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
    }
    */
}
