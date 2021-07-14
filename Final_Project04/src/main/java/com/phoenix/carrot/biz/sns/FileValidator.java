package com.phoenix.carrot.biz.sns;

import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;

import org.springframework.validation.Validator;

import com.phoenix.carrot.dto.sns.EntireBoardDto;

@Service
public class FileValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		
		return false;
	}

	@Override
	public void validate(Object target, Errors errors) {
		/*
		EntireBoardDto file = (EntireBoardDto) target;
		
		if (file.getSnsImg().getSize() == 0) {
			//snsimg에 대한 errorCode return
			
			errors.rejectValue("snsImg", "fileNPE", "Please select a file");
		}
		*/

	}

}
