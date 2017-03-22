<%@ page contentType="image/jpeg" import="java.awt.*,
java.awt.image.*,java.util.*,javax.imageio.*" %>
<%
// 在内存中创建图象

int width=100, height=32;
BufferedImage image = new BufferedImage(width, height,
BufferedImage.TYPE_INT_RGB);

// 获取图形上下文

Graphics g = image.getGraphics();

// 设定背景色

g.setColor(new Color(0xDCDCDC));
g.fillRect(0, 0, width, height);

//画边框

g.setColor(Color.black);
g.drawRect(0,0,width-1,height-1);

// 随机产生的认证码(4位数字)
String rand=String.valueOf(1000+(int)(9000*Math.random ()));
String rand_num=String.valueOf(10+(int)(90*Math.random ()));
Integer tempNumber = new Integer(rand_num);
String numberStr = tempNumber.toString();
int arithmetic = (int)(2*Math.random ());
// 将认证码存入SESSION

//session.setAttribute("rand",rand_num);

// 将认证码显示到图象中

g.setColor(Color.black);

g.setFont(new Font("Atlantic Inline",Font.PLAIN,20));
String r1=numberStr.substring(0,1);
g.drawString("2",17,25);
if(arithmetic==0){
	g.drawString("+",38,23);
}else{
	g.drawString("-",38,23);
}
String r2 = numberStr.substring(1,2);
g.drawString("3",62,20);


//String Str = numberStr.substring(0,1);
//g.drawString(Str,17,25);
/*Str = numberStr.substring(1,2);
g.drawString(Str,38,23);
Str = numberStr.substring(2,3);
g.drawString(Str,62,20);

Str = numberStr.substring(3,4);
g.drawString(Str,83,27); */

// 随机产生88个干扰点，使图象中的认证码不易被其它程序探测 到

Random random = new Random();
for (int i=0;i<32;i++)
{
int x = random.nextInt(width);
int y = random.nextInt(height);
g.drawOval(x,y,0,0);
}

// 图象生效

g.dispose();

// 输出图象到页面
out.clear();
	out = pageContext.pushBody();
ImageIO.write(image, "JPEG", response.getOutputStream ());
//在页面上调用 <img src="/yourPath/checkNum.jsp" />


%>
