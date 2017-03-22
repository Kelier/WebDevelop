<%@ page contentType="image/jpeg"
	import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*"%>
<%!Color getRandColor(int cc, int bb)

	{

		Random random = new Random();
		
		int r = cc + random.nextInt(bb - cc);

		int g = cc + random.nextInt(bb - cc);

		int b = cc + random.nextInt(bb - cc);

		return new Color(r, g, b);

	} //获取随机颜色
%>
<%
	response.setHeader("Pragma", "No-cache");

	response.setHeader("Cache-Control", "no-cache");

	response.setDateHeader("Expires", 0);

	int width = 80; //定义验证码图片的长度

	int height = 30; //定义验证码图片的宽度

	BufferedImage image = new BufferedImage(width, height,
			BufferedImage.TYPE_INT_RGB);

	Graphics g = image.getGraphics();

	Random random = new Random();

	g.setColor(getRandColor(200, 250));

	g.fillRect(0, 0, width, height);

	g.setFont(new Font("Times New Roman", Font.PLAIN, 26));

	//定义字体形式

	g.setColor(getRandColor(160, 200));

	for (int i = 0; i < 155; i++)

	{

		int i_x = random.nextInt(width);

		int i_y = random.nextInt(height);

		int i_xl = random.nextInt(12);

		int i_yl = random.nextInt(12);

		g.drawLine(i_x, i_y, i_x + i_xl, i_y + i_yl);

	}

	//用线条画背景

	String s_Rand = "";

	for (int i = 0; i < 4; i++)

	{

		String rand = String.valueOf(random.nextInt(10));

		s_Rand += rand;

		g.setColor(new Color(20 + random.nextInt(110), 20 + random
				.nextInt(110), 20 + random.nextInt(110)));

		g.drawString(rand, 18 * i + random.nextInt(12), 16+random.nextInt(12));

	}

	//产生4位随机码 

	session.setAttribute("rand", s_Rand);

	//将验证码存入Session中

	g.dispose();

	//输出验证图片

	out.clear();

	out = pageContext.pushBody();

	ImageIO.write(image, "JPEG", response.getOutputStream());
%>