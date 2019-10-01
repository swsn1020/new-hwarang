package hwarang.artg.funding.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import hwarang.artg.common.model.AttachFileDTO;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
public class UploadController {

    @GetMapping("/uploadForm")
    public void uploadForm() {
    }

    @PostMapping("/uploadFormAction")
    public void uploadFormPost(MultipartFile[] uploadFile, Model model){

        String uploadFolder = "C:\\upload";

        for (MultipartFile multipartFile : uploadFile) {
           
            File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());

            try {
                multipartFile.transferTo(saveFile);
            } catch (Exception e) {
            }
        }//end for
    }//end uploadFormPost

    @GetMapping("/uploadAjax")
    public void uploadAjax() {
    }

    // 년/월/일 폴더 만들기
    private String getFolder() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        return str.replace("-", File.separator);
    }
    // 이미지 파일 판단
    private boolean checkImageType(File file) {
        try {
            String contentType = Files.probeContentType(file.toPath());
            return contentType.startsWith("image");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    @PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {

        List<AttachFileDTO> list = new ArrayList<>();
        String uploadFolder = "C:\\upload";
        String uploadFolderPath = getFolder();

        //make folder ---
        File uploadPath = new File(uploadFolder, uploadFolderPath);

        if (!uploadPath.exists()) {
            uploadPath.mkdirs();
        }

        for (MultipartFile multipartFile : uploadFile) {
            AttachFileDTO attachFileDTO = new AttachFileDTO();
            String uploadFileName = multipartFile.getOriginalFilename();

            //IE has file path
            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
            attachFileDTO.setFileName(uploadFileName);

            UUID uuid = UUID.randomUUID();
            uploadFileName = uuid.toString() + "_" + uploadFileName;

            try {
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);

                attachFileDTO.setUuid(uuid.toString());
                attachFileDTO.setUploadPath(uploadFolderPath);

                if (checkImageType(saveFile)) {
                    attachFileDTO.setImage(true);
                    FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
                    Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
                    thumbnail.close();
                }

                // add to List -> return
                list.add(attachFileDTO);

            } catch (Exception e) {
            } // end try
        } // end for

        return new ResponseEntity<>(list, HttpStatus.OK);
    } // end uploadAjaxPost

    @GetMapping("/display")
    @ResponseBody
    public ResponseEntity<byte[]> getFile(String fileName) {
        File file = new File("c:\\upload\\" + fileName);

        ResponseEntity<byte[]> result = null;

        try {
            HttpHeaders header = new HttpHeaders();
            header.add("Content-Type", Files.probeContentType(file.toPath()));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }// end getFile()

    @GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    @ResponseBody
    public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
        Resource resource = new FileSystemResource("c:\\upload\\" + fileName);

        if (!resource.exists()) return new ResponseEntity<>(HttpStatus.NOT_FOUND);

        String resourceName = resource.getFilename();
        String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
        HttpHeaders headers = new HttpHeaders();

        try {
            String downloadName = null;

            if (userAgent.contains("Trident")) {
                downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
            } else if (userAgent.contains("Edge")) {
                downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
            } else {
                downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
            }

            headers.add("Content-Disposition", "attachment; filename=" + downloadName);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }//end try
        return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
    }// end downloadFile()

    @PostMapping("/deleteFile")
    @ResponseBody
    public ResponseEntity<String> deleteFile(String fileName, String type) {
        File file;
        try {
            file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
            file.delete();
            if (type.equals("image")) {
                String largeFileName = file.getAbsolutePath().replace("s_", "");
                file = new File(largeFileName);
                file.delete();
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<String>("delete", HttpStatus.OK);
    }
}