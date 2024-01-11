package metanet.kosa.metanetfinal.reservation.controller;

import java.io.ByteArrayOutputStream;
import java.util.Base64;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

@Controller
public class QrCodeController {
	
	
	@RequestMapping("reservation/ticket/{resId}")
	public String getQrcode(Model model, @PathVariable int resId) throws Exception {

		String text = String.valueOf(resId);
		int width = 150;
		int height = 150;
		
		QRCodeWriter qrCodeWriter = new QRCodeWriter();
		BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);

		ByteArrayOutputStream pngOutputStream = new ByteArrayOutputStream();

		MatrixToImageWriter.writeToStream(bitMatrix, "PNG", pngOutputStream);

		String img = Base64.getEncoder().encodeToString(pngOutputStream.toByteArray());

		
		model.addAttribute("img", img);

		
		return "reservation/ticket";
	}
	
	@GetMapping("/tickets")
	@ResponseBody
	public void printTicket(@RequestParam String payId) {
		
	}



}