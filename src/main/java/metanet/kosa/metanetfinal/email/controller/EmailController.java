package metanet.kosa.metanetfinal.email.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import metanet.kosa.metanetfinal.email.service.EmailService;

@Controller
public class EmailController {

    @Autowired
    EmailService emailService;

    @PostMapping("/send-email")
    public String sendEmail(
            @RequestParam("name") String name,
            @RequestParam("emailForReply") String emailForReply,
            //@RequestParam("senderEmail") String senderEmail, //사용자로부터 이메일을 받아서 사용자의 이메일로 메일을 보내도록 처리하고 싶을 때 활용
            //@RequestParam("senderPassword") String senderPassword,
            @RequestParam("subject") String subject,
            @RequestParam("text") String text
    ) {
        emailService = new EmailService(name, subject, text);
        emailService.send(name, emailForReply, subject, text);

        // Create a SimpleMailMessage
//        SimpleMailMessage message = new SimpleMailMessage();
//        message.setText(subject);
//        message.setFrom(name);
//        message.setTo("shb0801@naver.com"); // Your email address
//        message.setSubject(subject);
//        message.setText("From: " + name + "\nEmail: " + email + "\n\n" + subject);

        // Send the email
//        javaMailSender.send(message);

        // Redirect to a thank you page or another appropriate page
        return "home"; // You can create a "thankyou.html" template
    }
}
