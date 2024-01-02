package metanet.kosa.metanetfinal.email.service;

import jakarta.activation.DataHandler;
import jakarta.activation.FileDataSource;
import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.io.File;
import java.util.Properties;

import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class EmailService {
	 // 1. 계정 정보를 입력하고 encoding 설정을 합니다.
    String name = ""; // Sender name
    String senderEmail = "shb0801@naver.com"; //메일을 발송하는 이메일계정 아이디
    String senderPassword = "skaehdDN12!@"; //메일을 발송하는 이메일 계정 비밀번호
    String receiverEmail = "shb080101@naver.com"; //이메일을 전송받을 계정
    //String senderEmail = "";   // Sender Email (만약 사용자의 이메일로 이메일을 보내도록 설정하고 싶다면 활용)
    //String senderPassword = "";       // Sender Password (만약 사용자의 이메일로 이메일을 보내도록 설정하고 싶다면 활용)
    String subject = ""; // mail subject
    String text = ""; // mail text
    String ENC_TYPE = "EUC-KR";           // Content Encoding

    private Properties prop;    // SMTP Setting information
    
    public EmailService() {}; //default 생성자
    
    public EmailService(String name, String subject, String text) {
        this.name = name;
        this.subject = subject;
        this.text = text;
        this.prop = getProperties();
    }

    // 2. 아까 확인했던 SMTP 정보를 기입합니다.
    private Properties getProperties() {
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.naver.com");
        prop.put("mail.smtp.port", 587);
        prop.put("mail.smtp.auth", "true");


        return prop;
    }

    // 3. SMTP정보를 기반으로 인증을 받아 Session을 생성합니다.
    private Session getSession() {
        return  Session.getDefaultInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword); //만약 사용자의 이메일로 발송하려면 여기 코드 인자를 수정해준다.
            }
        });
    }

    // 4. Mail을 전송하는 부분입니다.
    public void send(String name, String emailForReply, String subject, String text) {
        try {
            Session session = getSession();
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            // Receiver mail
            message.addRecipient(Message.RecipientType.TO, new InternetAddress("shb080101@naver.com")); // 이메일 받는 계정 입력
            // Suject
            message.setSubject(subject);
            // Text
            MimeBodyPart content = new MimeBodyPart();
            content.setText(name + "(" + emailForReply + ") 님이 문의 메일을 보내셨습니다. \n\n문의내용 : " + text);

            // Write contents(Text & File)
            Multipart mp = new MimeMultipart();
            mp.addBodyPart(content);
            message.setContent(mp);

            // Send the message
            Transport.send(message);
            log.info("전송에 성공했습니다");
        } catch (Exception e) {
            log.info("전송에 실패했습니다");
            e.printStackTrace();
        }
    }


    public void sendWithPDF(String pdfPath) {
        try {
            Session session = getSession();
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            // Receiver mail
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiverEmail)); // 이메일 받는 계정 입력
            // Suject
            message.setSubject("제목");
            // Text
            MimeBodyPart content = new MimeBodyPart();
            content.setText("내용");
            // Attach pdf File
            File pdf = new File(pdfPath);
            MimeBodyPart attach = new MimeBodyPart();
            // 아래 fds는 설명드린 PDF 첨부를 위한 코드입니다.
            FileDataSource fds = new FileDataSource(pdf.getAbsolutePath()); // Load PDF
            attach.setDataHandler(new DataHandler(fds));
            attach.setFileName(MimeUtility.encodeText(fds.getName(), ENC_TYPE, "B"));

            // Write contents(Text & File)
            Multipart mp = new MimeMultipart();
            mp.addBodyPart(content);
            mp.addBodyPart(attach);
            message.setContent(mp);

            // Send the message
            Transport.send(message);
            System.out.println("전송 완료!");
        } catch (Exception e) {
            System.out.println("전송 실패!");
            e.printStackTrace();
        }
    }
}
